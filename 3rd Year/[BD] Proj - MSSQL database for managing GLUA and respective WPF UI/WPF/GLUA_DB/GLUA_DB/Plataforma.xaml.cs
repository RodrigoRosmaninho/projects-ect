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
    /// Interaction logic for Plataforma.xaml
    /// </summary>
    public partial class Plataforma : Page
    {

        protected static String name;
        protected MainWindow main;

        public Plataforma(String n)
        {

            InitializeComponent();
            name = n;
            if (name == "null")
            {
                Nome_TextBox.IsReadOnly = false;
                Link_TextBox.IsReadOnly = false;
                Descricao_TextBox.IsReadOnly = false;
                Edit.Visibility = Visibility.Hidden;
                Delete.Visibility = Visibility.Hidden;
                Save.Visibility = Visibility.Hidden;
                Cancel.Visibility = Visibility.Hidden;
                CreatePlataforma.Visibility = Visibility.Visible;
                VerContas.Visibility = Visibility.Hidden;
                NContas_TextBox.Visibility = Visibility.Hidden;
                NContas_Label.Visibility = Visibility.Hidden;
            }
            else
            {
                CreatePlataforma.Visibility = Visibility.Hidden;
                Nome_TextBox.IsReadOnly = true;
                Link_TextBox.IsReadOnly = true;
                Descricao_TextBox.IsReadOnly = true;
                Edit.Visibility = Visibility.Visible;
                Delete.Visibility = Visibility.Visible;
                Save.Visibility = Visibility.Hidden;
                Cancel.Visibility = Visibility.Hidden;
                getPlataformaByName(name);
            }
            
        }

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            Nome_TextBox.IsReadOnly = false;
            Link_TextBox.IsReadOnly = false;
            Descricao_TextBox.IsReadOnly = false;
            Edit.Visibility = Visibility.Hidden;
            Delete.Visibility = Visibility.Hidden;
            Save.Visibility = Visibility.Visible;
            Cancel.Visibility = Visibility.Visible;

        }

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            String[] values = { name.ToString() };
            DB.getDB().executeNonResultQuery("DELETE FROM PLATAFORMA WHERE Nome = {};", values);
            this.NavigationService.GoBack();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { Nome_TextBox.Text, Link_TextBox.Text, Descricao_TextBox.Text, name };
            DB.getDB().executeNonResultQuery("EXEC UpdatePlataformas {}, {}, {}, {}", values);

            Nome_TextBox.IsReadOnly = true;
            Link_TextBox.IsReadOnly = true;
            Descricao_TextBox.IsReadOnly = true;
            Edit.Visibility = Visibility.Visible;
            Delete.Visibility = Visibility.Visible;
            Save.Visibility = Visibility.Hidden;
            Cancel.Visibility = Visibility.Hidden;
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            getPlataformaByName(name);
            Nome_TextBox.IsReadOnly = true;
            Link_TextBox.IsReadOnly = true;
            Descricao_TextBox.IsReadOnly = true;
            Edit.Visibility = Visibility.Visible;
            Delete.Visibility = Visibility.Visible;
            Save.Visibility = Visibility.Hidden;
            Cancel.Visibility = Visibility.Hidden;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.GoBack();
        }


        private void getPlataformaByName(String name)
        {
            string queryString =
                "SELECT * FROM getPlatformByName ( @Name );";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    cmd.Parameters.AddWithValue("@Name", name);
                    var reader = cmd.ExecuteReader();

                    reader.Read();
                    Nome_TextBox.Text = reader["Nome"].ToString();
                    Link_TextBox.Text = reader["Link"].ToString();
                    Descricao_TextBox.Text = reader["Descricao"].ToString();
                    NContas_TextBox.Text = reader["acessos_num"].ToString();
                }
            }
        }

        private void VerContas_Click(object sender, RoutedEventArgs e)
        {
            getMain().PlatfromAcessListDataGrid.ItemsSource = getAcessoListByPlatformName(name);
            getMain().PlatfromAcessListFlyout.IsOpen = true;
        }

        private DataView getAcessoListByPlatformName(String name)
        {
            string queryString = "SELECT * FROM getAcessListByPlatformName( @Name );";


            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    cmd.Parameters.AddWithValue("@Name", name);
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("Username", typeof(string)), new DataColumn("Tipo_Acesso", typeof(string)), new DataColumn("Nome", typeof(string)), new DataColumn("Email", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["Username"] = reader["Username"].ToString();
                        row["Tipo_Acesso"] = reader["Tipo_Acesso"].ToString();
                        row["Nome"] = reader["Nome"].ToString();
                        row["Email"] = reader["Email"].ToString();
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

        private void Create_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { Nome_TextBox.Text, Link_TextBox.Text, Descricao_TextBox.Text};
            DB.getDB().executeNonResultQuery("EXEC InsertPlataformas {}, {}, {}", values);

            this.NavigationService.GoBack();
        }
    }
}
