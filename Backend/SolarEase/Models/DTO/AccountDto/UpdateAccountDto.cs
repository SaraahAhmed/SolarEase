﻿using System.ComponentModel.DataAnnotations;

namespace SolarEase.Models.DTO.AccountDto
{
    public class UpdateAccountDto
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }
        //[Required]
        public string? Password { get; set; }
    }
}
