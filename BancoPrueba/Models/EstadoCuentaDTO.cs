namespace BancoPrueba.Models
{
    public class EstadoCuentaDTO
    {
        public string NombreCompleto { get; set; }
        public decimal SaldoActual { get; set; }
        public decimal TotalCreditos { get; set; }
        public decimal TotalDebitos { get; set; }
    }
}
