using LiveCharts;
using LiveCharts.Wpf;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace GLUA_DB
{
    /// <summary>
    /// Interaction logic for Estatisticas.xaml
    /// </summary>
    public partial class Estatisticas : Page
    {

        private Func<ChartPoint, string> labelPoint;

        public Estatisticas()
        {
            InitializeComponent();

            labelPoint = chartPoint =>
                string.Format("{0} ({1:P})", chartPoint.Y, chartPoint.Participation);

            getOSStats();
            getCursoStats();
            getPCStats();
            getComponenteStats();
            getMonthStats();
        }

        private void getOSStats()
        {
            string queryString =
                "SELECT * FROM getOSStats()";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();      

                    while (reader.Read())
                    {
                        if (Convert.ToInt32(reader["flashDrives_num"]) != 0)
                        {
                            FlashDrives_PieChart.Series.Add(new PieSeries
                            {
                                Title = reader["Nome"].ToString(),
                                Values = new ChartValues<int> { Convert.ToInt32(reader["flashDrives_num"]) },
                                DataLabels = true,
                                LabelPoint = labelPoint
                            });
                        }
                        if (Convert.ToInt32(reader["problems_num"]) != 0)
                        {
                            Problemas_PieChart.Series.Add(new PieSeries
                            {
                                Title = reader["Nome"].ToString(),
                                Values = new ChartValues<int> { Convert.ToInt32(reader["problems_num"]) },
                                DataLabels = true,
                                LabelPoint = labelPoint
                            });
                        }
                    }
                }
            }
        }

        private void getCursoStats()
        {
            int est = 0;
            int not = 0;

            string queryString =
                "SELECT * FROM getCursoStats()";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        if (Convert.ToInt32(reader["atendimentos_num"]) != 0)
                        {
                            if (reader["Curso"] is DBNull) not += Convert.ToInt32(reader["atendimentos_num"]);
                            else if(reader["Curso"].ToString().Length < 6)
                            {
                                Cursos_PieChart.Series.Add(new PieSeries
                                {
                                    Title = reader["Curso"].ToString(),
                                    Values = new ChartValues<int> { Convert.ToInt32(reader["atendimentos_num"]) },
                                    DataLabels = true,
                                    LabelPoint = labelPoint
                                });
                                est += Convert.ToInt32(reader["atendimentos_num"]);
                            }
                        }
                    }
                }
            }
            Estudantes_PieChart.Series.Add(new PieSeries
            {
                Title = "Estudantes",
                Values = new ChartValues<int> { est },
                DataLabels = true,
                LabelPoint = labelPoint
            });
            Estudantes_PieChart.Series.Add(new PieSeries
            {
                Title = "Não-Estudantes",
                Values = new ChartValues<int> { not },
                DataLabels = true,
                LabelPoint = labelPoint
            });
        }

        private void getPCStats()
        {
            string queryString =
                "SELECT * FROM getPCStats()";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        if (Convert.ToInt32(reader["atendimentos_num"]) != 0)
                        {
                            PCs_PieChart.Series.Add(new PieSeries
                            {
                                Title = reader["Fabricante"].ToString(),
                                Values = new ChartValues<int> { Convert.ToInt32(reader["atendimentos_num"]) },
                                DataLabels = true,
                                LabelPoint = labelPoint
                            });
                        }
                    }
                }
            }
        }

        private void getComponenteStats()
        {
            string queryString =
                "SELECT TOP 8 * FROM getComponenteStats()";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        if (Convert.ToInt32(reader["atendimentos_num"]) != 0)
                        {
                            Componentes_PieChart.Series.Add(new PieSeries
                            {
                                Title = reader["Fabricante"].ToString(),
                                Values = new ChartValues<int> { Convert.ToInt32(reader["atendimentos_num"]) },
                                DataLabels = true,
                                LabelPoint = labelPoint
                            });
                        }
                    }
                }
            }
        }

        private void getMonthStats()
        {

            int[] values = new int[12];
            int[] monthsInt = Enumerable.Range(0, 12)
                              .Select(i => DateTime.Now.AddMonths(i - 12))
                              .Select(date => Convert.ToInt32(date.ToString("MM"))).ToArray();
            String[] months = Enumerable.Range(0, 12)
                              .Select(i => DateTime.Now.AddMonths(i - 12))
                              .Select(date => date.ToString("MMMM")).ToArray();

            string queryString =
                "SELECT * FROM getMonthStats()";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        for(int i = 0; i < 12; i++)
                        {
                            if(monthsInt[i] == Convert.ToInt32(reader["mes"])) values[i] = Convert.ToInt32(reader["atendimentos_num"]);
                        }
                    }
                }
            }

            Month_BarChart.Series = new SeriesCollection
            {
                new ColumnSeries
                {
                    Title = "Atendimentos",
                    Values = new ChartValues<int>(values)
                }
            };

            Month_BarChart.AxisX.Add(new Axis
            {
                Title = "Meses",
                Labels = months
            });

            Month_BarChart.AxisX[0].Separator.Step = 1;
        }

    }
}
