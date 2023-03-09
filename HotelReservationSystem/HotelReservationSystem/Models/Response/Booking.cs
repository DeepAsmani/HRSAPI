using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HotelReservationSystem.Models.Response
{
    public class Booking
    {

        public int BookingId { get; set; }
        public int CustomerId { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime CheckinDate { get; set; }
        public DateTime CheckoutDate { get; set; }
        public int NumberofAdults { get; set; }
        public int NumberofChildren { get; set; }
        public float ServiceAmount { get; set; }
        public float RoomAmount { get; set; }
        public int? CouponId { get; set; }
        public bool IsCanceled { get; set; }
        public Customer BookingCustomer { get; set; }
        public Offer BookingCoupon { get; set; }
        public List<BookingRoomDetails> bookingRoomDetails { get; set; }
        //public List<BookingServiceDetails> bookingServiceDetails { get; set; }
    }
}
