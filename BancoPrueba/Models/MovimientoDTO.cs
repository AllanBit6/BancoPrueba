using System;

namespace BancoPrueba.Models
{
    public class MovimientoDTO
    {
        public DateTime FechaTransaccion { get; set; }
        public string TipoMovimiento { get; set; }
        public decimal Monto { get; set; }
        public string ReferenciaExterna { get; set; }
    }
}
