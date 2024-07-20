namespace SolarEase.Models.DTO.FAQDto
{
    public class FAQRequest
    {
        public string Question { get; set; }
        public List<FAQItem> FAQs { get; set; }
    }

}
