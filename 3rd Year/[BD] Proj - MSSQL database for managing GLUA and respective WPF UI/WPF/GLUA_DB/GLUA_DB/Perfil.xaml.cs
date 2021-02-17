using System;
using System.Collections.Generic;
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
    /// Interaction logic for Perfil.xaml
    /// </summary>
    public partial class Perfil : Page
    {
        public Perfil()
        {
            InitializeComponent();
            Nome_Label.Content = MainWindow.Email;
        }

        private void Logout_Click(object sender, RoutedEventArgs e)
        {
            Login login = new Login();
            login.Show();
            ((MainWindow)Window.GetWindow(this)).Close();
        }

        private void ChangePassword_Click(object sender, RoutedEventArgs e)
        {
            if(Password_TextBox.Password == Password_TextBox2.Password)
            {
                Object[] values = { DB.getDB().getMembroIDByEmail(MainWindow.Email), Password_TextBox.Password };
                DB.getDB().executeNonResultQuery("EXEC ModifyAccount {}, {}", values);
                MessageBox.Show("Password alterada com sucesso", "Sucesso", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            else MessageBox.Show("As passwords inseridas não condizem!", "Erro", MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }
}
