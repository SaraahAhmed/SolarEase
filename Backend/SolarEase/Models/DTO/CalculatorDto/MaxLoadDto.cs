using System.ComponentModel.DataAnnotations;

namespace SolarEase.Models.DTO.CalculatorDto
{
    public class MaxLoadDto
    {
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "MaxMonthLoad must be greater than or equal to 1.")]
        public double MaxMonthLoad { get; set; }
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
