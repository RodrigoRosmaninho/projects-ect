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
using System.Windows.Threading;

namespace GLUA_DB
{
    /// <summary>
    /// Interaction logic for Problema.xaml
    /// </summary>
    public partial class Problema : Page
    {
        private static int ID;
        public MainWindow main;

        public Problema(int id)
        {
            InitializeComponent();
            ID = id;
            getProblemaByID(ID);

        }

        private void getProblemaByID(int id)
        {
            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                string queryString = "SELECT DISTINCT Fabricante FROM dbo.COMPONENTE";

                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    Fabricante_ComboBox.Items.Clear();
                    Fabricante_ComboBox.Items.Add("Nenhum");

                    while (reader.Read())
                    {
                        Fabricante_ComboBox.Items.Add(reader["Fabricante"].ToString());
                    }

                    reader.Close();
                }

                queryString = "SELECT DISTINCT Nome FROM dbo.SISTEMA_OPERATIVO";

                using (var cmd = new SqlCommand(queryString, cn))
                {
                    var reader = cmd.ExecuteReader();

                    OS_ComboBox.Items.Clear();
                    OS_ComboBox.Items.Add("Nenhum");

                    while (reader.Read())
                    {
                        OS_ComboBox.Items.Add(reader["Nome"].ToString());
                    }

                    reader.Close();
                }

