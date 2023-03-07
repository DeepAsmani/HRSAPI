using HotelBookingSystem.Interface.BAL;
using HotelBookingSystem.Interface.DAL;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.BAL
{
    public class SupportService : ISupportService
    {
        private readonly ISupportRepository supportRepository;

        public SupportService(ISupportRepository supportRepository)
        {
            this.supportRepository = supportRepository;
        }

        public Task<IEnumerable<DateTime>> CreateTableDateAsync(DateTime startDate, DateTime endDate)
        {
            return supportRepository.CreateTableDateAsync(startDate, endDate);
        }
    }
}