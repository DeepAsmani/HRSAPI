using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HotelBookingSystem.Models.Response
{
    public class OfferSearchResult
    {
        public int OfferId { get; set; }
        public float Reduction { get; set; }
        public string Message { get; set; }
    }
}
