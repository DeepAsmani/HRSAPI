using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.DAL
{
    public interface ISupportRepository
    {
        Task<IEnumerable<DateTime>> CreateTableDateAsync(DateTime startDate, DateTime endDate);
    }
}