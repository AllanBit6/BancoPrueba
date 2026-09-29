using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using BancoPrueba.DAL;

namespace BancoPrueba
{
    public partial class CrearUsuario : System.Web.UI.Page
    {
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string nombreCompleto = txtNombreCompleto.Text.Trim();
            string email = txtEmail.Text.Trim();

            if (string.IsNullOrWhiteSpace(nombreCompleto) || string.IsNullOrWhiteSpace(email))
            {
                lblMensaje.Text = "Ingrese el nombre completo y el email.";
                return;
            }

            try
            {
                string resultadoSP = null;

                using (SqlConnection cn = Conexion.ObtenerConexion())
                {
                    cn.Open();

                    using (SqlCommand cmd = new SqlCommand("sp_CrearUsuarioYCuenta", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@NombreCompleto", SqlDbType.VarChar, 100)
                        {
                            Value = nombreCompleto
                        });
                        cmd.Parameters.Add(new SqlParameter("@Email", SqlDbType.VarChar, 150)
                        {
                            Value = email
                        });

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                StringBuilder valores = new StringBuilder();

                                for (int i = 0; i < reader.FieldCount; i++)
                                {
                                    if (i > 0)
                                    {
                                        valores.Append(" | ");
                                    }

                                    if (!reader.IsDBNull(i))
                                    {
                                        valores.Append(Convert.ToString(reader.GetValue(i)));
                                    }
                                }

                                resultadoSP = valores.ToString();
                            }
                        }
                    }
                }

                lblMensaje.Text = "Usuario y cuenta creados correctamente.";
                if (!string.IsNullOrWhiteSpace(resultadoSP))
                {
                    lblMensaje.Text += " Resultado: " + HttpUtility.HtmlEncode(resultadoSP);
                }
            }
            catch (SqlException ex)
            {
                lblMensaje.Text = HttpUtility.HtmlEncode(ex.Message);
            }
        }
    }
}
