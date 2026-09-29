using System;
using System.Data.SqlClient;
using BancoPrueba.DAL;

namespace BancoPrueba
{
    public partial class PruebaConexion : System.Web.UI.Page
    {
        protected void btnProbar_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection cn = Conexion.ObtenerConexion())
                {
                    cn.Open();

                    lblMensaje.Text = "Conexión correcta";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = ex.Message;
            }
        }
    }
}