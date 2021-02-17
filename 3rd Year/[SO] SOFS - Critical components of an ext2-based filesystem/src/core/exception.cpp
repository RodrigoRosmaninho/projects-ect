/*
 * \file
 * \brief the sofs19 exception support
 * \author Artur Pereira - 2016-2019
 */

#include <exception>

#include <stdio.h>
#include <string.h>

#include "exception.h"

namespace sofs19
{
    /*
     * \brief sofs19 exception data type
     */
    SOException::SOException(int _en, const char *_func) 
            : en(_en), func(_func)
    {
        sprintf(msg, "\e[01;31m%s: error %d (%s)\e[0m", func, en, strerror(en));
    }

    const char *SOException::what() const throw()
    {
        return msg;
    }
};
