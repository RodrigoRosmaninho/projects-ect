using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;

namespace GLUA_DB
{
    class DB
    {

        protected static DB db = null;
        protected String dbServer = "tcp:mednat.ieeta.pt\\SQLSERVER,8101";
        protected String dbName = "p1g4";
        protected String userName = "p1g4";
        protected String userPass = "GYySNo3H2pTqM6";
        protected String connectionString;

        protected DB()
        {
            connectionString = "data source=" + dbServer + " ;" + "Initial Catalog = " + dbName +
                                    "; uid = " + userName + ";" + "password = " + userPass + ";";
        }

        
        public static DB getDB()
        {
            if (db == null) {
                db = new DB();
            }
            return db;
        }

        public String getConnectionString()
        {
            return connectionString;
        }

       

        public static String getMembroTipo(int tipo)
        {
            switch(tipo)
            {
                case 0:
                    return "Efetivo";
                case 1:
                    return "Colaborador";
                case 2:
                    return "Coordenação";
                case 3:
                    return "Sénior";
                case 4:
                    return "Honorário";
                default:
                    return "";
            }
        }

        public static String getTentativaEstado(int estado)
        {
            switch (estado)
            {
                case 0:
                    return "Bem-sucedido";
                case 1:
                    return "Mal-sucedido";
                case 2:
                    return "Melhoria Parcial";
                default:
                    return "";
            }
        }

        public static String getMembroEstado(int estado)
        {
            switch (estado)
            {
                case 0:
                    return "Inativo";
                case 1:
                    return "Ativo";
                default:
                    return "";
            }
        }
        public static String getEquipamentoEstado(int estado)
        {
            switch (estado)
            {
                case 0:
                    return "Ativo";
                case 1:
                    return "Perdido";
                case 2:
                    return "Emprestado";
                case 3:
                    return "Inutilizavel";
                case 4:
                    return "Sub-ótimo";
                default:
                    return "";
            }
        }

        public static String getSpentTime(int time)
        {
            return (time / 60).ToString("0") + "h" + (time % 60).ToString("00");
        }

        public static int getIntFromTime(string time)
        {
            int res = 0;
            String[] arr = time.Split('h');
            res += Convert.ToInt32(arr[0]) * 60;
            res += Convert.ToInt32(arr[1]);
            return res;
        }

        private string ReplaceFirstArg(string query, string new_word)
        {
            int pos = query.IndexOf("{}");
            if (pos < 0)
            {
                return query;
            }
            return query.Substring(0, pos) + "@"+new_word+ query.Substring(pos+2);
        }

        public void executeNonResultQuery(String queryString, Object[] values)
        // Example queryString:  INSERT Customers (CustomerID, CompanyName, ContactName) Values ({}, {}, {});

        {
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                using (var cmd = new SqlCommand())
                {
                    for(int i = 0; i<values.Length; i++)
                    {
                        queryString = ReplaceFirstArg(queryString, "a"+i);
                    }
                    cmd.CommandText = queryString;
                    cmd.Parameters.Clear();
                    for(int i = 0; i<values.Length; i++)
                    {
                        cmd.Parameters.AddWithValue("@a"+i, values[i]);
                    }
                    cn.Open();
                    cmd.Connection = cn;
                    cmd.ExecuteNonQuery();
                    cn.Close();
                }
                    
            }
        }

        public int getMembroIDByEmail(string email)
        {
            string queryString =
                "SELECT dbo.getMembroIDByEmail( @Email )";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    cmd.Parameters.AddWithValue("@Email", email);

                    var reader = cmd.ExecuteScalar();
                    return (reader as Nullable<int>).GetValueOrDefault(-1);
                }
            }
        }

        public int getIdFromSystemOpName(String os_name, String version_name)
        {
            Object version_n;

            if (version_name == "null" || version_name == null)
            {
                version_n = DBNull.Value;
            }
            else
            {
                version_n = version_name;
            }
            String queryString =
              "SELECT dbo.getIdFromSystemOpName( @OSName , @VersionName );";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    cmd.Parameters.AddWithValue("@OSName", os_name);
                    cmd.Parameters.AddWithValue("@VersionName", version_n);
                    return (int)cmd.ExecuteScalar();
                }
            }
        }

        public int getIdFromComponenteFabricante(String fabricante, String modelo)
        {
            Object m;

            if (modelo == "null" || modelo == null)
            {
                m = DBNull.Value;
            }
            else
            {
                m = modelo;
            }
            String queryString =
              "SELECT dbo.getIdFromComponenteFabricante( @Fabricante , @Modelo );";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    cmd.Parameters.AddWithValue("@Fabricante", fabricante);
                    cmd.Parameters.AddWithValue("@Modelo", m);
                    return (int)cmd.ExecuteScalar();
                }
            }
        }

        public int getIdFromPCFabricante(String fabricante, String modelo)
        {
            Object m;

            if (modelo == "null" || modelo == null)
            {
                m = DBNull.Value;
            }
            else
            {
                m = modelo;
            }
            String queryString =
              "SELECT dbo.getIdFromPCFabricante( @Fabricante , @Modelo );";

            using (SqlConnection cn = new SqlConnection(DB.getDB().getConnectionString()))
            {
                using (var cmd = new SqlCommand(queryString, cn))
                {
                    cn.Open();
                    cmd.Parameters.AddWithValue("@Fabricante", fabricante);
                    cmd.Parameters.AddWithValue("@Modelo", m);
                    return (int)cmd.ExecuteScalar();
                }
            }
        }
    }
}
