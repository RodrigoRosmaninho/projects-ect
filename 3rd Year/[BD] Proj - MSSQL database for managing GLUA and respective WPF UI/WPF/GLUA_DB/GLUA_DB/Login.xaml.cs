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
using System.Windows.Shapes;

namespace GLUA_DB
{
    /// <summary>
    /// Interaction logic for Login.xaml
    /// </summary>
    public partial class Login : Window
    {
        public Login()
        {
            InitializeComponent();

            var fullFilePath = @"https://glua.ua.pt/assets/img/logos/glua_medium_orange_for_white_bg.png";

            BitmapImage bitmap = new BitmapImage();
            bitmap.BeginInit();
            bitmap.UriSource = new Uri(fullFilePath, UriKind.Absolute);
            bitmap.EndInit();
            Logo_Image.Source = bitmap;
        }

        private void Login_Click(object sender, RoutedEventArgs e)
        {
            string Email = Email_TextBox.Text;
            int res = 1;

            using (SqlConnection conn = new SqlConnection(DB.getDB().getConnectionString()))
            using (SqlCommand cmd = conn.CreateCommand())
            {
                cmd.CommandText = "VerifyAccount";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("AccountEmail", Email);
                cmd.Parameters.AddWithValue("AccountPwd", Password_TextBox.Password);

                var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;

                conn.Open();
                cmd.ExecuteNonQuery();
                res = (returnParameter.Value as Nullable<int>).GetValueOrDefault(2);
            }

            if (res == 0)
            {
                MainWindow mainWindow = new MainWindow(Email);
                mainWindow.Show();
                this.Close();
            }
            else
            {
                MessageBox.Show("Combinação Utilizador/Password não encontrada", "Erro", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}
