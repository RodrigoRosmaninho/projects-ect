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
    /// Interaction logic for Page1.xaml
    /// </summary>
    public partial class Membros : Page
    {
        public Membros()
        {
            void MembrosDataGrid_AutoGeneratedColumns(object sender, EventArgs e)
            {
                MembrosDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            InitializeComponent();
            MembrosDataGrid.AutoGeneratedColumns += MembrosDataGrid_AutoGeneratedColumns;
            MembrosDataGrid.ItemsSource = getMembrosList();
        }

        public void Row_DoubleClick(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Membro rowPage = new Membro((int) (((DataRowView)row.Item).Row["ID"]));
            this.NavigationService.Navigate(rowPage);
        }

        public void InsertMembro_Click(object sender, RoutedEventArgs e)
        {
            Membro Page = new Membro(-1);
            this.NavigationService.Navigate(Page);
        }

        public static DataView getMembrosList()
        {
            string queryString =
                "SELECT * FROM dbo.Membros ORDER BY Estado DESC, Tipo ASC, Data_entrada ASC;";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("id", typeof(int)), new DataColumn("Nome", typeof(string)), new DataColumn("Email", typeof(string)), new DataColumn("Telemóvel", typeof(string)), new DataColumn("Tipo", typeof(string)), new DataColumn("Estado", typeof(string)), new DataColumn("Data de Entrada", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        row["Nome"] = reader["Nome"].ToString();
                        row["Email"] = reader["Email"].ToString();
                        row["Telemóvel"] = reader["Num_telemovel"].ToString();
                        row["Tipo"] = DB.getMembroTipo(Convert.ToInt32(reader["Tipo"]));
                        row["Estado"] = DB.getMembroEstado(Convert.ToInt32(reader["Estado"]));
                        if(!(reader["Data_Entrada"] is DBNull)) row["Data de Entrada"] = Convert.ToDateTime(reader["Data_Entrada"]).ToString("yyyy/MM/dd");
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

    }
}
