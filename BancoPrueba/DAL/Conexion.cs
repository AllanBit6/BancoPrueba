using System.Configuration;
using System.Data.SqlClient;

namespace BancoPrueba.DAL
{
    public class Conexion
    {
        public static SqlConnection ObtenerConexion()
        {
            string cadena =
                ConfigurationManager
                .ConnectionStrings["BancoConexion"]
                .ConnectionString;

            return new SqlConnection(cadena);
        }
    }
}