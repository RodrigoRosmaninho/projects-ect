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
    /// Interaction logic for Atendimentos.xaml
    /// </summary>
    public partial class Atendimentos : Page
    {
        public Atendimentos()
        {
            void MembrosDataGrid_AutoGeneratedColumns(object sender, EventArgs e)
            {
                AtendimentosDataGrid.Columns[0].Visibility = Visibility.Hidden;
            }

            InitializeComponent();
            AtendimentosDataGrid.AutoGeneratedColumns += MembrosDataGrid_AutoGeneratedColumns;
            AtendimentosDataGrid.ItemsSource = getAtendimentosList();
        }

        public void Row_DoubleClick(object sender, MouseButtonEventArgs e)
        {
            DataGridRow row = ItemsControl.ContainerFromElement((DataGrid)sender,
                                        e.OriginalSource as DependencyObject) as DataGridRow;

            if (row == null) return;
            Atendimento rowPage = new Atendimento((int)(((DataRowView)row.Item).Row["ID"]));
            this.NavigationService.Navigate(rowPage);
        }

        private DataView getAtendimentosList()
        {
            string queryString =
                "SELECT * FROM dbo.Atendimentos";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    var reader = cmd.ExecuteReader();

                    var dt = new DataTable();

                    DataColumn[] dc = new DataColumn[] { new DataColumn("id", typeof(int)), new DataColumn("Data", typeof(string)), new DataColumn("Local", typeof(string)), new DataColumn("Tempo despendido", typeof(string)), new DataColumn("Fabricante", typeof(string)), new DataColumn("Modelo", typeof(string)), new DataColumn("Utente", typeof(string)), new DataColumn("Problemas", typeof(int)), new DataColumn("Membros", typeof(int)) };
                    dt.Columns.AddRange(dc);

                    while (reader.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["ID"] = Convert.ToInt32(reader["ID"]);
                        if(reader["Data"] is DBNull) row["Data"] = Convert.ToDateTime(reader["Helpdesk_Data"]).ToString("yyyy/MM/dd");
                        else row["Data"] = Convert.ToDateTime(reader["Data"]).ToString("yyyy/MM/dd");
                        if (reader["Local"] is DBNull) row["Local"] = reader["Helpdesk_Local"].ToString();
                        else row["Local"] = reader["Local"].ToString();
                        if (!(reader["Tempo_despendido"] is DBNull)) row["Tempo despendido"] = DB.getSpentTime(Convert.ToInt32(reader["Tempo_despendido"]));
                        row["Fabricante"] = reader["Fabricante"].ToString();
                        row["Modelo"] = reader["Modelo"].ToString();
                        row["Utente"] = reader["Utente"].ToString();
                        row["Problemas"] = Convert.ToInt32(reader["problemas_num"]);
                        row["Membros"] = Convert.ToInt32(reader["membros_num"]);
                        dt.Rows.Add(row);
                    }

                    return dt.DefaultView;
                }
            }
        }

        private void InsertAtendimento_Click(object sender, RoutedEventArgs e)
        {
            Atendimento rowPage = new Atendimento(-1);
            this.NavigationService.Navigate(rowPage);
        }
    }
}
