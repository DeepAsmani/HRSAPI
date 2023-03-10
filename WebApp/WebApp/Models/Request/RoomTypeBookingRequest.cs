using WebApp.Models.Response;

namespace WebApp.Models.Request
{
    public class RoomTypeBookingRequest
    {
        public RoomType RoomType { get; set; }
        public int Quantity { get; set; }
    }
}