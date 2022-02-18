import numpy as np
# import time
# import sys
import warnings
import joblib
import gc

# import matplotlib.mlab as mlab
# import matplotlib.pyplot as plt

from sklearn import metrics
from sklearn.linear_model import LinearRegression, LogisticRegression, SGDClassifier, RidgeClassifier, PassiveAggressiveClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.gaussian_process import GaussianProcessClassifier
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis, QuadraticDiscriminantAnalysis
from sklearn.neighbors import KNeighborsRegressor, KNeighborsClassifier, LocalOutlierFactor
from sklearn.svm import LinearSVC, SVC, OneClassSVM
from sklearn.tree import DecisionTreeRegressor, DecisionTreeClassifier, ExtraTreeClassifier
from sklearn.ensemble import RandomForestRegressor, AdaBoostClassifier, BaggingClassifier, GradientBoostingClassifier, RandomForestClassifier, ExtraTreesClassifier, IsolationForest
from xgboost import XGBRegressor, XGBClassifier
from sklearn.neural_network import MLPClassifier

from sklearn.preprocessing import MinMaxScaler
from sklearn.decomposition import PCA

from sklearn.inspection import permutation_importance

from numpy import mean, std

# from sklearn.model_selection import LeaveOneOut
from sklearn.model_selection import cross_val_score, GridSearchCV
from sklearn.metrics import accuracy_score, precision_score, recall_score, confusion_matrix, f1_score

warnings.filterwarnings('ignore')

debug = True
training_perc = 0.5 # has to be 50% for the GridCV (cross-validation) to run

def breakTrainTest(data,nSamp=25000, trainPerc=0.5):
    np.random.shuffle(data)
    nSamp_o,nCols=data.shape
    nSamp = min(nSamp, nSamp_o)
    if nSamp % 2 != 0:
        data = data[:-1,:]
        nSamp -= 1
    order=np.random.permutation(nSamp)
    data=data[:nSamp,:]

    
    nTrain=int(nSamp*trainPerc)
    
    data_train=data[order[:nTrain],:]
    data_test=data[order[nTrain:],:]

    return(data_train,data_test)

def extractFeatures(data,Class=0):
    nObs,nCols=data.shape
    return (data, np.ones((nObs,1))*Class)

# get a list of models to evaluate
def get_model_list(crossval=False):
    models = []

    if not crossval:
        # models.append(LogisticRegression(max_iter=1000))
        # models.append(RidgeClassifier())
        # models.append(SGDClassifier())
        # models.append(PassiveAggressiveClassifier())
        models.append(KNeighborsClassifier())
        models.append(XGBClassifier())
        models.append(ExtraTreeClassifier())
        # models.append(LinearSVC())
        # models.append(SVC(kernel='linear'))
        # models.append(SVC(kernel='rbf'))
        # models.append(SVC(kernel='poly'))
        # models.append(GaussianNB())

        models.append(BaggingClassifier())
        # models.append(GaussianProcessClassifier()) # OOM Killer speedrun
        # models.append(GradientBoostingClassifier())
        # models.append(LinearDiscriminantAnalysis())
        # models.append(QuadraticDiscriminantAnalysis())
        # models.append(MLPClassifier(solver='adam',hidden_layer_sizes=(64,),max_iter=100000))

    models.append(DecisionTreeClassifier(random_state=197, max_depth=15, min_samples_leaf= 1, min_samples_split= 2))
    # models.append(AdaBoostClassifier(random_state=37, base_estimator=DecisionTreeClassifier(random_state=197, max_depth= 15, min_samples_leaf= 1, min_samples_split= 2)))
    models.append(RandomForestClassifier(random_state=37, n_estimators=20, min_samples_leaf=1, min_samples_split=2, max_depth=20))
    models.append(ExtraTreesClassifier(random_state=37, n_estimators=20, min_samples_leaf=1, min_samples_split=5, max_depth=None))

    return models

# evaluate the model using a given cross-validation model and scoring condition
def crossvalidate_model(cv, model, X, y):
    # evaluate the model
    scores = cross_val_score(model, X, y.reshape((len(y),)), scoring='accuracy', cv=cv, n_jobs=-1)
    # return scores
    return mean(scores), std(scores), max(scores), min(scores)

