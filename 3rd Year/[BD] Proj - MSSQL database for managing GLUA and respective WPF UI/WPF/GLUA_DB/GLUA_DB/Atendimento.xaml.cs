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
    /// Interaction logic for Atendimento.xaml
    /// </summary>
    public partial class Atendimento : Page
    {
        public int ID;
        public string data;
        public int utente_id;
        private int session_id;
        private bool IsNew;
        public MainWindow main;
        private bool edit;

        public Atendimento(int id)
        {
            InitializeComponent();
            ID = id;
            IsNew = ID >= 0;
            edit = false;
            session_id = -1;
            getAtendimentoByID(ID);
            if(ID >= 0) Reset_Fields();
        }

        public Atendimento(int sid, bool IsNew, DateTime? data, string local)
        {
            InitializeComponent();
            ID = -1;
            this.IsNew = true;
            session_id = sid;
            getAtendimentoByID(-1);
            Data_DatePicker.Focusable = false;
            Data_DatePicker.IsHitTestVisible = false;
            Data_DatePicker.SelectedDate = data;
            Local_TextBox.Text = local;
            Local_TextBox.IsReadOnly = true;
        }

        private void getAtendimentoByID(int id)
        {
            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {    
                string queryString = "SELECT DISTINCT Fabricante FROM dbo.PC";

                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    Fabricante_ComboBox.Items.Clear();
                    Fabricante_ComboBox.Items.Add("Não Especificado");

                    while (reader.Read())
                    {
                        Fabricante_ComboBox.Items.Add(reader["Fabricante"].ToString());
                    }

                    reader.Close();
                }

                if (id >= 0)
                {
                    queryString = "SELECT * FROM dbo.getAtendimentoByID(" + id + ");";

                    using (var cmd = new SqlCommand(queryString, cn))
                    {
                        var reader = cmd.ExecuteReader();

                        reader.Read();
                        if (reader["Fabricante"] is DBNull) Fabricante_ComboBox.SelectedIndex = 0;
                        else Fabricante_ComboBox.SelectedIndex = Fabricante_ComboBox.Items.IndexOf(reader["Fabricante"].ToString());
                        if (reader["Data"] is DBNull)
                        {
                            data = reader["Helpdesk_Data"].ToString();
                            Data_DatePicker.SelectedDate = Convert.ToDateTime(reader["Helpdesk_Data"]);
                        }
                        else
                        {
                            data = reader["Data"].ToString();
                            Data_DatePicker.SelectedDate = Convert.ToDateTime(reader["Data"]);
                        }
                        if (reader["Local"] is DBNull) Local_TextBox.Text = reader["Helpdesk_Local"].ToString();
                        else Local_TextBox.Text = reader["Local"].ToString();
                        Utente_TextBox.Text = reader["Utente"].ToString();
                        if (!(reader["Tempo_despendido"] is DBNull)) Tempo_TextBox.Text = DB.getSpentTime(Convert.ToInt32(reader["Tempo_despendido"]));
                        Modelo_ComboBox.SelectedIndex = Modelo_ComboBox.Items.IndexOf(reader["Modelo"].ToString());
                        utente_id = Convert.ToInt32(reader["Utente_id"]);
                        if (!(reader["Sessao_id"] is DBNull) && session_id == -1) session_id = Convert.ToInt32(reader["Sessao_id"]);
                    }
                    Reset_Fields();
                }
                else
                {
                    Fabricante_ComboBox.SelectedIndex = 0;
                    addProblem.Visibility = Visibility.Hidden;
                    showProblemas.Visibility = Visibility.Hidden;
                    Edit_Click(null, null);
                    showMembros.Visibility = Visibility.Hidden;
                }
            }
        }

        public static DataView getProblemsByAtendimento(int ID)
        {
            string queryString =
                "SELECT * FROM dbo.getProblemsByAtendimentoID(" + ID + ")";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("ID", typeof(int)), new DataColumn("Descrição", typeof(string)), new DataColumn("SO", typeof(string)), new DataColumn("Versao", typeof(string)), new DataColumn("Fabricante", typeof(string)), new DataColumn("Modelo", typeof(string))};
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        row["Descrição"] = reader["Descricao"].ToString();
                        row["Fabricante"] = reader["Fabricante"].ToString();
                        row["Modelo"] = reader["Modelo"].ToString();
                        row["SO"] = reader["SO"].ToString();
                        row["Versao"] = reader["Versao"].ToString();
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

        private void showMembers()
        {
            void EqActiveMembersDataGrid_AutoGeneratedColumns(object s, EventArgs ea)
            {
                getMain().EqActiveMembersDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            MainWindow.FlyoutPage = this;
            getMain().EqActiveMembersDataGrid.AutoGeneratedColumns += EqActiveMembersDataGrid_AutoGeneratedColumns;
            getMain().EqActiveMembersDataGrid.ItemsSource = getUtentesList();
            getMain().EqActiveMembersFlyout.Header = "Utentes";
            getMain().EqActiveMembersFlyout.IsOpen = true;
        }

        public void updateUtenteName(string name)
        {
            Utente_TextBox.Text = name;
        }

        private DataView getUtentesList()
        {
            string queryString =
                "SELECT Pessoa.ID as ID, Nome, Contacto, Notas FROM Utente JOIN Pessoa ON Utente.ID = Pessoa.ID;";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("ID", typeof(int)), new DataColumn("Nome", typeof(string)), new DataColumn("Contacto", typeof(string)), new DataColumn("Notas", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        row["Nome"] = reader["Nome"].ToString();
                        row["Contacto"] = reader["Contacto"].ToString();
                        if (row["Contacto"].Equals("")) row["Contacto"] = "///////////////";

                        row["Notas"] = reader["Notas"].ToString();
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
            edit = true;
            if (session_id == -1)
            {
                Data_DatePicker.Focusable = true;
                Data_DatePicker.IsHitTestVisible = true;
                Local_TextBox.IsReadOnly = false;
            }
            Tempo_TextBox.IsReadOnly = false;
            Fabricante_ComboBox.IsEnabled = true;
            showUtente.Content = "Alterar";
            if (Modelo_ComboBox.Items.Count > 0) Modelo_ComboBox.IsEnabled = true;
            else Modelo_ComboBox.IsEnabled = false;
            Edit.Visibility = Visibility.Hidden;
            Delete.Visibility = Visibility.Hidden;
            Save.Visibility = Visibility.Visible;
            Cancel.Visibility = Visibility.Visible;
        }

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { ID };
            DB.getDB().executeNonResultQuery("DELETE FROM ATENDIMENTO WHERE ID = {};", values);
            this.NavigationService.GoBack();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            Object id = ID;
            if (ID < 0) id = DBNull.Value;
            Object sid = session_id;
            if (session_id < 0) sid = DBNull.Value;
            Object pc;
            if ((String)Fabricante_ComboBox.SelectedItem == "Não Especificado") pc = DBNull.Value;
            else pc = DB.getDB().getIdFromPCFabricante((String)Fabricante_ComboBox.SelectedItem, (String)Modelo_ComboBox.SelectedItem);
            Object[] values = { id, Data_DatePicker.SelectedDate, Local_TextBox.Text, DB.getIntFromTime(Tempo_TextBox.Text), pc, sid, utente_id };
            DB.getDB().executeNonResultQuery("EXEC ModifyAtendimentos {}, {}, {}, {}, {}, {}, {}", values);
            this.NavigationService.GoBack();
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            if (IsNew)
            {
                this.NavigationService.GoBack();
                return;
            }
            edit = false;
            getAtendimentoByID(ID);
            Reset_Fields();
        }

        private void Reset_Fields()
        {
            Data_DatePicker.Focusable = false;
            Data_DatePicker.IsHitTestVisible = false;
            Local_TextBox.IsReadOnly = true;
            Tempo_TextBox.IsReadOnly = true;
            Fabricante_ComboBox.IsEnabled = false;
            Modelo_ComboBox.IsEnabled = false;
            showUtente.Content = "Ver";
            Modelo_ComboBox.IsEnabled = false;
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
                "SELECT * FROM getPCsByFabricante (@Fabricante);"; 
            
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

        private void showUtente_Click(object sender, RoutedEventArgs e)
        {
            if (edit) showMembers();
            else
            {
                Utente rowPage = new Utente(utente_id);
                this.NavigationService.Navigate(rowPage);
            }
        }

        private void showMembrosAtivos_Click(object sender, RoutedEventArgs e)
        {
            void MembrosAtivosDataGrid_AutoGeneratedColumns(object s, EventArgs ea)
            {
                getMain().MembrosAtivosDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            MainWindow.FlyoutPage = this;
            getMain().MembrosAtivosDataGrid.AutoGeneratedColumns += MembrosAtivosDataGrid_AutoGeneratedColumns;
            getMain().MembrosAtivosDataGrid.ItemsSource = Membros.getMembrosList();
            getMain().SelectMembersFlyout.IsOpen = true;
            getMain().InitializeAtendimentoMembersFlyout_List(ID);
            Dispatcher.InvokeAsync(() => { getMain().fillMembers(); },
        DispatcherPriority.ApplicationIdle);

        }

        private MainWindow getMain()
        {
            if (main == null)
            {
                main = ((MainWindow)Window.GetWindow(this));
            }
            return main;
        }

        private void showProblemas_Click(object sender, RoutedEventArgs e)
        {
            void ProblemsDataGrid_AutoGeneratedColumns(object s, EventArgs ea)
            {
                getMain().ProblemsDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            MainWindow.FlyoutPage = this;
            getMain().ProblemsDataGrid.AutoGeneratedColumns += ProblemsDataGrid_AutoGeneratedColumns;
            getMain().ProblemsDataGrid.ItemsSource = getProblemsByAtendimento(ID);
            getMain().ProblemsFlyout.IsOpen = true;
        }

        private void addProblem_Click(object sender, RoutedEventArgs e)
        {
            void NewAttemptDataGrid_AutoGeneratedColumns(object s, EventArgs ea)
            {
                getMain().NewAttemptDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            MainWindow.FlyoutPage = this;
            getMain().NewAttemptDataGrid.AutoGeneratedColumns += NewAttemptDataGrid_AutoGeneratedColumns;
            getMain().NewAttemptDataGrid.ItemsSource = Problemas.getProblemsList();
            getMain().NewAttemptFlyout.IsOpen = true;
        }

    }
}
