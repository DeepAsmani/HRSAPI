using HotelBookingSystem.Models.Response;

namespace HotelBookingSystem.Models.Request
{
    public class RoomTypeBookingRequest
    {
        public RoomType RoomType { get; set; }
        public int Quantity { get; set; }
    }
}