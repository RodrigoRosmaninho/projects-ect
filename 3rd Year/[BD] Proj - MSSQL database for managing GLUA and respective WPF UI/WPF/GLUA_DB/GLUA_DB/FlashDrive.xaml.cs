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
    /// Interaction logic for FlashDrive.xaml
    /// </summary>
    public partial class FlashDrive : Page
    {
        private static int ID;
        protected MainWindow main;

        public int member_id = -1;
        public String member_name;

        public FlashDrive(int id)
        {
            InitializeComponent();
            ID = id;
            if (id < 0)
            {
                ID_Label.Visibility = Visibility.Hidden;
                ID_TextBox.Visibility = Visibility.Hidden;
                Nome_TextBox.IsReadOnly = false;
                Estado_ComboBox.IsEnabled = true;
                Localizacao_TextBox.IsReadOnly = false;
                showActiveMembers.IsEnabled = true;
                Dador_TextBox.IsReadOnly = false;
                Fabricante_TextBox.IsReadOnly = false;
                Descricao_TextBox.IsReadOnly = false;
                Capacidade_ComboBox.IsEnabled = true;
                Velocidade_ComboBox.IsEnabled = true;
                OS_Radio.IsEnabled = true;
                Other_Radio.IsEnabled = true;
                OS_Radio.IsChecked = true;
                OS_ComboBox.IsEnabled = true;
                if (Versao_ComboBox.Items.Count > 0) Versao_ComboBox.IsEnabled = true;
                else Versao_ComboBox.IsEnabled = false;
                Conteudo_TextBox.IsReadOnly = false;
                Edit.Visibility = Visibility.Hidden;
                Delete.Visibility = Visibility.Hidden;
                Save.Visibility = Visibility.Hidden;
                Cancel.Visibility = Visibility.Hidden;
                CreateFlashDrive.Visibility = Visibility.Visible;
                getSystemOpName();

            }
            else
            {
                CreateFlashDrive.Visibility = Visibility.Hidden;
                getFlashDriveByID(ID);
                Reset_Fields();
            }
        }

        private void getFlashDriveByID(int id)
        {
            string queryString;

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                
                queryString = "SELECT DISTINCT Nome FROM dbo.SISTEMA_OPERATIVO";

                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    OS_ComboBox.Items.Clear();

                    while (reader.Read())
                    {
                        OS_ComboBox.Items.Add(reader["Nome"].ToString());
                    }

                    reader.Close();
                }

                queryString = "SELECT * FROM dbo.getFlashDrivesByID(" + id + ");";

                using (var cmd = new SqlCommand(queryString, cn))
                {
                    var reader = cmd.ExecuteReader();

                    reader.Read();
                    OS_ComboBox.SelectedIndex = OS_ComboBox.Items.IndexOf(reader["SistemaOp_Nome"].ToString());
                    ID_TextBox.Text = reader["ID"].ToString();
                    Nome_TextBox.Text = reader["Nome"].ToString();
                    Estado_ComboBox.SelectedIndex = Convert.ToInt32(reader["Estado"]);
                    Localizacao_TextBox.Text = reader["Localizacao"].ToString();
                    Member_TextBox.Text = reader["Membro_nome"].ToString();
                    Dador_TextBox.Text = reader["Dador"].ToString();
                    Fabricante_TextBox.Text = reader["Fabricante"].ToString();
                    Descricao_TextBox.Text = reader["Descricao"].ToString();
                    Capacidade_ComboBox.SelectedIndex = (int) Math.Log(Convert.ToInt32(reader["Capacidade"]), 2) - 1;
                    Velocidade_ComboBox.SelectedIndex = Convert.ToInt32(reader["Velocidade"]) - 2;
                    if (reader["SistemaOp_Nome"] is DBNull) Other_Radio.IsChecked = true;
                    else OS_Radio.IsChecked = true;
                    Conteudo_TextBox.Text = reader["Conteudo"].ToString();
                    Versao_ComboBox.SelectedIndex = Versao_ComboBox.Items.IndexOf(reader["Versao"].ToString());
                }
            }
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.GoBack();
        }

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            Nome_TextBox.IsReadOnly = false;
            Estado_ComboBox.IsEnabled = true;
            Localizacao_TextBox.IsReadOnly = false;
            showActiveMembers.IsEnabled = true;
            Dador_TextBox.IsReadOnly = false;
            Fabricante_TextBox.IsReadOnly = false;
            Descricao_TextBox.IsReadOnly = false;
            Capacidade_ComboBox.IsEnabled = true;
            Velocidade_ComboBox.IsEnabled = true;
            OS_Radio.IsEnabled = true;
            Other_Radio.IsEnabled = true;
            OS_ComboBox.IsEnabled = true;
            if (Versao_ComboBox.Items.Count > 0) Versao_ComboBox.IsEnabled = true;
            else Versao_ComboBox.IsEnabled = false;
            Conteudo_TextBox.IsReadOnly = false;
            Edit.Visibility = Visibility.Hidden;
            Delete.Visibility = Visibility.Hidden;
            Save.Visibility = Visibility.Visible;
            Cancel.Visibility = Visibility.Visible;
        }

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            String[] values = { ID.ToString() };
            DB.getDB().executeNonResultQuery("DELETE FROM FLASH_DRIVE WHERE ID = {};", values);
            this.NavigationService.GoBack();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            Object estado;
            if (Estado_ComboBox.SelectedIndex == -1) estado = DBNull.Value;
            else estado = Estado_ComboBox.SelectedIndex;

            Object capacidade;
            if (Capacidade_ComboBox.SelectedIndex == -1) capacidade = DBNull.Value;
            else capacidade = Capacidade_ComboBox.SelectedIndex;

            Object velocidade;
            if (Velocidade_ComboBox.SelectedIndex == -1) velocidade = DBNull.Value;
            else velocidade = Velocidade_ComboBox.SelectedIndex;


            Object so_id = DBNull.Value;
            Object conteudo = DBNull.Value;
            if (OS_Radio.IsChecked == true) //pq pode ser null
            {
                String versao;
                 if(Versao_ComboBox.SelectedIndex == -1)
                {
                    versao = "null";
                }
                else
                {
                    versao = (String)Versao_ComboBox.SelectedItem;
                }
                 so_id = DB.getDB().getIdFromSystemOpName((String)OS_ComboBox.SelectedItem, (String)Versao_ComboBox.SelectedItem);
            }
            else
            {
                conteudo = (String)Conteudo_TextBox.Text;
            }

  
            Object[] values = { ID, Nome_TextBox.Text, Descricao_TextBox.Text, Localizacao_TextBox.Text, estado, Dador_TextBox.Text, member_id, Fabricante_TextBox.Text, Math.Pow(2,(int)capacidade+1), (int)velocidade+2, conteudo, so_id};
            DB.getDB().executeNonResultQuery("EXEC ModifyFlashDrive {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}", values);
            Reset_Fields();
            showActiveMembers.IsEnabled = false;
        }

        private void getSystemOpName()
        {
            string queryString;

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {

                queryString = "SELECT DISTINCT Nome FROM dbo.SISTEMA_OPERATIVO";

                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    OS_ComboBox.Items.Clear();

                    while (reader.Read())
                    {
                        OS_ComboBox.Items.Add(reader["Nome"].ToString());
                    }

                    reader.Close();
                }
            }
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            getFlashDriveByID(ID);
            Reset_Fields();
            showActiveMembers.IsEnabled = false;
        }

        private void Reset_Fields()
        {
            Nome_TextBox.IsReadOnly = true;
            Estado_ComboBox.IsEnabled = false;
            Localizacao_TextBox.IsReadOnly = true;
            showActiveMembers.IsEnabled = false;
            Dador_TextBox.IsReadOnly = true;
            Fabricante_TextBox.IsReadOnly = true;
            Descricao_TextBox.IsReadOnly = true;
            Capacidade_ComboBox.IsEnabled = false;
            Velocidade_ComboBox.IsEnabled = false;
            OS_Radio.IsEnabled = false;
            Other_Radio.IsEnabled = false;
            OS_ComboBox.IsEnabled = false;
            Versao_ComboBox.IsEnabled = false;
            Conteudo_TextBox.IsReadOnly = true;
            Edit.Visibility = Visibility.Visible;
            Delete.Visibility = Visibility.Visible;
            Save.Visibility = Visibility.Hidden;
            Cancel.Visibility = Visibility.Hidden;
        }

        private void OS_Radio_Checked(object sender, RoutedEventArgs e)
        {
            OS_ComboBox.Visibility = Visibility.Visible;
            Versao_ComboBox.Visibility = Visibility.Visible;
            OS_Label.Visibility = Visibility.Visible;
            Versao_Label.Visibility = Visibility.Visible;
            Conteudo_TextBox.Visibility = Visibility.Hidden;
        }

        private void Other_Radio_Checked(object sender, RoutedEventArgs e)
        {
            OS_ComboBox.Visibility = Visibility.Hidden;
            Versao_ComboBox.Visibility = Visibility.Hidden;
            OS_Label.Visibility = Visibility.Hidden;
            Versao_Label.Visibility = Visibility.Hidden;
            Conteudo_TextBox.Visibility = Visibility.Visible;
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

        private void createFlashDrive_Click(object sender, RoutedEventArgs e)
        {
            Object estado;
            if (Estado_ComboBox.SelectedIndex == -1) estado = DBNull.Value;
            else estado = Estado_ComboBox.SelectedIndex;

            Object capacidade;
            if (Capacidade_ComboBox.SelectedIndex == -1) capacidade = DBNull.Value;
            else capacidade = Capacidade_ComboBox.SelectedIndex;

            Object velocidade;
            if (Velocidade_ComboBox.SelectedIndex == -1) velocidade = DBNull.Value;
            else velocidade = Velocidade_ComboBox.SelectedIndex;


            Object so_id = DBNull.Value;
            Object conteudo = DBNull.Value;
            if (OS_Radio.IsChecked == true) //pq pode ser null
            {
                String versao;
                if (Versao_ComboBox.SelectedIndex == -1)
                {
                    versao = "null";
                }
                else
                {
                    versao = (String)Versao_ComboBox.SelectedItem;
                }
                so_id = DB.getDB().getIdFromSystemOpName((String)OS_ComboBox.SelectedItem, (String)Versao_ComboBox.SelectedItem);
            }
            else
            {
                conteudo = (String)Conteudo_TextBox.Text;
            }

            Object[] values = { DBNull.Value, Nome_TextBox.Text, Descricao_TextBox.Text, Localizacao_TextBox.Text, estado, Dador_TextBox.Text, member_id, Fabricante_TextBox.Text, Math.Pow(2, (int)capacidade + 1), (int)velocidade + 2, conteudo, so_id };
            DB.getDB().executeNonResultQuery("EXEC ModifyFlashDrive {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}", values);
            this.NavigationService.GoBack();
        }

        private void showActiveMembers_Click(object sender, RoutedEventArgs e)
        {
            getMain().EqActiveMembersDataGrid.ItemsSource = getActiveMembers();
            MainWindow.FlyoutPage = this;
            MainWindow.Page_label = "Flash_Drive";
            getMain().EqActiveMembersFlyout.Header = "Membros";
            getMain().EqActiveMembersFlyout.IsOpen = true;
        }

        private DataView getActiveMembers()
        {
            string queryString =
                "SELECT * FROM dbo.MEMBROS WHERE Estado = 1";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("ID", typeof(int)), new DataColumn("Nome", typeof(string)), new DataColumn("Email", typeof(string)), new DataColumn("Telemóvel", typeof(string)), new DataColumn("Tipo", typeof(string)), new DataColumn("Estado", typeof(string)), new DataColumn("Data de Entrada", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        row["Nome"] = reader["Nome"].ToString();
                        row["Email"] = reader["Email"].ToString();
                        row["Telemóvel"] = reader["Num_telemovel"].ToString();
                        row["Tipo"] = DB.getMembroTipo(Convert.ToInt32(reader["Tipo"]));
                        row["Estado"] = DB.getMembroEstado(Convert.ToInt32(reader["Estado"]));
                        row["Data de Entrada"] = Convert.ToDateTime(reader["Data_Entrada"]).ToString("yyyy/MM/dd");
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
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

        public void updateMemberName()
        {
            Member_TextBox.Text = member_name;
        }
    }
}
