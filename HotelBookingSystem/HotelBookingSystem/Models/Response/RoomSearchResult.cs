using System;
using System.Collections.Generic;
using System.Text;

namespace HotelBookingSystem.Models.Response
{
    public class RoomSearchResult
    {
        public IEnumerable<RoomTypeSearchResultWithPricesList> RoomTypeSearchResults { get; set; }
        public int Adults { get; set; }
        public int Children { get; set; }
    }
}
