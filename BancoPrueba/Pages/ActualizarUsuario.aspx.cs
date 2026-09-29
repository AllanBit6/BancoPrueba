using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using BancoPrueba.DAL;

namespace BancoPrueba
{
    public partial class ActualizarUsuario : Page
    {
        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            int usuarioID;
            if (!int.TryParse(txtUsuarioID.Text.Trim(), out usuarioID) || usuarioID <= 0)
            {
                lblMensaje.Text = "Ingrese un Usuario ID valido.";
                return;
            }

            try
            {
                using (SqlConnection cn = Conexion.ObtenerConexion())
                {
                    cn.Open();
                    using (SqlCommand cmd = new SqlCommand("sp_ActualizarEstadoUsuario", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@UsuarioID", SqlDbType.Int).Value = usuarioID;
                        cmd.Parameters.Add("@Estado", SqlDbType.Bit).Value = chkEstado.Checked;

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            lblMensaje.Text = reader.Read() && !reader.IsDBNull(0)
                                ? HttpUtility.HtmlEncode(Convert.ToString(reader[0]))
                                : "Estado actualizado correctamente.";
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                lblMensaje.Text = HttpUtility.HtmlEncode(ex.Message);
            }
        }
    }
}
