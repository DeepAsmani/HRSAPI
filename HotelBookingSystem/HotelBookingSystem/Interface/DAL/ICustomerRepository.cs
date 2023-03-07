﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HotelBookingSystem.Models.Response;

namespace HotelBookingSystem.Interface.DAL
{
    public interface ICustomerRepository
    {
        Task<IEnumerable<Customer>> Get();

        Task<Customer> Get(int id);

        Task<ActionsResult> Insert(Customer customer);

        Task<ActionsResult> Delete(int id);
    }
}
