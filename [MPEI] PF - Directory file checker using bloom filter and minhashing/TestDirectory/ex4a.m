arraySimulacao = [f(1e5,0.3,0,5),f(1e5,0.3,1,5),f(1e5,0.3,2,5),f(1e5,0.3,3,5),f(1e5,0.3,4,5), f(1e5,0.3,5,5)];
arrayAnalitico = [m(0.3,0,5),m(0.3,1,5),m(0.3,2,5),m(0.3,3,5),m(0.3,4,5), m(0.3,5,5)];
x = 0:5;

subplot(1,2,1)
stem(x,arraySimulacao)
axis([0,5,0,1]);
xlabel("Número de peças defeituosas em 5");
ylabel("Probabilidade por Simulação");

subplot(1,2,2)
stem(x,arrayAnalitico)
axis([0,5,0,1]);
xlabel("Número de peças defeituosas em 5");
ylabel("Probabilidade Analítica");