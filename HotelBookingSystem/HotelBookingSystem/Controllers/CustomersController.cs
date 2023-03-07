using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using HotelBookingSystem.Interface.BAL;
using HotelBookingSystem.Models.Response;

// Customer Controllers

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class CustomersController : ControllerBase
    {
        private readonly ICustomerSevice customerSevice;

        CustomersController(ICustomerSevice customerSevice) => this.customerSevice = customerSevice;
        /*
         Get Method Controller
         */
        [HttpGet]
        [Route("api/customer/get")]
        public async Task<IEnumerable<Customer>> Get()
        {
            return await customerSevice.Get();
        }
        /*
         * get only Id Controller
         */
        [HttpGet]
        [Route("api/customer/get/{id}")]
        public async Task<Customer> Get(int id)
        {
            return await customerSevice.Get(id);
        }
        /*
         * Insert Data Controller
         */
        [HttpPost]
        [Route("api/customer/insert")]
        public async Task<ActionsResult> Insert(Customer customer)
        {
            return await customerSevice.Insert(customer);
        }
        /*
         * Delete Data Controller
         */
        [HttpDelete]
        [Route("api/customer/delete/{id}")]
        public async Task<ActionsResult> Remove(int id)
        {
            return await customerSevice.Delete(id);
        }
    }
}
