using System;
using Dapper;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HotelBookingSystem.Interface.DAL;
using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using MySql.Data.MySqlClient;

namespace HotelBookingSystem.DAL
{
    public class AccountRepository : BaseRepository,IAccountRepository
    {
        MySqlCommand cmd;
        public IAccountRepository accountRepository;
        public AccountRepository(IAccountRepository accountRepository)
        {
            this.accountRepository = accountRepository; 
        }
        
        public async Task<IEnumerable<LoginResult>> AdminLogin(LoginRequest request)
        {/*
            try
            {
                var result = new LoginResult()
                {
                    Message = "something went wrong, please try again",
                    Success = false,
                    Email = string.Empty
                };

                if (siginResult.Succeeded)
                {
                    var user = await userAdmin.FindByNameAsync(request.Email);
                    if (user != null)
                    {
                        result.Success = siginResult.Succeeded;
                        result.Email = user.AdminEmail;
                        result.Message = "Login success";
                    }
                }

                return result;
            }
            catch
            {*/
                var result = new RegisterResult()
                {
                    Message = "something went wrong, please try again...",
                    Success = false
                };
                return (IEnumerable<LoginResult>)result;
            //}
        }
        public async Task<IEnumerable<LoginResult>> CustomerLogin(LoginRequest request)
        {
            try
            {
                con.Open();
                //cmd = new MySqlCommand(query, con);
                var Parameters = new Customer()
                {
                    CustomerEmail = request.Email,
                    CustomerPassword = request.Password
                };//.AddWithValue("@name", request.Name);
                String query = "SELECT * FROM customer WHERE CustomerEmail = @email and CustomerPassword = @password";
                MySqlCommand sda = new MySqlCommand(query, con);
                sda.Parameters.AddWithValue("@email", Parameters.CustomerEmail);
                sda.Parameters.AddWithValue("@password", Parameters.CustomerPassword);
                MySqlDataReader dt = sda.ExecuteReader();
                con.Close();
                if (dt.HasRows)
                {
                    var result = new RegisterResult()
                    {
                        Message = "Already Register.....",
                        Success = true
                    };
                    return (IEnumerable<LoginResult>)result;
                }
                else
                {
                    var result = new RegisterResult()
                    {
                        Message = "something went wrong, please try again",
                        Success = false
                    };
                    return (IEnumerable<LoginResult>)result;
                }
            }
            catch
            {
                var result = new RegisterResult()
                {
                    Message = "something went wrong, please try again",
                    Success = false
                };
                return (IEnumerable<LoginResult>)result;
            }
        }
        public async Task<IEnumerable<RegisterResult>> AdminRegister(RegisterRequest request)
        {/*
            try
            {
                con.Open();
                String query = "INSERT INTO customer(CustomerName,CustomerEmail,CustomerPassword) VALUES(@name,@email,@password)";
                //cmd = new MySqlCommand(query, con);
                var Parameters = new Customer()
                {
                    CustomerEmail = request.Email,
                    CustomerName = request.Name,
                    CustomerPassword = request.Password
                };//.AddWithValue("@name", request.Name);
                return (IEnumerable<RegisterResult>)await con.QueryAsync(query, Parameters);
                con.Close();
            }
            catch
            {*/
                var result = new RegisterResult()
                {
                    Message = "something went wrong, please try again",
                    Success = false
                };
                return (IEnumerable<RegisterResult>)result;
            //}
        }
        public async Task <IEnumerable<RegisterResult>> CustomerRegister(RegisterRequest request)
        {
            try
            {
                con.Open();

                String query = "SELECT * FROM customer WHERE CustomerEmail = @email and CustomerPassword = @password";
                MySqlCommand sda = new MySqlCommand(query, con);
                MySqlDataReader dt = sda.ExecuteReader();
                if (dt.HasRows)
                {
                    var result = new RegisterResult()
                    {
                        Message = "Already Register.....",
                        Success = false
                    };
                    return (IEnumerable<RegisterResult>)result;
                }
                else
                {
                    query = "INSERT INTO customer(CustomerName,CustomerEmail,CustomerPassword) VALUES(@name,@email,@password)";
                    //cmd = new MySqlCommand(query, con);
                    var Parameters = new Customer()
                    {
                        CustomerEmail = request.Email,
                        CustomerName = request.Name,
                        CustomerPassword = request.Password
                    };//.AddWithValue("@name", request.Name);
                    sda = new MySqlCommand(query, con);
                    sda.Parameters.AddWithValue("@name", Parameters.CustomerName);
                    sda.Parameters.AddWithValue("@email", Parameters.CustomerEmail);
                    sda.Parameters.AddWithValue("@password", Parameters.CustomerPassword);
                    con.Close();
                    var result = new RegisterResult()
                    {
                        Message = "Register Success...",
                        Success = true
                    };
                    return (IEnumerable<RegisterResult>)result;
                }

            }
            catch
            {
                var result = new RegisterResult()
                {
                    Message = "something went wrong, please try again",
                    Success = false
                };
                return (IEnumerable<RegisterResult>)result;
            }
        }
    }
}
