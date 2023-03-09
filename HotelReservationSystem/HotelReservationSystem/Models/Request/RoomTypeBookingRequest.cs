using HotelReservationSystem.Models.Response;

namespace HotelReservationSystem.Models.Request
{
    public class RoomTypeBookingRequest
    {
        public RoomType RoomType { get; set; }
        public int Quantity { get; set; }
    }
}