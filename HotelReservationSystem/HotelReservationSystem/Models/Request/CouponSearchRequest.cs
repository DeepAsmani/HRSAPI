using System;
using System.Collections.Generic;
using System.Text;

namespace HotelReservationSystem.Models.Request
{
    public class CouponSearchRequest
    {
        public string CouponCode { get; set; }
        public DateTime CreateDate { get; set; }
    }
}