                if (id >= 0)
                {

                    queryString = "SELECT * FROM dbo.getProblemByID(" + id + ");";

                    using (var cmd = new SqlCommand(queryString, cn))
                    {
                        var reader = cmd.ExecuteReader();
                        reader.Read();
                        if (reader["Fabricante"] is DBNull) Fabricante_ComboBox.SelectedIndex = 0;
                        else Fabricante_ComboBox.SelectedIndex = Fabricante_ComboBox.Items.IndexOf(reader["Fabricante"].ToString());
                        if (reader["SO"] is DBNull) OS_ComboBox.SelectedIndex = 0;
                        else OS_ComboBox.SelectedIndex = OS_ComboBox.Items.IndexOf(reader["SO"].ToString());
                        if (!(reader["Descricao"] is DBNull)) Descricao_TextBox.Text = reader["Descricao"].ToString();
                        Modelo_ComboBox.SelectedIndex = Modelo_ComboBox.Items.IndexOf(reader["Modelo"].ToString());
                        Versao_ComboBox.SelectedIndex = Versao_ComboBox.Items.IndexOf(reader["Versao"].ToString());
                    }
                    Reset_Fields();
                }
                else
                {
                    Fabricante_ComboBox.SelectedIndex = 0;
                    OS_ComboBox.SelectedIndex = 0;
                    showTentativas.Visibility = Visibility.Hidden;
                    Edit_Click(null, null);
                }
            }
        }

        public static DataView getTentativasByProblema(int ID)
        {
            string queryString =
                "SELECT * FROM dbo.getAttemptsByProblemID(" + ID + ")"; // TODO

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("Problema_ID", typeof(int)), new DataColumn("Atendimento_ID", typeof(int)), new DataColumn("Estado", typeof(string)), new DataColumn("Data", typeof(string)), new DataColumn("Procedimento", typeof(string))};
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["Problema_ID"] = Convert.ToInt32(reader["Problema_id"]);
                        row["Atendimento_ID"] = Convert.ToInt32(reader["Atendimento_id"]);
                        row["Estado"] = DB.getTentativaEstado(Convert.ToInt32(reader["Estado"]));
                        row["Data"] = Convert.ToDateTime(reader["Data"]).ToString("yyyy/MM/dd hh:mm");
                        row["Procedimento"] = reader["Procedimento"].ToString();
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.GoBack();
        }

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            Descricao_TextBox.IsReadOnly = false;
            Fabricante_ComboBox.IsEnabled = true;
            if (Modelo_ComboBox.Items.Count > 0) Modelo_ComboBox.IsEnabled = true;
            else Modelo_ComboBox.IsEnabled = false;
            OS_ComboBox.IsEnabled = true;
            if (Versao_ComboBox.Items.Count > 0) Versao_ComboBox.IsEnabled = true;
            else Versao_ComboBox.IsEnabled = false;
            Edit.Visibility = Visibility.Hidden;
            Delete.Visibility = Visibility.Hidden;
            Save.Visibility = Visibility.Visible;
            Cancel.Visibility = Visibility.Visible;
        }

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { ID };
            DB.getDB().executeNonResultQuery("DELETE FROM PROBLEMA WHERE ID = {};", values);
            this.NavigationService.GoBack();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            Object id = ID;
            if (ID < 0) id = DBNull.Value;
            Object comp;
            if ((String)Fabricante_ComboBox.SelectedItem == "Nenhum") comp = DBNull.Value;
            else comp = DB.getDB().getIdFromComponenteFabricante((String)Fabricante_ComboBox.SelectedItem, (String)Modelo_ComboBox.SelectedItem);
            Object os;
            if ((String)OS_ComboBox.SelectedItem == "Nenhum") os = DBNull.Value;
            else os = DB.getDB().getIdFromSystemOpName((String)OS_ComboBox.SelectedItem, (String)Versao_ComboBox.SelectedItem);
            Object[] values = { id, Descricao_TextBox.Text, comp, os};
            DB.getDB().executeNonResultQuery("EXEC ModifyProblemas {}, {}, {}, {}", values);
            this.NavigationService.GoBack();
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            if(ID < 0)
            {
                this.NavigationService.GoBack();
                return;
            }
            getProblemaByID(ID);
            Reset_Fields();
        }

        private void Reset_Fields()
        {
            Descricao_TextBox.IsReadOnly = true;
            Fabricante_ComboBox.IsEnabled = false;
            Modelo_ComboBox.IsEnabled = false;
            OS_ComboBox.IsEnabled = false;
            Versao_ComboBox.IsEnabled = false;
            Edit.Visibility = Visibility.Visible;
            Delete.Visibility = Visibility.Visible;
            Save.Visibility = Visibility.Hidden;
            Cancel.Visibility = Visibility.Hidden;
        }

        private void Fabricante_ComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            String Fabricante = (String)Fabricante_ComboBox.SelectedItem;
            Modelo_ComboBox.IsEnabled = false;

            string queryString =
                "SELECT * FROM getComponentesByFabricante ( @Fabricante );";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    cmd.Parameters.AddWithValue("@Fabricante", Fabricante);
                    var reader = cmd.ExecuteReader();

                    Modelo_ComboBox.Items.Clear();

                    while (reader.Read())
                    {
                        if (reader["Modelo"].ToString() != "") Modelo_ComboBox.Items.Add(reader["Modelo"].ToString());
                    }
                }
            }

            if (Modelo_ComboBox.Items.Count > 0)
            {
                Modelo_ComboBox.IsEnabled = true;
                if (Modelo_ComboBox.Items.Count == 1) Modelo_ComboBox.SelectedIndex = 0;
            }
        }

        private void OS_ComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            String OS = (String)OS_ComboBox.SelectedItem;
            Versao_ComboBox.IsEnabled = false;

            string queryString =
                "SELECT * FROM getSystemVersionByName ( @OS );"; 

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    cmd.Parameters.AddWithValue("@OS", OS);
                    var reader = cmd.ExecuteReader();

                    Versao_ComboBox.Items.Clear();

                    while (reader.Read())
                    {
                        if (reader["Versao"].ToString() != "") Versao_ComboBox.Items.Add(reader["Versao"].ToString());
                    }
                }
            }

            if (Versao_ComboBox.Items.Count > 0)
            {
                Versao_ComboBox.IsEnabled = true;
                if (Versao_ComboBox.Items.Count == 1) Versao_ComboBox.SelectedIndex = 0;
            }
        }

        private MainWindow getMain()
        {
            if (main == null)
            {
                main = ((MainWindow)Window.GetWindow(this));
            }
            return main;
        }

        private void showTentativas_Click(object sender, RoutedEventArgs e)
        {
            void AttemptsDataGrid_AutoGeneratedColumns(object s, EventArgs ea)
            {
                getMain().AttemptsDataGrid.Columns[0].Visibility = Visibility.Hidden;
                getMain().AttemptsDataGrid.Columns[1].Visibility = Visibility.Hidden;
            }

            MainWindow.FlyoutPage = this;
            getMain().AttemptsDataGrid.AutoGeneratedColumns += AttemptsDataGrid_AutoGeneratedColumns;
            getMain().AttemptsDataGrid.ItemsSource = getTentativasByProblema(ID);
            getMain().AttemptsFlyout.IsOpen = true;
        }

    }
}