def crossvalidate_model_params(cv, model, X_train, y_train, X_test, y_test):
    # evaluate the model

    params = {
        "n_estimators": [1,2,4,8,16,20],
        "max_depth": [3,5,10,15,20,None],
        'max_features': [5, 6, 8, 10, None],
        "min_samples_split": [2,5,7,10],
        "min_samples_leaf": [1,2,5],

    }

    if type(model) is DecisionTreeClassifier:
        params.pop("n_estimators")
    elif type(model) is AdaBoostClassifier:
        params.pop("n_estimators")
        params.pop("max_features")

    grid_cv = GridSearchCV(model, params, n_jobs=-1, cv=cv).fit(X_train, y_train.ravel())

    est = grid_cv.best_estimator_
    paramsr = grid_cv.best_params_
    score = grid_cv.best_score_
    acc_score_train = accuracy_score(y_train, grid_cv.predict(X_train))
    acc_score_test = accuracy_score(y_test, grid_cv.predict(X_test))
    avg_prec_train = precision_score(y_train, grid_cv.predict(X_train), average='weighted')
    avg_prec_test = precision_score(y_test, grid_cv.predict(X_test), average='weighted')
    recall_train = recall_score(y_train, grid_cv.predict(X_train), average='weighted')
    recall_test = recall_score(y_test, grid_cv.predict(X_test), average='weighted')
    print(type(model).__name__)
    print(f"Best params:\n{paramsr}\n")
    print(f"Best CV score           :  {score}")
    print("Weighted accuracy score : ", acc_score_test)
    print("Weighted precision score: ", avg_prec_test)
    print("Weighted recall score   : ", recall_test)
    print()

    return est, paramsr, score, acc_score_train, acc_score_test, avg_prec_train, avg_prec_test, recall_train, recall_test

########### Main Code #############

Classes={0:'DoH',1:'HTTPS Browsing',2:'DNS Tunneling'}#,3:'DNS Exfiltration'}

yt=np.loadtxt('doh_alt.dat')
browsing=np.loadtxt('https_browsing.dat')
mining=np.loadtxt('doh_dnstun_alt.dat') # use doh_dnstun_comb.dat if 'dnsexf' is on!
# dnsexf=np.loadtxt('doh_dnsexfil_tr.dat')


doh_train,doh_test=breakTrainTest(yt, trainPerc=training_perc)
browsing_train,browsing_test=breakTrainTest(browsing, trainPerc=training_perc)
doht_train,doht_test=breakTrainTest(mining, trainPerc=training_perc)
# dnsexf_train,dnsexf_test=breakTrainTest(dnsexf, trainPerc=training_perc)

trainFeatures_doh,oClass_doh=extractFeatures(doh_train,Class=0)
trainFeatures_browsing,oClass_browsing=extractFeatures(browsing_train,Class=1)
trainFeatures_doht,oClass_doht=extractFeatures(doht_train,Class=2)
# trainFeatures_dnsexf,oClass_dnsexf=extractFeatures(dnsexf_train,Class=3)

# get 2D classes and joint features (training set)
trainFeatures=np.vstack((trainFeatures_doh,trainFeatures_browsing))
o2trainClass=np.vstack((oClass_doh,oClass_browsing))#,oClass_doht))
i2trainFeatures=trainFeatures

# get classes and joint features (training set)
trainFeatures2=np.vstack((trainFeatures_doh,trainFeatures_browsing,trainFeatures_doht))#,trainFeatures_dnsexf))
o3trainClass=np.vstack((oClass_doh,oClass_browsing,oClass_doht))#,oClass_dnsexf))
i3trainFeatures=trainFeatures2

