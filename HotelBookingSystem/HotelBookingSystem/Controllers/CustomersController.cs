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


        CustomersController() { }
        /*
         Get Method Controller
         */
        [HttpGet]
        [Route("api/customer/get")]
        public IEnumerable<Customer> Get()
        {
            var result=conn.con.QueryAsync<Customer>(sql: "Customer_GetAll", commandType: CommandType.StoredProcedure);
            return (IEnumerable<Customer>)result.Result;
        }
        /*
         * get only Id Controller
         */
        [HttpGet]
        [Route("api/customer/get/{id}")]
        public Customer Get(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@CustomerId", id);
            return (conn.con.QueryFirstOrDefaultAsync<Customer>(sql: "Customer_GetByCustomerId", param: parameters, commandType: CommandType.StoredProcedure)).Result;
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
                return (conn.con.QueryFirstOrDefaultAsync<ActionsResults>(sql: "Customer_Save", param: parameters, commandType: CommandType.StoredProcedure)).Result;
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
            return (conn.con.QueryFirstOrDefaultAsync<ActionsResults>(sql: "Customer_Delete", param: parameters, commandType: CommandType.StoredProcedure)).Result;
        }
    }
}
