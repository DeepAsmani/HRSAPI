using System;

namespace HotelBookingSystem.Models.Request
{
    public class SearchRoomTypesRequest
    {
        public DateTime CheckInDate { get; set; }
        public DateTime CheckOutDate { get; set; }
        public int NumberOfAdults { get; set; }
        public int NumberOfChildren { get; set; }
    }
}