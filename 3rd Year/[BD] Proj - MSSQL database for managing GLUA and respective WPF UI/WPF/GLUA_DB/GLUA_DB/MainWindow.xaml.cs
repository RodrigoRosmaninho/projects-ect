using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
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
using MahApps.Metro.Controls;

namespace GLUA_DB
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    /// 
    public partial class MainWindow : MetroWindow
    {
        
        public static Page FlyoutPage;
        public static String Page_label;
        public ArrayList membersSelectedIndex_SessaoActiveMembers = new ArrayList(100);
        public static string Email;
        public int member_id;

        public MainWindow(string email)
        {
            InitializeComponent();
            HamburgerMenuControl.SelectedIndex = 0;
            Email = email;
        }

        public void InitializeSessaoMembersFlyout_List(int sessao_id)
        {
            membersSelectedIndex_SessaoActiveMembers.Clear();

            //query to get the id of the members that are in the session
            string queryString =
                "SELECT * FROM getMembersBySessionID(" + sessao_id + "); ";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        membersSelectedIndex_SessaoActiveMembers.Add(Convert.ToInt32(reader["Membro_id"]));
                    }
                    reader.Close();
                }
            }
        }

        public void InitializeAtendimentoMembersFlyout_List(int atendimento_id)
        {
            membersSelectedIndex_SessaoActiveMembers.Clear();

            //query to get the id of the members that are in the session
            string queryString =
                "SELECT * FROM getMembersByAtendimentoID(" + atendimento_id + "); ";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        membersSelectedIndex_SessaoActiveMembers.Add(Convert.ToInt32(reader["ID"]));
                    }
                    reader.Close();
                }
            }
        }

        private void HamburgerMenuControl_OnItemClick(object sender, ItemClickEventArgs e)
        {
            // set the content
            this.HamburgerMenuControl.Content = e.ClickedItem;
            string targetView = ((HamburgerMenuGlyphItem)e.ClickedItem).Tag.ToString();
            //HamburgerMenuControl.TheContentGrid.TheContent._Frame.Source = new Uri(targetView, UriKind.Relative);
            // close the pane
            this.HamburgerMenuControl.IsPaneOpen = false;
        }

        private void RowActiveMembersSessao_Click(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;


            IEnumerable<int> member_id = GetSelectedMember((DataGrid)sender);

            foreach (int id in member_id)
            {
                if (membersSelectedIndex_SessaoActiveMembers.Contains(id)) membersSelectedIndex_SessaoActiveMembers.Remove(id);
                else membersSelectedIndex_SessaoActiveMembers.Add(id);
            }
            IEnumerable aux = MembrosAtivosDataGrid.ItemsSource;
            MembrosAtivosDataGrid.ItemsSource = null;
            MembrosAtivosDataGrid.ItemsSource = aux;
            Dispatcher.InvokeAsync(() => { fillMembers(); },
        DispatcherPriority.ApplicationIdle);

        }


        private IEnumerable<int> GetSelectedMember(DataGrid grid)
        {
            var itemsSource = grid.ItemsSource as IEnumerable;
            if (null == itemsSource) yield return -1;
            foreach (var item in itemsSource)
            {
                var row = grid.ItemContainerGenerator.ContainerFromItem(item) as DataGridRow;
                if (null != row && row.IsSelected) yield return Convert.ToInt32(((DataRowView)item).Row[0]);
            }
        }

        private void Access_Click(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            DataRowView r = (DataRowView) row.Item;
            Plataforma_ComboBox.SelectedIndex = Plataforma_ComboBox.Items.IndexOf(r.Row["Plataforma"].ToString());
            Username_TextBox.Text = r.Row["Username"].ToString();
            Tipo_TextBox.Text = r.Row["Tipo"].ToString();
            Add_Access.Visibility = Visibility.Hidden;
            Save_Access.Visibility = Visibility.Visible;
            Delete_Access.Visibility = Visibility.Visible;

        }

        private void AddList_Click(object sender, RoutedEventArgs e)
        {
        
        }

        private void RemoveList_Click(object sender, RoutedEventArgs e)
        {
          
        }

        private void ApplyList_Click(object sender, RoutedEventArgs e)
        {
            if (FlyoutPage is Sessao)
            {
                Object[] values = { Sessao.ID };
                DB.getDB().executeNonResultQuery("DELETE FROM PARTICIPACAO WHERE Sessao_id = {};", values);

                for (int i = 0; i < membersSelectedIndex_SessaoActiveMembers.Count; i++)
                {

                    int m_id = (int)membersSelectedIndex_SessaoActiveMembers[i];
                    Object[] new_values = { m_id, Sessao.ID };
                    DB.getDB().executeNonResultQuery("INSERT INTO PARTICIPACAO VALUES ( {}, {} );", new_values);
                }


            ((Sessao)FlyoutPage).getMembersInSession(Sessao.ID);
                SelectMembersFlyout.IsOpen = false;
            }

            if (FlyoutPage is Atendimento)
            {
                Object[] values = { (FlyoutPage as Atendimento).ID };
                DB.getDB().executeNonResultQuery("DELETE FROM PRESTACAO WHERE Atendimento_id = {};", values);

                for (int i = 0; i < membersSelectedIndex_SessaoActiveMembers.Count; i++)
                {

                    int m_id = (int)membersSelectedIndex_SessaoActiveMembers[i];
                    Object[] new_values = { m_id, (FlyoutPage as Atendimento).ID };
                    DB.getDB().executeNonResultQuery("INSERT INTO PRESTACAO VALUES ( {}, {} );", new_values);
                }


                SelectMembersFlyout.IsOpen = false;
            }
        }

        public void fillMembers()
        {
            foreach (int index in membersSelectedIndex_SessaoActiveMembers)
            {
                Trace.WriteLine(index.ToString());
                var itemsSource = MembrosAtivosDataGrid.ItemsSource as IEnumerable;
                foreach (var item in itemsSource)
                {
                    int member_id = Convert.ToInt32(((DataRowView)item).Row[0]);
                    var row = MembrosAtivosDataGrid.ItemContainerGenerator.ContainerFromItem(item) as DataGridRow;
                    if (row != null && member_id == index) row.IsSelected = true;
                }
            }
        }

        private void RowProblems_Click(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Problema rowPage = new Problema((int)(((DataRowView)row.Item).Row["ID"]));
            ProblemsFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void RowAttempts_Click(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Tentativa rowPage = new Tentativa((int)(((DataRowView)row.Item).Row["Problema_id"]), (int)(((DataRowView)row.Item).Row["Atendimento_id"]));
            AttemptsFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void RowNewAttempt_Click(object sender, RoutedEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Tentativa rowPage = new Tentativa((int)(((DataRowView)row.Item).Row["ID"]), (FlyoutPage as Atendimento).ID, true, (FlyoutPage as Atendimento).data);
            NewAttemptFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void showAtendimento_DoubleClick(object sender, RoutedEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Atendimento rowPage = new Atendimento((int)(((DataRowView)row.Item).Row["ID"]));
            AtendimentosSessaoFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void MemberInventory_DoubleClick(object sender, RoutedEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;

            int res = 1;
            int id = (int)(((DataRowView)row.Item).Row["ID"]);

            using (SqlConnection conn = new SqlConnection(DB.getDB().getConnectionString()))
            using (SqlCommand cmd = conn.CreateCommand())
            {
                cmd.CommandText = "isFlashDrive";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("ID", id);

                var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;

                conn.Open();
                cmd.ExecuteNonQuery();
                res = (returnParameter.Value as Nullable<int>).GetValueOrDefault(2);
            }

            Page rowPage;
            if(res == 1) rowPage = new FlashDrive(id);
            else rowPage = new Equipamento(id);
            inventoryFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void MemberHelpdesk_DoubleClick(object sender, RoutedEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Sessao rowPage = new Sessao((int)(((DataRowView)row.Item).Row["ID"]));
            memberHelpdeskFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void MemberAtendimento_DoubleClick(object sender, RoutedEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Atendimento rowPage = new Atendimento((int)(((DataRowView)row.Item).Row["ID"]));
            memberSessionFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void LastAtendimento_DoubleClick(object sender, RoutedEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Atendimento rowPage = new Atendimento((int)(((DataRowView)row.Item).Row["ID"]));
            utenteLastSessionFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void UtenteProblems_DoubleClick(object sender, RoutedEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Problema rowPage = new Problema((int)(((DataRowView)row.Item).Row["ID"]));
            utenteProblemsFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void UtenteAtendimento_DoubleClick(object sender, RoutedEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Atendimento rowPage = new Atendimento((int)(((DataRowView)row.Item).Row["ID"]));
            utenteSessionListFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void AddAccess_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { (String)Plataforma_ComboBox.SelectedItem, member_id, Username_TextBox.Text, Tipo_TextBox.Text};
            DB.getDB().executeNonResultQuery("INSERT INTO ACESSO VALUES ({}, {}, {}, {});", values);
            Membro.refreshAcessoList(this);
        }

        private void SaveAccess_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = {Username_TextBox.Text, Tipo_TextBox.Text, (String)Plataforma_ComboBox.SelectedItem, member_id };
            DB.getDB().executeNonResultQuery("UPDATE ACESSO SET Username = {}, Tipo = {} WHERE Plataforma_nome = {} and Membro_id = {};", values);
            Membro.refreshAcessoList(this);
        }

        private void TopicList_DoubleClick(object sender, RoutedEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Problema rowPage = new Problema((int)(((DataRowView)row.Item).Row["ID"]));
            TopicsListFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void NewProblem_Click(object sender, RoutedEventArgs e)
        {
            Problema rowPage = new Problema(-1);
            NewAttemptFlyout.IsOpen = false;
            FlyoutPage.NavigationService.Navigate(rowPage);
        }

        private void DeleteAccess_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { (String)Plataforma_ComboBox.SelectedItem, member_id };
            DB.getDB().executeNonResultQuery("DELETE FROM ACESSO WHERE Plataforma_nome = {} and Membro_id = {}; ", values);
            Membro.refreshAcessoList(this);
        }


        // Flyout to Create new course
        private void CreateCurso_Click(object sender, RoutedEventArgs e)
        {
            String curso;
            String departamento;
            if(ExistingDep.IsChecked == true)
            {
               departamento = (String)Departamento.SelectedItem;
            }
            else
            {
                departamento = Department_TextBox.Text;
            }
            curso = Curso_TextBox.Text;

            Object[] values = {curso, departamento};
            DB.getDB().executeNonResultQuery("EXEC ModifyCurso {}, {}", values);
            if (Page_label == "Utente"){
                ((Utente)FlyoutPage).getDepartment();
            }
            else
            {
                ((Membro)FlyoutPage).getDepartment();
            }
            utenteCreateCursoFlyout.IsOpen = false;
            
        }

        private void Existent_Radio_Checked(object sender, RoutedEventArgs e)
        {
            Departamento.Visibility = Visibility.Visible;
            Department_TextBox.Visibility = Visibility.Hidden;

        }

        private void NonExistent_Radio_Checked(object sender, RoutedEventArgs e)
        {
            Department_TextBox.Visibility = Visibility.Visible;
            Departamento.Visibility = Visibility.Hidden;
        }
        //

        // Flyout to select one active member

        private void selectMember_DoubleClick(object sender, RoutedEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            int selected_id = ((int)(((DataRowView)row.Item).Row["ID"]));
            String name = ((String)(((DataRowView)row.Item).Row["Nome"]));
            if (FlyoutPage is Atendimento)
            {
                ((Atendimento)FlyoutPage).utente_id = selected_id;
                ((Atendimento)FlyoutPage).updateUtenteName(name);
                EqActiveMembersFlyout.IsOpen = false;
                
            }
            else if (Page_label == "Equipamento")
            {
                ((Equipamento)FlyoutPage).member_id = selected_id;
                ((Equipamento)FlyoutPage).member_name = name;
                ((Equipamento)FlyoutPage).updateMemberName();
                EqActiveMembersFlyout.IsOpen = false;
            }
            else
            {
                ((FlashDrive)FlyoutPage).member_id = selected_id;
                ((FlashDrive)FlyoutPage).member_name = name;
                ((FlashDrive)FlyoutPage).updateMemberName();
                EqActiveMembersFlyout.IsOpen = false;
            }

        }
    }
}
