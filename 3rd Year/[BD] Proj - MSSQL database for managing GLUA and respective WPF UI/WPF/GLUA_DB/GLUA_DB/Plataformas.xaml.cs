using System;
using System.Collections.Generic;
using System.Data;
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
    /// Interaction logic for Plataformas.xaml
    /// </summary>
    public partial class Plataformas : Page
    {
        public Plataformas()
        {
            InitializeComponent();
            PlataformasGrid.ItemsSource = getPlataformasList();
        }

        private DataView getPlataformasList()
        {
            string queryString =
                "SELECT * FROM dbo.Plataformas ORDER BY Nome;";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("Nome", typeof(string)), new DataColumn("Link", typeof(string)), new DataColumn("Descricao", typeof(string)), new DataColumn("Num de Acessos", typeof(int)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["Nome"] = reader["Nome"].ToString();
                        row["Link"] = reader["Link"].ToString();
                        row["Descricao"] = reader["Descricao"].ToString();
                        row["Num de Acessos"] = Convert.ToInt32(reader["acessos_num"]);
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

        private void PlataformasGrid_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Plataforma rowPage = new Plataforma((String)(((DataRowView)row.Item).Row["Nome"]));
            this.NavigationService.Navigate(rowPage);
        }

        private void InsertPlataforma_Click(object sender, RoutedEventArgs e)
        {
            Plataforma rowPage = new Plataforma("null");
            this.NavigationService.Navigate(rowPage);
        }
    }
}
