using System;
using System.Collections.Generic;

namespace WebApp.Models.Request
{
    public class SearchRequest
    {
        public DateTime CheckInDate { get; set; }
        public DateTime CheckOutDate { get; set; }
        public IEnumerable<RoomTypeSearchRequest> RoomTypeSearchRequests { get; set; }
    }
}
