using Microsoft.AspNetCore.Mvc;
using System;
using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Models.Request;
//using HotelBookingSystem.Interface.BAL;
using MySql.Data.MySqlClient;

namespace HotelBookingSystem.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        /*
         * UserManager : 
         * to manage users e.g. registering new users, validating credentials and loading user information. 
         * It is not concerned with how user information is stored. For this it relies on a UserStore 
         * 
         * SignInManager :
         * Validates the sign in code from an authenticator app and creates and signs in the user, as an asynchronous operation.
         * 
         * IWebHostEnvironment :
         * Provides information about the web hosting environment an application is running in.
         */
        /*private readonly UserManager<Admin> userAdmin;
        private readonly SignInManager<Admin> signInAdmin;
        private readonly UserManager<Customer> userCustomer;
        private readonly SignInManager<Customer> signInCustomer;
        private readonly IWebHostEnvironment webHostEnvironment;*/
        //private readonly IAccountService accountService;
        public MySqlConnection con = new MySqlConnection("Data Source=sql12.freemysqlhosting.net;Database=sql12602557;User Id=sql12602557;Password=yKkcKGu4mS");
        public AccountController(/*IAccountService accountService*/)//UserManager<Admin> userAdmin, SignInManager<Admin> signInAdmin, UserManager<Customer> userCustomer,SignInManager<Customer> signInCustomer, IWebHostEnvironment webHostEnvironment)
        {
            //this.accountService = accountService;
           /* this.userAdmin = userAdmin;
            this.signInAdmin = signInAdmin;
            this.userCustomer = userCustomer;
            this.signInCustomer = signInCustomer;
            this.webHostEnvironment = webHostEnvironment;*/
        }
        /*
         * Admin Login Controlller         
         */
        [HttpPost]
        [Route("/api/account/adminlogin")]
        public LoginResult AdminLogin(LoginRequest request)
        {
            var result = new LoginResult()
            {
                Message = "something went wrong, please try again",
                Success = false,
                Email = string.Empty
            };

            /*var siginResult = await signInAdmin.PasswordSignInAsync(request.Email, request.Password, false, false);

            if (siginResult.Succeeded)
            {
                var user = await userAdmin.FindByNameAsync(request.Email);
                if (user != null)
                {
                    result.Success = siginResult.Succeeded;
                    result.Email = user.AdminEmail;
                    result.Message = "Login success";
                }
            }*/

            return result;
            //return (LoginResult)await accountService.AdminLogin(request);
        }
        /*
         * Customer Login Controlller         
         */
        [HttpPost]
        [Route("/api/account/customerlogin")]
        public LoginResult CustomerLogin(LoginRequest request)
        {
          
            var result = new LoginResult()
            {
                    Message = "something went wrong, please try again",
                    Success = false,
                    Email = string.Empty
            };
            /*try
            {*/
                con.Open();

            String query = "SELECT * FROM customer WHERE CustomerEmail = @Email";
            MySqlCommand sdaa = new MySqlCommand(query, con);
            sdaa.Parameters.AddWithValue("@Email", request.Email);
            MySqlDataReader dt = sdaa.ExecuteReader();
            
            if (dt.HasRows)
                {
                    result = new LoginResult()
                    {
                        Message = "Login Success",
                        Success = true,
                        Email =request.Email
                    }; dt.Close();
                return result;
                }
            dt.Close();
            return result;
            /*}
            catch
            {
                return result;
            }*/
            //return (LoginResult)await accountService.CustomerLogin(request);
        }
        /*
         * Admin Register Controlller         
         */
        [HttpPost]
        [Route("/api/account/adminregister")]
        public RegisterResult AdminRegister(RegisterRequest request)
        {
            var result = new RegisterResult()
            {
                Message = "something went wrong, please try again",
                Success = false
            };
            /*
            var user = new Admin()
            {
                AdminEmail = request.Email,
                AdminName = request.Name
            };
            //var registerResult = await userAdmin.CreateAsync(user, request.Password);
            if (registerResult.Succeeded)
            {
                result.Message = "Register success";
                result.Success = registerResult.Succeeded;
            }*/
            return result;
            //return (RegisterResult)await accountService.AdminRegister(request);
        }
        /*
         * Customer Register Controlller         
         */
        [HttpPost]
        [Route("/api/account/customerregister")]
        public RegisterResult CustomerRegister(RegisterRequest request)
        {
            /*try
            {*/
                con.Open();

                String query = "SELECT * FROM customer WHERE CustomerEmail = @Email";
                MySqlCommand sdaa = new MySqlCommand(query, con);
                sdaa.Parameters.AddWithValue("@Email", request.Email);
                MySqlDataReader dt = sdaa.ExecuteReader();
                
                if (dt.HasRows)
                {
                    var result = new RegisterResult()
                    {
                        Message = "Already Register.....",
                        Success = false
                    };
                    return result;
                }
                else
                {
                dt.Close();
                MySqlCommand sda =new MySqlCommand("INSERT INTO customer(CustomerName,CustomerEmail,CustomerPassword) VALUES(@name,@email,@password)",con);
                    //cmd = new MySqlCommand(query, con);
                    var Parameters = new Customer()
                    {
                        Email = request.Email,
                        Name = request.Name,
                        Password = request.Password
                    };//.AddWithValue("@name", request.Name);
                    //sda = new MySqlCommand(query, con);
                    sda.Parameters.AddWithValue("@name", Parameters.Name);
                    sda.Parameters.AddWithValue("@email", Parameters.Email);
                    sda.Parameters.AddWithValue("@password", Parameters.Password);
                    sda.ExecuteNonQuery();
                    con.Close();
                    var result = new RegisterResult()
                    {
                        Message = "Register Success...",
                        Success = true
                    };
                    return result;
                }

            /*}
            catch
            {
                var result = new RegisterResult()
                {
                    Message = "something went wrong, please try again",
                    Success = false
                };
                return result;
            }*/
        }
    }
}