# get classes and joint featueres (test set)
if training_perc != 1.0:
    testFeatures_doh,oClass_doh=extractFeatures(doh_test,Class=0)
    testFeatures_browsing,oClass_browsing=extractFeatures(browsing_test,Class=1)
    testFeatures_doht,oClass_doht=extractFeatures(doht_test,Class=2)
    # testFeatures_dnsexf,oClass_dnsexf=extractFeatures(dnsexf_test,Class=3)
    testFeatures=np.vstack((testFeatures_doh,testFeatures_browsing,testFeatures_doht))#,testFeatures_dnsexf))

    o3testClass=np.vstack((oClass_doh,oClass_browsing,oClass_doht))#,oClass_dnsexf))
    i3testFeatures=testFeatures

## normalize data
# i2trainScaler = MinMaxScaler().fit(i2trainFeatures)
# i2trainFeaturesN=i2trainScaler.transform(i2trainFeatures)
i2trainFeaturesN = i2trainFeatures


# i3trainScaler = MinMaxScaler().fit(i3trainFeatures)
# i3trainFeaturesN=i3trainScaler.transform(i3trainFeatures)
i3trainFeaturesN = i3trainFeatures

if training_perc != 1.0:
    i3AtestFeaturesN = i3testFeatures
    i3CtestFeaturesN = i3testFeatures
    # i3AtestFeaturesN=i2trainScaler.transform(i3testFeatures)
    # i3CtestFeaturesN=i3trainScaler.transform(i3testFeatures)

## apply PCA - statistical decomposition of the set to speedup training process ##
pca = PCA(n_components=8, svd_solver='full')

i2trainPCA=pca.fit(i2trainFeaturesN)
i2trainFeaturesNPCA = i2trainPCA.transform(i2trainFeaturesN)

i3trainPCA=pca.fit(i3trainFeaturesN)
i3trainFeaturesNPCA = i3trainPCA.transform(i3trainFeaturesN)

if training_perc != 1.0:
    i3AtestFeaturesNPCA = i2trainPCA.transform(i3AtestFeaturesN)
    i3CtestFeaturesNPCA = i3trainPCA.transform(i3CtestFeaturesN)

# test/validation, results or generate pre-trained model

comparison = (training_perc != 1.0)

if debug:
    features_ytf,oClass_dohf=extractFeatures(yt,Class=0)
    features_browsingf,oClass_browsingf=extractFeatures(browsing,Class=1)
    features_miningf,oClass_dohtf=extractFeatures(mining,Class=2)
    featuresf=np.vstack((features_ytf,features_browsingf,features_miningf))
    oClassf=np.vstack((oClass_dohf,oClass_browsingf,oClass_dohtf))
    oClassf=oClassf.reshape((len(oClassf, )))

    from sklearn.preprocessing import MaxAbsScaler
    i3Scalerf = MaxAbsScaler().fit(featuresf)  
    i3FeaturesNf=i3Scalerf.transform(featuresf)

    # get the list of models to consider
    models = get_model_list(crossval=True)
    # evaluate models
    for model in models:
        res = crossvalidate_model_params(5, model, i3trainFeaturesN, o3trainClass, i3CtestFeaturesN, o3testClass)

        del model
        gc.collect()
