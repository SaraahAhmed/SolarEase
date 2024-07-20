using System.ComponentModel.DataAnnotations;

namespace SolarEase.Models.DTO.PersonDto
{
    public class UpdatePersonSystemSizeDto
    {
        [Required]
        public double SystemSize { get; set; }
    }
}
