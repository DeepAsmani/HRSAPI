using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace HotelBookingSystem.Models.Response
{
    public class RegisterModel
    {
        [Required]
        [EmailAddress(ErrorMessage = "Invalid email!")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Enter the password!")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Compare("Password", ErrorMessage = "The password doesn't match!")]
        [Display(Name = "Confirm password")]
        public string ConfirmPassword { get; set; }

        [Required(ErrorMessage = "Enter a name!")]
        [StringLength(20, MinimumLength = 3, ErrorMessage = "The length of the name ranges from 3 to 20 characters!")]
        public string Name { get; set; }

        [RegularExpression(@"^\(?(0|[3|5|7|8|9])+([0-9]{8})$", ErrorMessage = "Invalid phone number!")]
        public string PhoneNumber { get; set; }
    }
}
