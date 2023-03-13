using Dapper;
using HotelBookingSystem.Models.Response;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class AdminController : Controller
    {
        
            public BaseRepository conn = new BaseRepository();


            public AdminController() { }
            /*
             * get only Id Controller
             */
            [HttpGet]
            [Route("api/admin/get/{id}")]
            public Customer Get(int id)
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@adminId", id);
                return conn.con.QueryFirstOrDefault<Customer>(sql: "Admin_GetByCustomerId", param: parameters, commandType: CommandType.StoredProcedure);
            }
            /*
             * Delete Data Controller
             */
            [HttpDelete]
            [Route("api/admin/delete/{id}")]
            public ActionsResults Remove(int id)
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@CustomerId", id);
                return conn.con.QueryFirstOrDefault<ActionsResults>(sql: "Customer_Delete", param: parameters, commandType: CommandType.StoredProcedure);
            }
    }
}
