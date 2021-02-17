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
    /// Interaction logic for Equipamentos.xaml
    /// </summary>
    public partial class Equipamentos : Page
    {
        public Equipamentos()
        {
           
            InitializeComponent();
            PensDataGrid.ItemsSource = getPensList();
            EquipamentosGenericosDataGrid.ItemsSource = getEquipamentosList();
            
        }

        private void TabItem_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            
        }

        private void TabItem_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
         
        }

        public DataView getEquipamentosList()
        {
            string queryString =
                "SELECT * FROM dbo.Equipamentos_NaoFlashDrive;";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("ID", typeof(int)), new DataColumn("Nome", typeof(string)), new DataColumn("Estado", typeof(string)), new DataColumn("Localizacao", typeof(string)), new DataColumn("Dador", typeof(string)), new DataColumn("Descricao", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        row["Nome"] = reader["Nome"].ToString();
                        row["Descricao"] = reader["Descricao"].ToString();
                        row["Estado"] = DB.getEquipamentoEstado(Convert.ToInt32(reader["Estado"]));
                        row["Localizacao"] = reader["Localizacao"].ToString();
                        row["Dador"] = reader["Dador"].ToString();
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

        public DataView getPensList()
        {
            string queryString =
                "SELECT * FROM dbo.Equipamentos_FlashDrive_SistemaOp;";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("ID", typeof(int)), new DataColumn("Estado", typeof(string)), new DataColumn("Fabricante", typeof(string)), new DataColumn("Capacidade", typeof(string)), new DataColumn("Velocidade", typeof(string)), new DataColumn("Conteudo", typeof(string)),
                                                            new DataColumn("Localizacao", typeof(string)), new DataColumn("Descricao", typeof(string)),  new DataColumn("Dador", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        row["Estado"] = DB.getEquipamentoEstado(Convert.ToInt32(reader["Estado"]));
                        row["Fabricante"] = reader["Fabricante"].ToString();
                        row["Capacidade"] = reader["Capacidade"].ToString() + " GB";
                        row["Velocidade"] = "USB " + reader["Velocidade"].ToString();
                        row["Conteudo"] = reader["SistemaOp_Nome"].ToString() + " " + reader["Versao"];
                        row["Descricao"] = reader["Descricao"].ToString();
                        row["Localizacao"] = reader["Localizacao"].ToString();
                        row["Dador"] = reader["Dador"].ToString();

                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

        public void Equipment_DoubleClick(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Equipamento rowPage = new Equipamento((int)(((DataRowView)row.Item).Row["ID"]));
            this.NavigationService.Navigate(rowPage);
        }

        public void FlashDrive_DoubleClick(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            FlashDrive rowPage = new FlashDrive((int)(((DataRowView)row.Item).Row["ID"]));
            this.NavigationService.Navigate(rowPage);
        }

        public void InsertEquipamento_Click(object sender, RoutedEventArgs e)
        {
            Equipamento Page = new Equipamento(-1);
            this.NavigationService.Navigate(Page);
        }

        public void InsertFlashDrive_Click(object sender, RoutedEventArgs e)
        {
            FlashDrive Page = new FlashDrive(-1);
            this.NavigationService.Navigate(Page);
        }
    }
}
