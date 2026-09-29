using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Web;
using BancoPrueba.DAL;

namespace BancoPrueba
{
    public partial class EstadoCuenta : System.Web.UI.Page
    {
        protected void btnConsultar_Click(object sender, EventArgs e)
        {
            LimpiarResultados();

            int cuentaID;
            DateTime fechaInicio;
            DateTime fechaFin;

            if (!int.TryParse(txtCuentaID.Text.Trim(), out cuentaID) || cuentaID <= 0)
            {
                lblMensaje.Text = "Ingrese un CuentaID válido.";
                return;
            }

            if (!DateTime.TryParseExact(txtFechaInicio.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaInicio))
            {
                lblMensaje.Text = "Ingrese una fecha inicial válida.";
                return;
            }

            if (!DateTime.TryParseExact(txtFechaFin.Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out fechaFin))
            {
                lblMensaje.Text = "Ingrese una fecha final válida.";
                return;
            }

            if (fechaInicio > fechaFin)
            {
                lblMensaje.Text = "La fecha inicial no puede ser posterior a la fecha final.";
                return;
            }

            try
            {
                DataTable movimientos = new DataTable();
                bool tieneResumen = false;

                using (SqlConnection cn = Conexion.ObtenerConexion())
                {
                    cn.Open();

                    using (SqlCommand cmd = new SqlCommand("sp_GenerarEstadoCuenta", cn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@CuentaID", SqlDbType.Int)
                        {
                            Value = cuentaID
                        });
                        cmd.Parameters.Add(new SqlParameter("@FechaInicio", SqlDbType.DateTime)
                        {
                            Value = fechaInicio
                        });
                        cmd.Parameters.Add(new SqlParameter("@FechaFin", SqlDbType.DateTime)
                        {
                            Value = fechaFin
                        });

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                tieneResumen = true;
                                lblNombreCompleto.Text = LeerValor(reader, "NombreCompleto");
                                lblSaldoActual.Text = LeerValor(reader, "SaldoActual");
                                lblTotalCreditos.Text = LeerValor(reader, "TotalCreditos");
                                lblTotalDebitos.Text = LeerValor(reader, "TotalDebitos");
                            }

                            if (reader.NextResult())
                            {
                                movimientos.Load(reader);
                            }
                        }
                    }
                }

                gvDetalle.DataSource = movimientos;
                gvDetalle.DataBind();
                lblMensaje.Text = tieneResumen
                    ? "Consulta completada."
                    : "No se encontró un resumen para la cuenta indicada.";
            }
            catch (SqlException ex)
            {
                lblMensaje.Text = HttpUtility.HtmlEncode(ex.Message);
            }
        }

        private void LimpiarResultados()
        {
            lblMensaje.Text = string.Empty;
            lblNombreCompleto.Text = string.Empty;
            lblSaldoActual.Text = string.Empty;
            lblTotalCreditos.Text = string.Empty;
            lblTotalDebitos.Text = string.Empty;
            gvDetalle.DataSource = null;
            gvDetalle.DataBind();
        }

        private string LeerValor(SqlDataReader reader, string nombreColumna)
        {
            for (int i = 0; i < reader.FieldCount; i++)
            {
                if (string.Equals(reader.GetName(i), nombreColumna, StringComparison.OrdinalIgnoreCase))
                {
                    return reader.IsDBNull(i)
                        ? string.Empty
                        : HttpUtility.HtmlEncode(Convert.ToString(reader.GetValue(i)));
                }
            }

            return string.Empty;
        }
    }
}
