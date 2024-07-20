using System.ComponentModel.DataAnnotations;

namespace SolarEase.Models.DTO.SolarProductDto
{
    public class CreateSolarProductDto
    {
        [Required]
        public String CategoryName { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Price must be greater than or equal to 1.")]
        public double Price { get; set; }
        [Required]
        public IFormFile ImageUrl { get; set; }
        [Required]
        //[MaxLength(50, ErrorMessage = "Brand cannot be over 50 over characters")]
        public string Brand { get; set; }
        [Required]
        //[Range(1, double.MaxValue, ErrorMessage = "Capacity must be greater than or equal to 1.")]
        public double Capacity { get; set; }
        [Required]
        public string MeasuringUnit { get; set; }
        //[Range(1, double.MaxValue, ErrorMessage = "Volt must be greater than or equal to 1.")]
        public double? Volt { get; set; }
    }
}
