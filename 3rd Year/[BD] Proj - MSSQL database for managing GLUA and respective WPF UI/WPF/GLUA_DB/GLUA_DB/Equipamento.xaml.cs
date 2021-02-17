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
    /// Interaction logic for Equipamento.xaml
    /// </summary>
    public partial class Equipamento : Page
    {
        public static int ID;
        protected MainWindow main;

        public int member_id = -1;
        public String member_name;

        public Equipamento(int id)
        {
            InitializeComponent();
            ID = id;
            if(id < 0)
            {
                Nome_TextBox.IsReadOnly = false;
                Estado_ComboBox.IsEnabled = true;
                Localizacao_TextBox.IsReadOnly = false;
                Member_TextBox.IsReadOnly = true;
                showActiveMembers.IsEnabled = true;
                Dador_TextBox.IsReadOnly = false;
                Descricao_TextBox.IsReadOnly = false;
                Edit.Visibility = Visibility.Hidden;
                Delete.Visibility = Visibility.Hidden;
                Save.Visibility = Visibility.Visible;
                Cancel.Visibility = Visibility.Visible;
                CreateEquip.Visibility = Visibility.Visible;
                ID_TextBox.Visibility = Visibility.Hidden;
                ID_Label.Visibility = Visibility.Hidden;
            }
            else
            {
                CreateEquip.Visibility = Visibility.Hidden;
                Member_TextBox.IsReadOnly = true;
                showActiveMembers.IsEnabled = false;
                Reset_Fields();
                getEquipamentoByID(ID);
            }
            
        }

        public void getEquipamentoByID(int id)
        {
            string queryString;

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                queryString = "SELECT * FROM dbo.getEquipmentByID(" + id+ ")";

                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    reader.Read();
                    ID_TextBox.Text = reader["ID"].ToString();
                    Nome_TextBox.Text = reader["Nome"].ToString();
                    Estado_ComboBox.SelectedIndex = Convert.ToInt32(reader["Estado"]);
                    Localizacao_TextBox.Text = reader["Localizacao"].ToString();
                    Member_TextBox.Text = reader["Membro_nome"].ToString();
                    member_name = reader["Membro_nome"].ToString();
                    Dador_TextBox.Text = reader["Dador"].ToString();
                    Descricao_TextBox.Text = reader["Descricao"].ToString();
                }
            }
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.GoBack();
        }

        private void showActiveMembers_Click(object sender, RoutedEventArgs e)
        {
            getMain().EqActiveMembersDataGrid.ItemsSource = getActiveMembers();
            MainWindow.FlyoutPage = this;
            MainWindow.Page_label = "Equipamento";
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

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            Nome_TextBox.IsReadOnly = false;
            Estado_ComboBox.IsEnabled = true;
            Localizacao_TextBox.IsReadOnly = false;
            showActiveMembers.IsEnabled = true;
            Dador_TextBox.IsReadOnly = false;
            Descricao_TextBox.IsReadOnly = false;
            Edit.Visibility = Visibility.Hidden;
            Delete.Visibility = Visibility.Hidden;
            Save.Visibility = Visibility.Visible;
            Cancel.Visibility = Visibility.Visible;
        }

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            String[] values = { ID.ToString() };
            DB.getDB().executeNonResultQuery("DELETE FROM EQUIPAMENTO WHERE ID = {};", values);
            this.NavigationService.GoBack();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            Object estado;
            if (Estado_ComboBox.SelectedIndex == -1) estado = DBNull.Value;
            else estado = Estado_ComboBox.SelectedIndex;

            Object[] values = { ID, Nome_TextBox.Text, Descricao_TextBox.Text, Localizacao_TextBox.Text, estado, Dador_TextBox.Text, member_id };
            DB.getDB().executeNonResultQuery("EXEC ModifyEquipamento {}, {}, {}, {}, {}, {}, {}", values);
            Reset_Fields();
            showActiveMembers.IsEnabled = false;
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            Reset_Fields();
            showActiveMembers.IsEnabled = false;
            getEquipamentoByID(ID);
        }

        private void Create_Click(object sender, RoutedEventArgs e)
        {
            Object estado;
            if (Estado_ComboBox.SelectedIndex == -1) estado = DBNull.Value;
            else estado = Estado_ComboBox.SelectedIndex;

            Object[] values = { DBNull.Value, Nome_TextBox.Text, Descricao_TextBox.Text, Localizacao_TextBox.Text, estado, Dador_TextBox.Text, member_id };
            DB.getDB().executeNonResultQuery("EXEC ModifyEquipamento {}, {}, {}, {}, {}, {}, {}", values);
            Reset_Fields();
            showActiveMembers.IsEnabled = false;
            this.NavigationService.GoBack();
        }

        public void updateMemberName()
        {
            Member_TextBox.Text = member_name;
        }

        private void Reset_Fields()
        {
            Nome_TextBox.IsReadOnly = true;
            Estado_ComboBox.IsEnabled = false;
            Localizacao_TextBox.IsReadOnly = true;
            Dador_TextBox.IsReadOnly = true;
            Descricao_TextBox.IsReadOnly = true;
            Edit.Visibility = Visibility.Visible;
            Delete.Visibility = Visibility.Visible;
            Save.Visibility = Visibility.Hidden;
            Cancel.Visibility = Visibility.Hidden;
        }
    }
}
