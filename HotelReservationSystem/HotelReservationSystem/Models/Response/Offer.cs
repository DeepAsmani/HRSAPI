using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace HotelReservationSystem.Models.Response
{
    public class Offer
    {

        public int OfferId { get; set; }
        public string OfferCode { get; set; }

        [Required]
        public int Remain { get; set; }

        public float Reduction { get; set; }
        public DateTime EndDate { get; set; }
    }
}
