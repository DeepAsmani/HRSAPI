using System;

namespace HotelReservationSystem.Models.Request
{
    public class SearchModel
    {
        public DateTime CheckinDate { get; set; }
        public DateTime CheckoutDate { get; set; }
        public int NumberofAdults { get; set; }
        public int NumberofChildren { get; set; }
    }
}