using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HotelBookingSystem.Interface.BAL;
using HotelBookingSystem.Interface.DAL;
using HotelBookingSystem.Models.Response;


namespace HotelBookingSystem.BAL
{
    public class CustomerSerice : ICustomerSevice
    {
        private readonly ICustomerRepository customerRepository;

        public CustomerSerice(ICustomerRepository customerRepository)
        {
            this.customerRepository = customerRepository;
        }

        public async Task<Customer> Get(int id)
        {
            return await customerRepository.Get(id);
        }

        public async Task<IEnumerable<Customer>> Get()
        {
            return await customerRepository.Get();
        }

        public async Task<ActionsResult> Delete(int id)
        {
            return await customerRepository.Delete(id);
        }

        public async Task<ActionsResult> Insert(Customer customer)
        {
            return await customerRepository.Insert(customer);
        }
    }
}
