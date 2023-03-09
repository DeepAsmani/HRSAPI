using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HotelReservationSystem.Models.Response
{
    public class RoomTypeSearchResult
    {
        public int RoomTypeId { get; set; }
        public int MinRemain { get; set; }
    }
}
