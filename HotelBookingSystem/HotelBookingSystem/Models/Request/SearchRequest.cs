using System;
using System.Collections.Generic;

namespace HotelBookingSystem.Models.Request
{
    public class SearchRequest
    {
        public DateTime CheckInDate { get; set; }
        public DateTime CheckOutDate { get; set; }
        public IEnumerable<RoomTypeSearchRequest> RoomTypeSearchRequests { get; set; }
        public object Adults { get; internal set; }
    }
}
