import os
import sys
import OpenSSL.crypto as osc
import cryptography.x509 as x509
from datetime import datetime
from asn1crypto import pem
import requests
import traceback
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.serialization import load_der_public_key
from cryptography.hazmat.primitives.asymmetric import (padding, rsa, utils)
from cryptography.hazmat.primitives.serialization import Encoding
try:
    from PyKCS11 import *
    from PyKCS11.LowLevel import *
except Exception as e:
    print('Could not import PyKCS11: %s'%(e))

def load_from_url(url):
    response = requests.get(url)
    if response.status_code == 200:
        return response.content

    return None

def validate_ocsp(cert):
    print('\tOCSP validation not yet implemented')

def add_crl(root, cert, base = False, delta = False):
    c = x509.load_der_x509_certificate(osc.dump_certificate(osc.FILETYPE_ASN1, cert))
    if base:
        cdp = c.extensions.get_extension_for_oid( x509.oid.ExtensionOID.CRL_DISTRIBUTION_POINTS)
    elif delta:
        cdp = c.extensions.get_extension_for_oid(x509.oid.ExtensionOID.FRESHEST_CRL)
    else:
        return
    for dpoint in cdp.value:
        for url in dpoint.full_name :
            print('\t%s'%(url.value))
            crl = osc.load_crl(osc.FILETYPE_ASN1, load_from_url(url.value))
            root.add_crl(crl)

def validate_chain(cert_pem, date):

    # Create validation context (a X509Store object )

    root = osc.X509Store()

    # Set validation flags

    root.set_flags(osc.X509StoreFlags.X509_STRICT)

    # Set validation date

    root.set_time(date)

    intermediate = []

    # Load certificates into validation context

    with open('cert_chain.pem', 'rb') as cf:
        cf_bytes = cf.read()

        if pem.detect(cf_bytes):
            for _, _, der_bytes in pem.unarmor(cf_bytes, multiple = True):
                cert = osc.load_certificate(osc.FILETYPE_ASN1, der_bytes)
                if cert.get_subject() == cert.get_issuer():
                    root.add_cert(cert)
                else:
                    intermediate.append(cert)
        else:
            cert = osc.load_certificate(osc.FILETYPE_ASN1, der_bytes)
            if cert.subject == cert.issuer:
                root.add_cert(cert)
            else:
                intermediate.append(cert)

    # Load certificate to validate

    cert = osc.load_certificate(osc.FILETYPE_PEM, cert_pem)
    
    validator = osc.X509StoreContext(root, cert, intermediate)

    try :
        validator.verify_certificate()

        # Chain was build , let 's do OCSP / CRL some checking
        chain = validator.get_verified_chain()

        # See what we have in the chain certificates

        for cert in chain:
            # print CN field of certificate 's subject

            # Look in extension for OCSP / CRL information

            for i in range(0, cert.get_extension_count()):
                # print('\textension: %s' %(cert.get_extension(i).get_short_name()))
                #try :
                if cert.get_extension(i).get_short_name() == b'authorityInfoAccess':
                    validate_ocsp(cert)
                elif cert.get_extension(i).get_short_name() == b'crlDistributionPoints':
                    add_crl(root, cert, base = True)
                elif cert.get_extension(i).get_short_name() == b'freshestCRL':
                    add_crl(root, cert, delta = True)
                #except osc.Error:
                #    continue

        # Set validation flags to include CRL validations

        root.set_flags(osc.X509StoreFlags.CRL_CHECK_ALL)

        validator.verify_certificate()
    except Exception as e:
        #traceback.print_exc()
        pass

