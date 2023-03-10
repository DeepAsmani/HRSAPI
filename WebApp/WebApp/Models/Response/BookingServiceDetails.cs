namespace WebApp.Models.Response
{
    public class BookingServiceDetails
    {
        public int BookingServiceDetailsId { get; set; }
        public int BookingId { get; set; }
        public int ServiceId { get; set; }
        public int ServiceQuantity { get; set; }
        public float ServicePrice { get; set; }
    }
}