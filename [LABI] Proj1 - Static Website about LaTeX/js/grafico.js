$("#grafico").highcharts({
    chart: {
        type: "column"
    },
    title: {
        text: "Utilização do LaTeX para a escrita de relatórios científicos, por áreas (em 2009)",
    },
    xAxis: {
        categories: ["Matemática", "Estatisticas e Probabilidade", "Física", "Ciência de Computadores", "Astronomia e Astrofísica", "Engenharia",
            "Geociências", "Ecologia", "Química", "Biologia", "Medicina", "Psicologia", "Ciências do Desporto"]
    },
    yAxis: {
        title: {
            enabled: true,
            text: "Percentagens",
        },
        max: 100
    },
    series: [{
        name: "Percentagem de relatórios escritos em LaTeX",
        data: [96.9, 89.1, 74.0, 45.8, 35.1, 1.0, 0.8, 0.4, 0.3, 0.0, 0.0, 0.0, 0.0]
    }]
});