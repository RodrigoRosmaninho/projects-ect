﻿using System;
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
    /// Interaction logic for Membro.xaml
    /// </summary>
    public partial class Membro : Page
    {
        protected static int ID;
        protected MainWindow main;

        public Membro(int id)
        {
            InitializeComponent();
            ID = id;
            ID = id;
            if (id < 0)
            {
                Nome_TextBox.IsReadOnly = false;
                Email_TextBox.IsReadOnly = false;
                Telemovel_TextBox.IsReadOnly = false;
                Tipo_ComboBox.IsEnabled = true;
                Estado_ComboBox.IsEnabled = true;
                Data_DatePicker.Focusable = true;
                Data_DatePicker.IsHitTestVisible = true;
                Notas_TextBox.IsReadOnly = false;
                Edit.Visibility = Visibility.Hidden;
                Delete.Visibility = Visibility.Hidden;
                Delete.Visibility = Visibility.Hidden;
                Delete.Visibility = Visibility.Hidden;
                showPlatforms.Visibility = Visibility.Hidden;
                showInventory.Visibility = Visibility.Hidden;
                showHelpdesks.Visibility = Visibility.Hidden;
                showSessions.Visibility = Visibility.Hidden;
                CreateMembro.Visibility = Visibility.Visible;

                No_Radio.IsChecked = true;

                NMec_label.Visibility = Visibility.Hidden;
                NMec_TextBox.Visibility = Visibility.Hidden;
                DataMatricula_label.Visibility = Visibility.Hidden;
                DataMatricula_DatePicker.Visibility = Visibility.Hidden;
                Departamento_label.Visibility = Visibility.Hidden;
                Departamento_Drop.Visibility = Visibility.Hidden;
                Curso_label.Visibility = Visibility.Hidden;
                Curso_Drop.Visibility = Visibility.Hidden;
                add_curso.Visibility = Visibility.Hidden;

                getDepartment();
            }
            else
            {
                Reset_Fields();
                NMec_TextBox.IsReadOnly = true;
                DataMatricula_DatePicker.Focusable = false;
                DataMatricula_DatePicker.IsHitTestVisible = false;
                Departamento_Drop.IsEnabled = false;
                Curso_Drop.IsEnabled = false;
                Yes_Radio.IsEnabled = false;
                No_Radio.IsEnabled = false;
                add_curso.IsEnabled = false;

                CreateMembro.Visibility = Visibility.Hidden;
                getDepartment();
                getMembroByID(id);
                Curso_Drop.IsEnabled = false;
            }
            
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.GoBack();
        }

        private void showPlatforms_Click(object sender, RoutedEventArgs e)
        {
            getMain().member_id = ID;
            getMain().platformsDataGrid.ItemsSource = getAcessoListByMembroID(ID, getMain());
            getMain().platformsFlyout.IsOpen = true;
        }

        private void showInventory_Click(object sender, RoutedEventArgs e)
        {
            MainWindow.FlyoutPage = this;
            getMain().inventoryDataGrid.ItemsSource = getInventarioListByMembroID(ID);
            getMain().inventoryFlyout.IsOpen = true;
        }

        private void showHelpdesk_Click(object sender, RoutedEventArgs e)
        {
            void memberHelpdeskDataGrid_AutoGeneratedColumns(object s, EventArgs ea)
            {
                getMain().memberHelpdeskDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            MainWindow.FlyoutPage = this;
            getMain().memberHelpdeskDataGrid.AutoGeneratedColumns += memberHelpdeskDataGrid_AutoGeneratedColumns;
            getMain().memberHelpdeskDataGrid.ItemsSource = getHelpdeskListByMembroID(ID);
            getMain().memberHelpdeskFlyout.IsOpen = true;
        }

        private void showSessions_Click(object sender, RoutedEventArgs e)
        {
            void memberSessionDataGrid_AutoGeneratedColumns(object s, EventArgs ea)
            {
                getMain().memberSessionDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            MainWindow.FlyoutPage = this;
            getMain().memberSessionDataGrid.AutoGeneratedColumns += memberSessionDataGrid_AutoGeneratedColumns;
            getMain().memberSessionDataGrid.ItemsSource = getAtendimentosListByMembroID(ID);
            getMain().memberSessionFlyout.IsOpen = true;
        }

        private MainWindow getMain()
        {
            if (main == null) {
                main = ((MainWindow)Window.GetWindow(this));
            }
            return main;
        }

        private void getMembroByID(int id)
        {
            string queryString =
                "SELECT * FROM getMembersByID (" + id + ")";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    reader.Read();
                    Nome_TextBox.Text = reader["Nome"].ToString();
                    Email_TextBox.Text = reader["Email"].ToString();
                    Telemovel_TextBox.Text = reader["Num_telemovel"].ToString();
                    Tipo_ComboBox.SelectedIndex = Convert.ToInt32(reader["Tipo"]);
                    Estado_ComboBox.SelectedIndex = Convert.ToInt32(reader["Estado"]);
                    if (!(reader["Data_Entrada"] is DBNull)) Data_DatePicker.SelectedDate = Convert.ToDateTime(reader["Data_entrada"]);
                    Notas_TextBox.Text = reader["Notas"].ToString();
                }
            }
            int isStudent = 0;

            queryString =
               "SELECT dbo.isPersonAlsoStudent(" + id + ");";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    isStudent = (int)cmd.ExecuteScalar();

                    if (isStudent == 1)
                    {
                        Yes_Radio.IsChecked = true;

                        NMec_label.Visibility = Visibility.Visible;
                        NMec_TextBox.Visibility = Visibility.Visible;
                        DataMatricula_label.Visibility = Visibility.Visible;
                        DataMatricula_DatePicker.Visibility = Visibility.Visible;
                        Departamento_label.Visibility = Visibility.Visible;
                        Departamento_Drop.Visibility = Visibility.Visible;
                        Curso_label.Visibility = Visibility.Visible;
                        Curso_Drop.Visibility = Visibility.Visible;


                    }
                    else
                    {
                        No_Radio.IsChecked = true;

                        NMec_label.Visibility = Visibility.Hidden;
                        NMec_TextBox.Visibility = Visibility.Hidden;
                        DataMatricula_label.Visibility = Visibility.Hidden;
                        DataMatricula_DatePicker.Visibility = Visibility.Hidden;
                        Departamento_label.Visibility = Visibility.Hidden;
                        Departamento_Drop.Visibility = Visibility.Hidden;
                        Curso_label.Visibility = Visibility.Hidden;
                        Curso_Drop.Visibility = Visibility.Hidden;
                    }
                }
            }

            if (isStudent == 1)
            {
                queryString =
                "SELECT * FROM getStudentByID (" + id + ");";

                using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
                {
                    using (var cmd = new SqlCommand(queryString, cn))
                    {
                        cn.Open();
                        var reader = cmd.ExecuteReader();

                        reader.Read();
                        NMec_TextBox.Text = reader["Nmec"].ToString();
                        Departamento_Drop.SelectedIndex = Departamento_Drop.Items.IndexOf(reader["Departamento"].ToString());
                        Curso_Drop.SelectedIndex = Curso_Drop.Items.IndexOf(reader["Curso"].ToString());
                        DataMatricula_DatePicker.SelectedDate = Convert.ToDateTime(reader["Ano_matricula"]);
                    }
                }
            }
        }

        public static void refreshAcessoList(MainWindow main)
        {
            main.platformsDataGrid.ItemsSource = getAcessoListByMembroID(ID, main);
        }

        private static DataView getAcessoListByMembroID(int MembroID, MainWindow main)
        {
            var dt = new DataTable();

            string queryString =
                "SELECT * FROM getPlataformsAcessListByMembersID ("+ MembroID +") ORDER BY Plataforma_nome;";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("Plataforma", typeof(string)), new DataColumn("Username", typeof(string)), new DataColumn("Tipo", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["Plataforma"] = reader["Plataforma_nome"].ToString();
                        row["Username"] = reader["Username"].ToString();
                        row["Tipo"] = reader["Tipo"].ToString();
                        dt.Rows.Add(row);
                    }

                    reader.Close();
                }

                queryString = "SELECT Nome FROM dbo.PLATAFORMA ORDER BY Nome";

                using (var cmd = new SqlCommand(queryString, cn))
                {
                    var reader = cmd.ExecuteReader();

                    main.Plataforma_ComboBox.Items.Clear();

                    while (reader.Read())
                    {
                        main.Plataforma_ComboBox.Items.Add(reader["Nome"].ToString());
                    }
                }
            }

            main.Plataforma_ComboBox.SelectedIndex = -1;
            main.Username_TextBox.Text = "";
            main.Tipo_TextBox.Text = "";

            main.Add_Access.Visibility = Visibility.Visible;
            main.Save_Access.Visibility = Visibility.Hidden;
            main.Delete_Access.Visibility = Visibility.Hidden;

            return dt.DefaultView;
        }

        private DataView getInventarioListByMembroID(int MembroID)
        {
            string queryString =
                "SELECT * FROM getEquipmentListByMemberID ("+ MembroID + ") ORDER BY ID;";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("ID", typeof(int)), new DataColumn("Nome", typeof(string)), new DataColumn("Descricao", typeof(string)), new DataColumn("Estado", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        row["Nome"] = reader["Nome"].ToString();
                        row["Descricao"] = reader["Descricao"].ToString();
                        row["Estado"] = DB.getEquipamentoEstado(Convert.ToInt32(reader["Estado"]));
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

        private DataView getHelpdeskListByMembroID(int MembroID)
        {
            string queryString =
                "SELECT * FROM getHelpSessionsListByMemberID ("+ MembroID + ") ORDER BY Data DESC;";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("id", typeof(int)), new DataColumn("Data", typeof(string)), new DataColumn("Local", typeof(string)), new DataColumn("Previstos", typeof(int)), new DataColumn("Realizados", typeof(int)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        row["Data"] = Convert.ToDateTime(reader["Data"]).ToString("yyyy/MM/dd");
                        row["Local"] = reader["Local"].ToString();
                        if (!(reader["Num_previstos"] is DBNull))
                        {
                            row["Previstos"] = Convert.ToInt32(reader["Num_previstos"]);
                        }
                        if (!(reader["Num_realizados"] is DBNull))
                        {
                            row["Realizados"] = Convert.ToInt32(reader["Num_realizados"]);
                        }
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

        private DataView getAtendimentosListByMembroID(int MembroID)
        {
            string queryString =
                "SELECT * FROM getAtendimentosListByMemberID (" + MembroID + ") ORDER BY Data DESC";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("id", typeof(int)), new DataColumn("Data", typeof(string)), new DataColumn("Utente", typeof(string)), new DataColumn("Local", typeof(string)), new DataColumn("Tempo Despendido", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["Atendimento_ID"]);
                        row["Data"] = Convert.ToDateTime(reader["Data"]).ToString("yyyy/MM/dd");
                        row["Utente"] = reader["Nome"].ToString();
                        row["Local"] = reader["Local"].ToString();
                        if (!(reader["Tempo_despendido"] is DBNull))
                        {
                            row["Tempo Despendido"] = DB.getSpentTime(Convert.ToInt32(reader["Tempo_despendido"]));
                        }
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            Nome_TextBox.IsReadOnly = false;
            Email_TextBox.IsReadOnly = false;
            Telemovel_TextBox.IsReadOnly = false;
            Tipo_ComboBox.IsEnabled = true;
            Estado_ComboBox.IsEnabled = true;
            Data_DatePicker.Focusable = true;
            Data_DatePicker.IsHitTestVisible = true;
            Notas_TextBox.IsReadOnly = false;
            Edit.Visibility = Visibility.Hidden;
            Delete.Visibility = Visibility.Hidden;
            Save.Visibility = Visibility.Visible;
            Cancel.Visibility = Visibility.Visible;
            showPlatforms.IsEnabled = false;
            showInventory.IsEnabled = false;
            showHelpdesks.IsEnabled = false;
            showSessions.IsEnabled = false;
            Yes_Radio.IsEnabled = true;
            No_Radio.IsEnabled = true;
            add_curso.IsEnabled = true;
            NMec_TextBox.IsReadOnly = false;
            DataMatricula_DatePicker.Focusable = true;
            DataMatricula_DatePicker.IsHitTestVisible = true;
            Departamento_Drop.IsEnabled = true;
            Curso_Drop.IsEnabled = true;
        }

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            String[] values = { ID.ToString() };
            DB.getDB().executeNonResultQuery("DELETE FROM MEMBRO WHERE ID = {};", values);
            this.NavigationService.GoBack();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            String isStudent = "false";
            Object Nmec = 0;
            Object curso = DBNull.Value;
            Object date = new DateTime(2015, 12, 25);
            if (Yes_Radio.IsChecked == true)
            {
                isStudent = "true";
                Nmec = Convert.ToInt32(NMec_TextBox.Text);
                curso = (String)Curso_Drop.SelectedItem;
                date = DataMatricula_DatePicker.SelectedDate;

            }

            Object tipo;
            if (Tipo_ComboBox.SelectedIndex == -1) tipo = DBNull.Value;
            else tipo = Tipo_ComboBox.SelectedIndex;

            Object estado;
            if (Estado_ComboBox.SelectedIndex == -1) estado = DBNull.Value;
            else estado = Estado_ComboBox.SelectedIndex;

            Object data;
            if (Data_DatePicker.SelectedDate == null) data = DBNull.Value;
            else data = Data_DatePicker.SelectedDate;

            Object notas;
            if (Notas_TextBox.Text == null) notas = DBNull.Value;
            else notas = Notas_TextBox.Text;


            Object[] values ={ ID, Nome_TextBox.Text, notas, Email_TextBox.Text, Convert.ToInt32(Telemovel_TextBox.Text), tipo, estado, data, isStudent, Nmec, curso, date };
            DB.getDB().executeNonResultQuery("EXEC ModifyMembro {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}", values);

            Reset_Fields();
            Yes_Radio.IsEnabled = false;
            No_Radio.IsEnabled = false;
            add_curso.IsEnabled = false;
            NMec_TextBox.IsReadOnly = true;
            DataMatricula_DatePicker.Focusable = false;
            DataMatricula_DatePicker.IsHitTestVisible = false;
            Departamento_Drop.IsEnabled = false;
            Curso_Drop.IsEnabled = false;
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            Reset_Fields();
            Yes_Radio.IsEnabled = false;
            No_Radio.IsEnabled = false;
            add_curso.IsEnabled = false;
            NMec_TextBox.IsReadOnly = true;
            DataMatricula_DatePicker.Focusable = false;
            DataMatricula_DatePicker.IsHitTestVisible = false;
            Departamento_Drop.IsEnabled = false;
            Curso_Drop.IsEnabled = false;
            getMembroByID(ID);
        }

        private void Reset_Fields()
        {
            Nome_TextBox.IsReadOnly = true;
            Email_TextBox.IsReadOnly = true;
            Telemovel_TextBox.IsReadOnly = true;
            Tipo_ComboBox.IsEnabled = false;
            Estado_ComboBox.IsEnabled = false;
            Data_DatePicker.Focusable = false;
            Data_DatePicker.IsHitTestVisible = false;
            Notas_TextBox.IsReadOnly = true;
            Edit.Visibility = Visibility.Visible;
            Delete.Visibility = Visibility.Visible;
            Save.Visibility = Visibility.Hidden;
            Cancel.Visibility = Visibility.Hidden;
            showPlatforms.IsEnabled = true;
            showInventory.IsEnabled = true;
            showHelpdesks.IsEnabled = true;
            showSessions.IsEnabled = true;
        }

        private void createMembro_Click(object sender, RoutedEventArgs e)
        {
            String isStudent = "false";
            Object Nmec = DBNull.Value;
            Object curso = DBNull.Value;
            Object date = DBNull.Value;
            if (Yes_Radio.IsChecked == true)
            {
                isStudent = "true";
                Nmec = Convert.ToInt32(NMec_TextBox.Text);
                curso = (String)Curso_Drop.SelectedItem;
                date = DataMatricula_DatePicker.SelectedDate;

            }


            Object tipo;
            if (Tipo_ComboBox.SelectedIndex == -1) tipo = DBNull.Value;
            else tipo = Tipo_ComboBox.SelectedIndex;

            Object estado;
            if (Estado_ComboBox.SelectedIndex == -1) estado = DBNull.Value;
            else estado = Estado_ComboBox.SelectedIndex;

            Object data;
            if (Data_DatePicker.SelectedDate == null) data = DBNull.Value;
            else data = Data_DatePicker.SelectedDate;

            Object notas;
            if (Notas_TextBox.Text == null) notas = DBNull.Value;
            else notas = Notas_TextBox.Text;

            Object[] values = { DBNull.Value, Nome_TextBox.Text, notas, Email_TextBox.Text, Convert.ToInt32(Telemovel_TextBox.Text), tipo, estado, data, isStudent, Nmec, curso, date };
            DB.getDB().executeNonResultQuery("EXEC ModifyMembro {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}", values);

            this.NavigationService.GoBack();
        }



        private void Yes_Radio_Checked(object sender, RoutedEventArgs e)
        {
            NMec_label.Visibility = Visibility.Visible;
            NMec_TextBox.Visibility = Visibility.Visible;
            DataMatricula_label.Visibility = Visibility.Visible;
            DataMatricula_DatePicker.Visibility = Visibility.Visible;
            Departamento_label.Visibility = Visibility.Visible;
            Departamento_Drop.Visibility = Visibility.Visible;
            Curso_label.Visibility = Visibility.Visible;
            Curso_Drop.Visibility = Visibility.Visible;
            add_curso.Visibility = Visibility.Visible;

        }

        private void No_Radio_Checked(object sender, RoutedEventArgs e)
        {
            NMec_label.Visibility = Visibility.Hidden;
            NMec_TextBox.Visibility = Visibility.Hidden;
            DataMatricula_label.Visibility = Visibility.Hidden;
            DataMatricula_DatePicker.Visibility = Visibility.Hidden;
            Departamento_label.Visibility = Visibility.Hidden;
            Departamento_Drop.Visibility = Visibility.Hidden;
            Curso_label.Visibility = Visibility.Hidden;
            Curso_Drop.Visibility = Visibility.Hidden;
            add_curso.Visibility = Visibility.Hidden;
        }

        private void Departamento_ComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            String Dep = (String)Departamento_Drop.SelectedItem;
            Curso_Drop.IsEnabled = false;

            string queryString =
                "SELECT * FROM getCoursesByDepName ( @Dep );"; 

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    cmd.Parameters.AddWithValue("@Dep", Dep);
                    var reader = cmd.ExecuteReader();

                    Curso_Drop.Items.Clear();

                    while (reader.Read())
                    {
                        if (reader["Sigla"].ToString() != "") Curso_Drop.Items.Add(reader["Sigla"].ToString());
                    }
                }
            }

            if (Curso_Drop.Items.Count > 0)
            {
                Curso_Drop.IsEnabled = true;
            }
        }

        public void getDepartment()
        {
            String queryString = "SELECT DISTINCT Departamento FROM Curso";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    Departamento_Drop.Items.Clear();

                    while (reader.Read())
                    {
                        Departamento_Drop.Items.Add(reader["Departamento"].ToString());
                    }

                    reader.Close();
                }
            }
        }

        private void showCreateCurso_Click(object sender, RoutedEventArgs e)
        {
            String queryString = "SELECT DISTINCT Departamento FROM Curso";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    getMain().Departamento.Items.Clear();

                    while (reader.Read())
                    {
                        getMain().Departamento.Items.Add(reader["Departamento"].ToString());
                    }

                    reader.Close();
                }
            }
            getMain().nonExistingDep.IsChecked = true;
            getMain().Departamento.Visibility = Visibility.Hidden;
            MainWindow.FlyoutPage = this;
            MainWindow.Page_label = "Membro";
            getMain().utenteCreateCursoFlyout.IsOpen = true;
        }
    }
}
