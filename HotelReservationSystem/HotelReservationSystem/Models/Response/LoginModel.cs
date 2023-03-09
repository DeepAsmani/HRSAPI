using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace HotelReservationSystem.Models.Response
{
    public class LoginModel
    {
        [Required]
        [EmailAddress(ErrorMessage = "Invalid email!")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Enter the password!")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
    }
}
