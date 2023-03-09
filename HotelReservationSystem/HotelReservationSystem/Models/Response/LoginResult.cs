using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HotelReservationSystem.Models.Response
{
    public class LoginResult
    {

        public string Email { get; set; }
        public string Message { get; set; }
        public bool Success { get; set; }
    }
}
