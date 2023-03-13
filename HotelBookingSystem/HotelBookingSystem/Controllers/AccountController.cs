using Microsoft.AspNetCore.Mvc;
using System;
using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Models.Request;
//using HotelBookingSystem.Interface.BAL;
using MySql.Data.MySqlClient;
using Dapper;
using System.Data;

namespace HotelBookingSystem.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        public BaseRepository conn = new BaseRepository();
        public AccountController() { }
        /*
         * Admin Login Controlller         
         */
        [HttpPost]
        [Route("/api/account/adminlogin")]
        public LoginResult AdminLogin(LoginRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@email1", request.Email);
                parameters.Add("@password", request.Password);
                LoginResult result = conn.con.QueryFirstOrDefault<LoginResult>(sql: "Admin_Login", param: parameters, commandType: CommandType.StoredProcedure);
                if (result.Message.Equals("Login successful."))
                    result.Success = true;
                else
                    result.Success = false;
                return result;

            }
            catch (Exception)
            {
                return new LoginResult()
                {
                    Id = 0,
                    Message = "An error occurred, please try again!",
                    Success = false
                };
            }
        }
        /*
         * Customer Login Controlller         
         */
        [HttpPost]
        [Route("/api/account/customerlogin")]
        public LoginResult CustomerLogin(LoginRequest request)
        {
           try
           {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@email1", request.Email);
                parameters.Add("@password", request.Password);
                LoginResult result = conn.con.QueryFirstOrDefault<LoginResult>(sql: "Customer_Login", param: parameters, commandType: CommandType.StoredProcedure);
                if (result.Message.Equals("Login successful."))
                    result.Success = true;
                else
                    result.Success = false;
                return result;

            }
            catch (Exception)
            {
                return new LoginResult()
                {
                    Id = 0,
                    Message = "An error occurred, please try again!",
                    Success = false
                };
            }
        }
        /*
         * Admin Register Controlller         
         */
        [HttpPost]
        [Route("/api/account/adminregister")]
        public RegisterResult AdminRegister(RegisterRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@name", request.Name);
                parameters.Add("@email", request.Email);
                parameters.Add("@password", request.Password);
                RegisterResult result = conn.con.QueryFirstOrDefault<RegisterResult>(sql: "Admin_Register", param: parameters, commandType: CommandType.StoredProcedure);
                if (result.Message.Equals("Registration successful."))
                    result.Success = true;
                else
                    result.Success = false;
                return result;

            }
            catch (Exception)
            {
                return new RegisterResult()
                {
                    Message = "An error occurred, please try again!",
                    Success = false
                };
            }
        }
        /*
         * Customer Register Controlller         
         */
        [HttpPost]
        [Route("/api/account/customerregister")]
        public RegisterResult CustomerRegister(RegisterRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@name", request.Name);
                parameters.Add("@email", request.Email);
                parameters.Add("@password", request.Password);
                RegisterResult result = conn.con.QueryFirstOrDefault<RegisterResult>(sql: "customer_Register", param: parameters, commandType: CommandType.StoredProcedure);
                if (result.Message.Equals("Registration successful."))
                    result.Success = true;
                else
                    result.Success = false;
                return result;

            }
            catch (Exception)
            {
                return new RegisterResult()
                {
                    Message = "An error occurred, please try again!",
                    Success = false
                };
            }
        }
    }
}
