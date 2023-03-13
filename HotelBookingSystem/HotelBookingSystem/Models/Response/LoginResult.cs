using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HotelBookingSystem.Models.Response
{
    public class LoginResult
    {

        public int Id { get; set; }
        public string Message { get; set; }
        public bool Success { get; set; }

        public static implicit operator LoginResult(Task<LoginResult> v)
        {
            throw new NotImplementedException();
        }
    }
}
