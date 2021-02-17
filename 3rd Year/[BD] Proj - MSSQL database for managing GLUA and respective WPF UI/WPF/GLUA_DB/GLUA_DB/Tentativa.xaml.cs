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
    /// Interaction logic for Tentativa.xaml
    /// </summary>
    public partial class Tentativa : Page
    {
        protected int prob_ID;
        protected int atend_ID;
        protected bool isNew;

        public Tentativa(int prob_id, int atend_id)
        {
            InitializeComponent();
            prob_ID = prob_id;
            atend_ID = atend_id;
            isNew = false;
            getTentativaByIDs(prob_ID, atend_id);
        }

        public Tentativa(int prob_id, int atend_id, bool isNew, String data)
        {
            InitializeComponent();
            prob_ID = prob_id;
            atend_ID = atend_id;
            this.isNew = isNew;
            Edit_Click(null, null);
            Data_DatePicker.Focusable = false;
            Data_DatePicker.IsHitTestVisible = false;
            Data_DatePicker.SelectedDate = Convert.ToDateTime(data);
        }

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            Data_DatePicker.Focusable = true;
            Data_DatePicker.IsHitTestVisible = true;
            Estado_ComboBox.IsEnabled = true;
            Procedimento_TextBox.IsReadOnly = false;
            Edit.Visibility = Visibility.Hidden;
            Delete.Visibility = Visibility.Hidden;
            Save.Visibility = Visibility.Visible;
            Cancel.Visibility = Visibility.Visible;

        }

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { prob_ID, atend_ID };
            DB.getDB().executeNonResultQuery("DELETE FROM TENTATIVA WHERE Problema_ID = {} AND Atendimento_ID = {};", values);
            this.NavigationService.GoBack();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { prob_ID, atend_ID, Estado_ComboBox.SelectedIndex, Procedimento_TextBox.Text };
            DB.getDB().executeNonResultQuery("EXEC ModifyTentativa {}, {}, {}, {}", values);
            this.NavigationService.GoBack();
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            if (isNew)
            {
                this.NavigationService.GoBack();
                return;
            }
            getTentativaByIDs(prob_ID, atend_ID);
            Data_DatePicker.Focusable = false;
            Data_DatePicker.IsHitTestVisible = false;
            Estado_ComboBox.IsEnabled = false;
            Procedimento_TextBox.IsReadOnly = true;
            Edit.Visibility = Visibility.Visible;
            Delete.Visibility = Visibility.Visible;
            Save.Visibility = Visibility.Hidden;
            Cancel.Visibility = Visibility.Hidden;
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.GoBack();
        }


        private void getTentativaByIDs(int pid, int aid)
        {
            string queryString =
                "SELECT * FROM getAttemptByIDs (" + pid + ", " + aid + ");";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    reader.Read();
                    Data_DatePicker.SelectedDate = Convert.ToDateTime(reader["Data"]);
                    Estado_ComboBox.SelectedIndex = Convert.ToInt32(reader["Estado"]);
                    Procedimento_TextBox.Text = reader["Procedimento"].ToString();
                }
            }
        }
    }
}
