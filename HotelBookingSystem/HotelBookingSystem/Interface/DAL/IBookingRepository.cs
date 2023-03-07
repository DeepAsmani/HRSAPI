using HotelBookingSystem.Models.Response;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.DAL
{
    public interface IBookingRepository
    {
        Task<IEnumerable<Booking>> Get();

        Task<Booking> Get(int id);

        Task<ActionsResult> Save(Booking booking);

        Task<ActionsResult> Delete(int id);

        Task<IEnumerable<DateTime>> GetListDate(int id);
    }
}