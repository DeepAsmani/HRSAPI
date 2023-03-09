using System;
using System.Collections.Generic;

namespace HotelReservationSystem.Models.Response
{
    public class SearchResult
    {
        public DateTime CheckInDate { get; set; }
        public DateTime CheckOutDate { get; set; }
        public IEnumerable<RoomSearchResult> RoomSearchResults { get; set; }
    }
}
