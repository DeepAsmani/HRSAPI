using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace   WebApp.Models.Response
{
    public class LoginResult
    {

        public string Email { get; set; }
        public string Message { get; set; }
        public bool Success { get; set; }
    }
}
