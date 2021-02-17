using System;
using System.Collections;
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
    /// Interaction logic for Sessao.xaml
    /// </summary>
    public partial class Sessao : Page
    {

        public static int ID;
        protected static DataTable lista_membros;
        protected static int N_membros;
        protected MainWindow main;

        public Sessao(int id)
        {
            InitializeComponent();
            ID = id;
            if (id < 0)
            {
                NMembros_TextBox.Visibility = Visibility.Hidden;
                showmembros_label.Visibility = Visibility.Hidden;
                showSessions.Visibility = Visibility.Hidden;
                Edit.Visibility = Visibility.Hidden;
                Delete.Visibility = Visibility.Hidden;
                Save.Visibility = Visibility.Hidden;
                Cancel.Visibility = Visibility.Hidden;
                showAtendimentos.Visibility = Visibility.Hidden;
                addSessao.Visibility = Visibility.Visible;
                addAtendimentos.Visibility = Visibility.Hidden;
                Local_TextBox.IsReadOnly = false;
                NEsperado_TextBox.IsReadOnly = false;
                Data_DatePicker.Focusable = true;
                Data_DatePicker.IsHitTestVisible = true;
            }
            else
            {
                getSessaoByID(id);
                getMembersInSession(id);
                NMembros_TextBox.IsReadOnly = true;
                addSessao.Visibility = Visibility.Hidden;
            }
            
        }

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            Local_TextBox.IsReadOnly = false;
            NEsperado_TextBox.IsReadOnly = false;
            Edit.Visibility = Visibility.Hidden;
            Delete.Visibility = Visibility.Hidden;
            Save.Visibility = Visibility.Visible;
            Cancel.Visibility = Visibility.Visible;
            Data_DatePicker.Focusable = true;
            Data_DatePicker.IsHitTestVisible = true;

        }

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { ID};
            DB.getDB().executeNonResultQuery("DELETE FROM SESSAO WHERE ID = {}", values);
            this.NavigationService.GoBack();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { ID, Data_DatePicker.SelectedDate, Local_TextBox.Text, NEsperado_TextBox.Text };
            DB.getDB().executeNonResultQuery("EXEC ModifySessoes {}, {}, {}, {}", values);

            Local_TextBox.IsReadOnly = true;
            NEsperado_TextBox.IsReadOnly = true;
            Edit.Visibility = Visibility.Visible;
            Delete.Visibility = Visibility.Visible;
            Save.Visibility = Visibility.Hidden;
            Cancel.Visibility = Visibility.Hidden;
            Data_DatePicker.Focusable = false;
            Data_DatePicker.IsHitTestVisible = false;
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            getSessaoByID(ID);
            getMembersInSession(ID);
            Local_TextBox.IsReadOnly = true;
            NEsperado_TextBox.IsReadOnly = true;
            Edit.Visibility = Visibility.Visible;
            Delete.Visibility = Visibility.Visible;
            Save.Visibility = Visibility.Hidden;
            Cancel.Visibility = Visibility.Hidden;
            Data_DatePicker.Focusable = false;
            Data_DatePicker.IsHitTestVisible = false;
        }

     
        private void getSessaoByID(int id)
        {
            string queryString =
                "SELECT Data, Local, Num_previstos FROM getHelpdeskByID("+ id +") ORDER BY Data DESC";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    reader.Read();
                    Local_TextBox.Text = reader["Local"].ToString();
                    NEsperado_TextBox.Text = reader["Num_previstos"].ToString();
                    Data_DatePicker.SelectedDate = Convert.ToDateTime(reader["Data"]);
                }
            }
        }

        public void getMembersInSession(int id)
        {
            var dt = new DataTable();

            string queryString =
                "SELECT * FROM getMembersBySessionID(" + id + "); ";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("Nome", typeof(string)), new DataColumn("Email", typeof(string)), new DataColumn("Data_entrada", typeof(string)), new DataColumn("Estado", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    int count = 0;
                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["Nome"] = reader["Nome"].ToString();
                        row["Email"] = reader["Email"].ToString();
                        row["Data_entrada"] = reader["Data_entrada"].ToString();
                        row["Estado"] = DB.getMembroEstado(Convert.ToInt32(reader["Estado"]));
                        dt.Rows.Add(row);
                        count++;
                    }

                    reader.Close();
                    N_membros = count;
                    NMembros_TextBox.Text = N_membros.ToString();
                }
            }
            lista_membros = dt;
        }

        private DataView getAtendimentosFromSession(int id)
        {
            var dt = new DataTable();

            string queryString =
                "SELECT * FROM getAtendimentosByHelpdeskID("+ id +")";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("ID", typeof(int)), new DataColumn("Tempo Despendido", typeof(string)), new DataColumn("Fabricante", typeof(string)), new DataColumn("Modelo", typeof(string)), new DataColumn("Utente", typeof(string)), new DataColumn("Número de Problemas", typeof(int)), new DataColumn("Número de Membros", typeof(int)), new DataColumn("Estado", typeof(string)) };
                    dt.Columns.AddRange(dc);

                  
                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        if(!(reader["Tempo_Despendido"] is DBNull)) row["Tempo Despendido"] = DB.getSpentTime(Convert.ToInt32(reader["Tempo_Despendido"]));
                        row["Fabricante"] = reader["Fabricante"].ToString();
                        row["Modelo"] = reader["Modelo"].ToString();
                        row["Utente"] = reader["Utente"].ToString();
                        row["Número de Problemas"] = Convert.ToInt32(reader["problemas_num"]);
                        row["Número de Membros"] = Convert.ToInt32(reader["membros_num"]);
                        if (reader["Estado"] is DBNull) row["Estado"] = "Mal-Sucedido";
                        else row["Estado"] = decodeEstado(Convert.ToInt32(reader["Estado"]));
                        dt.Rows.Add(row);
              
                    }

                    reader.Close();
               
   
                }
            }
            return dt.DefaultView;
        }

        private String decodeEstado(int Estado)
        {
            switch (Estado)
            {
                case 0:
                    return "Bem Sucedido";
                case 1:
                    return "Mal Sucedido";
                case 2:
                    return "Melhoria Parcial";
                default:
                    return "Sem Estado";
            }
        }

        private void showMembrosAtivos_Click(object sender, RoutedEventArgs e)
        {
            void MembrosAtivosDataGrid_AutoGeneratedColumns(object s, EventArgs ea)
            {
                getMain().MembrosAtivosDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            MainWindow.FlyoutPage = this;
            MainWindow.Page_label = "Sessao";
            getMain().MembrosAtivosDataGrid.AutoGeneratedColumns += MembrosAtivosDataGrid_AutoGeneratedColumns;
            getMain().MembrosAtivosDataGrid.ItemsSource = Membros.getMembrosList();
            getMain().SelectMembersFlyout.IsOpen = true;
            getMain().InitializeSessaoMembersFlyout_List(ID);
            Dispatcher.InvokeAsync(() => { getMain().fillMembers(); },
        DispatcherPriority.ApplicationIdle);

        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.GoBack();
        }

        private MainWindow getMain()
        {
            if (main == null)
            {
                main = ((MainWindow)Window.GetWindow(this));
            }
            return main;
        }

        private void showAtendimentos_Click(object sender, RoutedEventArgs e)
        {
            void AtendimentosSessaoDataGrid_AutoGeneratedColumns(object s, EventArgs ea)
            {
                getMain().AtendimentosSessaoDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            MainWindow.FlyoutPage = this;
            getMain().AtendimentosSessaoDataGrid.AutoGeneratedColumns += AtendimentosSessaoDataGrid_AutoGeneratedColumns;
            getMain().AtendimentosSessaoDataGrid.ItemsSource = getAtendimentosFromSession(ID);
            getMain().AtendimentosSessaoFlyout.IsOpen = true;
        }

        private void addAtendimentos_Click(object sender, RoutedEventArgs e)
        {
            Atendimento rowPage = new Atendimento(ID, true, Data_DatePicker.SelectedDate, Local_TextBox.Text);
            this.NavigationService.Navigate(rowPage);
        }

        private void addSessao_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { DBNull.Value, Data_DatePicker.SelectedDate, Local_TextBox.Text, NEsperado_TextBox.Text };
            DB.getDB().executeNonResultQuery("EXEC ModifySessoes {}, {}, {}, {}", values);

            this.NavigationService.GoBack();
        }
    }
}
