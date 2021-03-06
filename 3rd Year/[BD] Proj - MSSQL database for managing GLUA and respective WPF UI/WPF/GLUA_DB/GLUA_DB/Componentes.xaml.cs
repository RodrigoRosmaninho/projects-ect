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
    /// Interaction logic for Componentes.xaml
    /// </summary>
    public partial class Componentes : Page
    {
        public Componentes()
        {
            void ComponentesDataGrid_AutoGeneratedColumns(object sender, EventArgs e)
            {
                ComponentesDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            InitializeComponent();
            ComponentesDataGrid.AutoGeneratedColumns += ComponentesDataGrid_AutoGeneratedColumns;
            ComponentesDataGrid.ItemsSource = getComponentesList();
        }

        public void Row_DoubleClick(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Componente rowPage = new Componente((int)(((DataRowView)row.Item).Row["ID"]));
            this.NavigationService.Navigate(rowPage);
        }

        public static DataView getComponentesList()
        {
            string queryString =
                "SELECT * FROM dbo.Componentes";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("ID", typeof(int)), new DataColumn("Fabricante", typeof(string)), new DataColumn("Modelo", typeof(string)), new DataColumn("Num de Problemas", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        row["Fabricante"] = reader["Fabricante"].ToString();
                        row["Modelo"] = reader["Modelo"].ToString();
                        row["Num de Problemas"] = reader["num_problemas"].ToString();
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

        private void InsertComponente_Click(object sender, RoutedEventArgs e)
        {
            Componente rowPage = new Componente(-1);
            this.NavigationService.Navigate(rowPage);
        }
    }
}