elif comparison:
    print('\n-- Anomaly Detection based on Isolation Forest (PCA) --\n')
    isf = IsolationForest()
    isf.fit(i2trainFeaturesNPCA)
    LT = isf.predict(i3AtestFeaturesNPCA)

    true_pred = 0
    nObsTest,nFea=i3AtestFeaturesNPCA.shape
    for i in range(nObsTest):
        true_pred += int(o3testClass[i][0] == LT[i])
    print("Accuracy:", 1-(true_pred/nObsTest))
    
    print('\n-- Anomaly Detection based on Isolation Forest --\n')
    isf = IsolationForest()
    isf.fit(i2trainFeaturesN)
    LT = isf.predict(i3AtestFeaturesN)

    true_pred = 0
    nObsTest,nFea=i3AtestFeaturesN.shape
    for i in range(nObsTest):
        true_pred += int(o3testClass[i][0] == LT[i])
    print("Accuracy:", 1-(true_pred/nObsTest))

    print('\n-- Anomaly Detection based on Local Outlier Factor (PCA) --\n')
    lof = LocalOutlierFactor(novelty=True, p=1)
    lof.fit(i2trainFeaturesNPCA)
    LT = lof.predict(i3AtestFeaturesNPCA)

    true_pred = 0
    nObsTest,nFea=i3AtestFeaturesNPCA.shape
    for i in range(nObsTest):
        true_pred += int(o3testClass[i][0] == LT[i])
    print("Accuracy:", 1-(true_pred/nObsTest))

    print('\n-- Anomaly Detection based on Local Outlier Factor --\n')
    lof = LocalOutlierFactor(novelty=True, p=3)
    lof.fit(i2trainFeaturesN)
    LT = lof.predict(i3AtestFeaturesN)

    true_pred = 0
    nObsTest,nFea=i3AtestFeaturesN.shape
    for i in range(nObsTest):
        true_pred += int(o3testClass[i][0] == LT[i])
    print("Accuracy:", 1-(true_pred/nObsTest))
    

    # print('\n-- Anomaly Detection based on One Class Support Vector Machines (PCA Features) --\n')
    # ocsvm = OneClassSVM(gamma='scale',kernel='linear').fit(i2trainFeaturesNPCA)
    # rbf_ocsvm = OneClassSVM(gamma='scale',kernel='rbf').fit(i2trainFeaturesNPCA)
    # poly_ocsvm = OneClassSVM(gamma='scale',kernel='poly',degree=2).fit(i2trainFeaturesNPCA)

    # print('\n-- Linear SVM --')
    # LT=ocsvm.predict(i3AtestFeaturesNPCA)
    # true_pred = 0
    # nObsTest,nFea=i3AtestFeaturesNPCA.shape
    # for i in range(nObsTest):
    #     true_pred += int(o3testClass[i][0] == LT[i])
    # print("Accuracy:", 1-(true_pred/nObsTest))

    # print('\n-- RBF SVM --')
    # LT=rbf_ocsvm.predict(i3AtestFeaturesNPCA)
    # true_pred = 0
    # for i in range(nObsTest):
    #     true_pred += int(o3testClass[i][0] == LT[i])
    # print("Accuracy:", 1-(true_pred/nObsTest))
    
    # print('\n-- Poly SVM --')
    # LT=poly_ocsvm.predict(i3AtestFeaturesNPCA)
    # true_pred = 0
    # for i in range(nObsTest):
    #     true_pred += int(o3testClass[i][0] == LT[i])
    # print("Accuracy:", 1-(true_pred/nObsTest))

    # print('\n-- Anomaly Detection based on One Class Support Vector Machines--\n')
    # ocsvm = OneClassSVM(gamma='scale',kernel='linear').fit(i2trainFeaturesN)
    # rbf_ocsvm = OneClassSVM(gamma='scale',kernel='rbf').fit(i2trainFeaturesN)
    # poly_ocsvm = OneClassSVM(gamma='scale',kernel='poly',degree=2).fit(i2trainFeaturesN)

    # print('\n-- Linear SVM --')
    # LT=ocsvm.predict(i3AtestFeaturesN)
    # true_pred = 0
    # nObsTest,nFea=i3AtestFeaturesN.shape
    # for i in range(nObsTest):
    #     true_pred += int(o3testClass[i][0] == LT[i])
    # print("Accuracy:", 1-(true_pred/nObsTest))
    
    # print('\n-- RBF SVM --')
    # LT=rbf_ocsvm.predict(i3AtestFeaturesN)
    # true_pred = 0
    # for i in range(nObsTest):
    #     true_pred += int(o3testClass[i][0] == LT[i])
    # print("Accuracy:", 1-(true_pred/nObsTest))
    
    # print('\n-- Poly SVM --')
    # LT=poly_ocsvm.predict(i3AtestFeaturesN)
    # true_pred = 0
    # for i in range(nObsTest):
    #     true_pred += int(o3testClass[i][0] == LT[i])
    # print("Accuracy:", 1-(true_pred/nObsTest))

    models = get_model_list()
    for i, model in enumerate(models):
        # print(f'\n-- Classification based on {type(model).__name__} (PCA) --\n')
        # model.fit(i3trainFeaturesNPCA, o3trainClass)
        # LT=model.predict(i3CtestFeaturesNPCA)
        # # if 'KNeigh' in type(model).__name__:
        # #     res = permutation_importance(model, i3trainFeaturesNPCA, o3trainClass, scoring='neg_mean_squared_error')
        # #     coeffs = res.importances_mean
        # #     for i, val in enumerate(coeffs):
        # #         print(f"Feature {i}, Score: {val}")
        # # elif 'Bagging' in type(model).__name__:
        # #     coeffs = [tree.feature_importances_ for tree in model.estimators_]
        # #     for i, val in enumerate(coeffs):
        # #         print(f"Feature {i}, Score: {val}")
        # # else:
        # #     coeffs = model.feature_importances_
        # #     for i, val in enumerate(coeffs):
        # #         print(f"Feature {i}, Score: {val}")
        # c = metrics.confusion_matrix(o3testClass, LT)
        # acc = metrics.accuracy_score(o3testClass, LT)
        # rec = metrics.recall_score(o3testClass, LT, average='weighted')
        # prec = metrics.precision_score(o3testClass, LT, average='weighted')
        # f1s = metrics.f1_score(o3testClass, LT, average='weighted')
        # print("Accuracy :",acc)
        # print("Recall   :",rec)
        # print("Precision:",prec)
        # print("F1 Score :",f1s)
        # # print("Accuracy:", model.score(i3trainFeaturesNPCA, o3trainClass))
        # print("Confusion Matrix:")
        # print(c)
        # print("Per-class analysis:")
        # diag = np.diagonal(c)
        # for i in range(len(Classes)):
        #     print(f"{Classes[i]:16s} ({i}):\tTP%:{diag[i]/np.sum(c[i,:]):.3f}\tFP%: {(np.sum(c[:,i])-diag[i])/np.sum(c[i,:]):.3f}\tFN%: {(np.sum(c[i,:])-diag[i])/np.sum(c[i,:]):.3f}")

        print(f'\n-- Classification based on {type(model).__name__} --\n')
        model.fit(i3trainFeaturesN, o3trainClass)
        LT=model.predict(i3CtestFeaturesN)
        # if 'KNeigh' in type(model).__name__:
        #     res = permutation_importance(model, i3trainFeaturesN, o3trainClass, scoring='neg_mean_squared_error')
        #     coeffs = res.importances_mean
        #     for i, val in enumerate(coeffs):
        #         print(f"Feature {i}, Score: {val}")
        # elif 'Bagging' in type(model).__name__:
        #     coeffs = [tree.feature_importances_ for tree in model.estimators_]
        #     for i, val in enumerate(coeffs):
        #         print(f"Feature {i}, Score: {val}")
        # else:
        #     coeffs = model.feature_importances_
        #     for i, val in enumerate(coeffs):
        #         print(f"Feature {i}, Score: {val}")
        c = confusion_matrix(o3testClass, LT)
        acc = accuracy_score(o3testClass, LT)
        rec = recall_score(o3testClass, LT, average='weighted')
        prec = precision_score(o3testClass, LT, average='weighted')
        f1s = f1_score(o3testClass, LT, average='weighted')
        print("Accuracy :",acc)
        print("Recall   :",rec)
        print("Precision:",prec)
        print("F1 Score :",f1s)
        print("Confusion Matrix:")
        print(c)
        print("Per-class analysis:")
        diag = np.diagonal(c)
        for i in range(len(Classes)):
            print(f"{Classes[i]:16s} ({i}):\tTP%:{diag[i]/np.sum(c[i,:]):.3f}\tFP%: {(np.sum(c[:,i])-diag[i])/np.sum(c[i,:]):.3f}\tFN%: {(np.sum(c[i,:])-diag[i])/np.sum(c[i,:]):.3f}")
        
        del model
        gc.collect()
else:
    model = ExtraTreesClassifier(n_estimators=20, min_samples_leaf=1, min_samples_split=5, max_depth=None)
    print(f'\n-- Classification training based on {type(model).__name__} --\n')
    model.fit(i3trainFeaturesN, o3trainClass)
    print(f'Saving trained model to {type(model).__name__}.model\n')
    joblib.dump(model, type(model).__name__+".model", compress=9)
