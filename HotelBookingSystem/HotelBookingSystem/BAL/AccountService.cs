using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HotelBookingSystem.Interface.BAL;
using HotelBookingSystem.Interface.DAL;
using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Models.Request;

namespace HotelBookingSystem.BAL
{
    public class AccountService : IAccountService
    {
        private readonly IAccountRepository accountRepoository;
        public AccountService(IAccountRepository accountRepository)
        {
            this.accountRepoository = accountRepoository;
        }

        public async Task<IEnumerable<LoginResult>> AdminLogin(LoginRequest request)
        {
            return await accountRepoository.AdminLogin(request);
        }
        public async Task<IEnumerable<LoginResult>> CustomerLogin(LoginRequest request)
        {
            return await accountRepoository.CustomerLogin(request);
        }
        public async Task<IEnumerable<RegisterResult>> AdminRegister(RegisterRequest request)
        {
            return await accountRepoository.AdminRegister(request);
        }
        public async Task<IEnumerable<RegisterResult>> CustomerRegister(RegisterRequest request)
        {
            return await accountRepoository.CustomerRegister(request);
        }
    }
}
