using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using BancoPrueba.DAL;

namespace BancoPrueba
{
    public partial class TopUsuarios : Page
    {
        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            int diasAtras;
            if (!int.TryParse(txtDiasAtras.Text.Trim(), out diasAtras) || diasAtras <= 0)
            {
                lblMensaje.Text = "Ingrese una cantidad de dias valida.";
                gvTopUsuarios.DataSource = null;
                gvTopUsuarios.DataBind();
                return;
            }

            try
            {
                DataTable usuarios = new DataTable();
                using (SqlConnection cn = Conexion.ObtenerConexion())
                {
                    cn.Open();
                    using (SqlCommand cmd = new SqlCommand("sp_ReporteTopUsuarios", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@DiasAtras", SqlDbType.Int).Value = diasAtras;

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            usuarios.Load(reader);
                        }
                    }
                }

                gvTopUsuarios.DataSource = usuarios;
                gvTopUsuarios.DataBind();
                lblMensaje.Text = usuarios.Rows.Count > 0
                    ? "Consulta completada."
                    : "No hay usuarios con transacciones en el periodo indicado.";
            }
            catch (SqlException ex)
            {
                gvTopUsuarios.DataSource = null;
                gvTopUsuarios.DataBind();
                lblMensaje.Text = HttpUtility.HtmlEncode(ex.Message);
            }
        }
    }
}
