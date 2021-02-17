using System;
using System.Collections.Generic;
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
    /// Interaction logic for SistemaOp.xaml
    /// </summary>
    public partial class SistemaOp : Page
    {

        protected static int ID;
        protected MainWindow main;

        public SistemaOp(int id)
        {
            InitializeComponent();
            ID = id;
            if (id >= 0) getSistemasByID(id);
            else Edit_Click(null, null);
        }

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            Nome_TextBox.IsReadOnly = false;
            Versao_TextBox.IsReadOnly = false;
            Edit.Visibility = Visibility.Hidden;
            Delete.Visibility = Visibility.Hidden;
            Save.Visibility = Visibility.Visible;
            Cancel.Visibility = Visibility.Visible;

        }

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { ID };
            DB.getDB().executeNonResultQuery("DELETE FROM SISTEMA_OPERATIVO WHERE ID = {};", values);
            this.NavigationService.GoBack();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            Object id = ID;
            if (ID < 0) id = DBNull.Value;
            Object[] values = { id, Nome_TextBox.Text, Versao_TextBox.Text };
            DB.getDB().executeNonResultQuery("EXEC ModifySistemaOperativo {}, {}, {}", values);
            this.NavigationService.GoBack();
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            if (ID < 0)
            {
                this.NavigationService.GoBack();
                return;
            }
            getSistemasByID(ID);
            Nome_TextBox.IsReadOnly = true;
            Versao_TextBox.IsReadOnly = true;
            Edit.Visibility = Visibility.Visible;
            Delete.Visibility = Visibility.Visible;
            Save.Visibility = Visibility.Hidden;
            Cancel.Visibility = Visibility.Hidden;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.GoBack();
        }


        private void getSistemasByID(int id)
        {
            string queryString =
                "SELECT * FROM getOpSystemByID (" + id +");";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    reader.Read();
                    Nome_TextBox.Text = reader["Nome"].ToString();
                    Versao_TextBox.Text = reader["Versao"].ToString();
                }
            }
        }
    }
}
