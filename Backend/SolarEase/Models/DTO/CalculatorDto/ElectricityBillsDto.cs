using System.ComponentModel.DataAnnotations;

namespace SolarEase.Models.DTO.CalculatorDto
{
    public class ElectricityBillsDto
    {
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double January { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double February { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double March { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double April { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double May { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double June { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double July { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double August { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double September { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double October { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double November { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Load must be greater than or equal to 1.")]
        public double December { get; set; }
        [Required]
        public bool Grid { get; set; }
        [Required]
        //[Range(1, 100, ErrorMessage = "ElectricalCoverage must be between 1 and 100.")]
        public double ElectricalCoverage { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Devicesload must be greater than or equal to 1.")]
        public double Devicesload { get; set; }

    }
}
