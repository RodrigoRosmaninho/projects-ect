CODEBASE="http://l040101-ws09.ua.pt/sd106/classes/"
java -Djava.rmi.server.codebase=$CODEBASE\
     -Djava.rmi.server.useCodebaseOnly=true\
     -Djava.security.policy=java.policy\
     -classpath "../genclass.jar:."\
     serverSide.main.RegisterRemoteObjectMain 22151 l040101-ws09.ua.pt 22150
