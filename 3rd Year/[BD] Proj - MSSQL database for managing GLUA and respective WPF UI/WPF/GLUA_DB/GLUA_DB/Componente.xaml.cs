﻿using System;
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
    /// Interaction logic for Componente.xaml
    /// </summary>
    public partial class Componente : Page
    {
        protected static int ID;
        protected MainWindow main;

        public Componente(int id)
        {
            InitializeComponent();
            ID = id;
            if (id >= 0) getComponenteByID(id);
            else Edit_Click(null, null);
        }

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            Fabricante_TextBox.IsReadOnly = false;
            Modelo_TextBox.IsReadOnly = false;
            Edit.Visibility = Visibility.Hidden;
            Delete.Visibility = Visibility.Hidden;
            Save.Visibility = Visibility.Visible;
            Cancel.Visibility = Visibility.Visible;

        }

        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            Object[] values = { ID };
            DB.getDB().executeNonResultQuery("DELETE FROM COMPONENTE WHERE ID = {};", values);
            this.NavigationService.GoBack();
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            Object id = ID;
            if (ID < 0) id = DBNull.Value;
            Object[] values = { id, Fabricante_TextBox.Text, Modelo_TextBox.Text};
            DB.getDB().executeNonResultQuery("EXEC ModifyComponente {}, {}, {}", values);
            this.NavigationService.GoBack();
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            if (ID < 0)
            {
                this.NavigationService.GoBack();
                return;
            }
            getComponenteByID(ID);
            Fabricante_TextBox.IsReadOnly = true;
            Modelo_TextBox.IsReadOnly = true;
            Edit.Visibility = Visibility.Visible;
            Delete.Visibility = Visibility.Visible;
            Save.Visibility = Visibility.Hidden;
            Cancel.Visibility = Visibility.Hidden;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.NavigationService.GoBack();
        }


        private void getComponenteByID(int id)
        {
            string queryString =
                "SELECT * FROM getComponenteByID (" + id + ");";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    reader.Read();
                    Fabricante_TextBox.Text = reader["Fabricante"].ToString();
                    Modelo_TextBox.Text = reader["Modelo"].ToString();
                }
            }
        }
    }
}
