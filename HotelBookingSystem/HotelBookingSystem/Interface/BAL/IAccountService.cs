using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Models.Request;

namespace HotelBookingSystem.Interface.BAL
{
    public interface IAccountService
    {
        Task<IEnumerable<LoginResult>> AdminLogin(LoginRequest request); 
        Task<IEnumerable<LoginResult>> CustomerLogin(LoginRequest request);
        Task<IEnumerable<RegisterResult>> AdminRegister(RegisterRequest request);
        Task<IEnumerable<RegisterResult>> CustomerRegister(RegisterRequest request);
    }
}
