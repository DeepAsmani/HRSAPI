using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Interface.BAL
{
    public interface ISupportService
    {
        Task<IEnumerable<DateTime>> CreateTableDateAsync(DateTime startDate, DateTime endDate);
    }
}