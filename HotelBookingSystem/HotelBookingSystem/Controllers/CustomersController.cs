using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using HotelBookingSystem.Models.Response;
using Dapper;
using System.Data;
using System;

// Customer Controllers

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class CustomersController : ControllerBase
    {
        public BaseRepository conn = new BaseRepository();


        public CustomersController() { }
        /*
         Get Method Controller
         */
        [HttpGet]
        [Route("api/customer/get")]
        public IEnumerable<Customer> Get()
        {
            
            return conn.con.Query<Customer>(sql: "Customer_GetAll", commandType: CommandType.StoredProcedure); ;
        }
        /*
         * get only Id Controller
         */
        [HttpGet]
        [Route("api/customer/get/{id}")]
        public Customer Get(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@CustomerId1", id);
            return conn.con.QueryFirstOrDefault<Customer>(sql: "Customer_GetByCustomerId", param: parameters, commandType: CommandType.StoredProcedure);
        }
        /*
         * Insert Data Controller
         */
        [HttpPost]
        [Route("api/customer/insert")]
        public ActionsResults Insert(Customer customer)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@CustomerId", customer.CustomerId);
                parameters.Add("@Name", customer.Name);
                parameters.Add("@PhoneNumber", customer.PhoneNumber);
                parameters.Add("@Email", customer.Email);
                return conn.con.QueryFirstOrDefault<ActionsResults>(sql: "Customer_Save", param: parameters, commandType: CommandType.StoredProcedure);
            }
            catch (Exception)
            {
                return new ActionsResults()
                {
                    Id = 0,
                    Message = "An error occurred, please try again!"
                };
            }
        }
        /*
         * Delete Data Controller
         */
        [HttpDelete]
        [Route("api/customer/delete/{id}")]
        public ActionsResults Remove(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@CustomerId", id);
            return conn.con.QueryFirstOrDefault<ActionsResults>(sql: "Customer_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }
    }
}
