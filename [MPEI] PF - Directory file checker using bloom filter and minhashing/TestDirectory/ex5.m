# Pela distribuição binomial, P(aviao com 2 motores despenhar-se) = P(x = 2) para n = 2
# (sendo que x representa o número de motores em que ocorre falha e n representa o número total de motores)
# Ou seja, P(x = 2) para n = 2 : C2,2 p² (1-p)²⁻² = p²
# em que p é a probabilidade de um dado motor falhar

# Pela distribuição binomial, P(aviao com 4 motores despenhar-se) = P(x = 3) + P(x = 4) para n = 4
# (sendo que x representa o número de motores em que ocorre falha e n representa o número total de motores)
# Ou seja, P(x = 3) + P(x = 4) para n = 2 : C3,4 p³ (1-p)⁴⁻³ + C4,4 p⁴ (1-p)⁴⁻⁴ = 4p³ - 3p⁴
# em que p é a probabilidade de um dado motor falhar

x = logspace(-3,log10(1/2),100);

y1 = x.**2;                     # P(x = 2) para n = 2 : p²
y2 = 4.*(x).**3 - 3.*(x).**4;   # P(x = 3) + P(x = 4) para n = 4 : 4p³ - 3p⁴
plot(x,y1,x,y2);
legend("Avião com 2 motores","Avião com 4 motores");
xlabel("Probabilidade p (de um dado motor falhar)");
ylabel("Probabilidade do avião se despenhar");

intersecao = x(y2>=y1)(1) # Aproximação da interseção dos dois gráficos

# CONCLUSÃO: Como se pode observar pelos gráficos, para valores de p até aproximadamente 0.34308
# é mais seguro voar em aviões com 4 motores. Para valores de p superiores torna-se mais seguro voar
# em aviões com 2 motores.