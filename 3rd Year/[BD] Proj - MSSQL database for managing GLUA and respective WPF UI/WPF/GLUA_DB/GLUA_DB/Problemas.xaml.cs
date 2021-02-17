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
    /// Interaction logic for Problemas.xaml
    /// </summary>
    public partial class Problemas : Page
    {
        public Problemas()
        {
            void ProblemsDataGrid_AutoGeneratedColumns(object sender, EventArgs e)
            {
                ProblemsDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            InitializeComponent();
            ProblemsDataGrid.AutoGeneratedColumns += ProblemsDataGrid_AutoGeneratedColumns;
            ProblemsDataGrid.ItemsSource = getProblemsList();
        }

        public void Row_DoubleClick(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Problema rowPage = new Problema((int)(((DataRowView)row.Item).Row["ID"]));
            this.NavigationService.Navigate(rowPage);
        }

        public static DataView getProblemsList()
        {
            string queryString =
                "SELECT * FROM dbo.Problemas";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("ID", typeof(int)), new DataColumn("Descrição", typeof(string)), new DataColumn("SO", typeof(string)), new DataColumn("Versao", typeof(string)), new DataColumn("Fabricante", typeof(string)), new DataColumn("Modelo", typeof(string)), new DataColumn("Num de Atendimentos", typeof(string)), new DataColumn("Num Resolvidos", typeof(string)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        row["Descrição"] = reader["Descricao"].ToString();
                        row["Fabricante"] = reader["Fabricante"].ToString();
                        row["Modelo"] = reader["Modelo"].ToString();
                        row["SO"] = reader["SO"].ToString();
                        row["Versao"] = reader["Versao"].ToString();
                        row["Num de Atendimentos"] = reader["atendimentos_num"].ToString();
                        row["Num Resolvidos"] = reader["resolucoes_num"].ToString();
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

        private void InsertOS_Click(object sender, RoutedEventArgs e)
        {
            Problema rowPage = new Problema(-1);
            this.NavigationService.Navigate(rowPage);
        }
    }
}
