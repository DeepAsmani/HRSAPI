﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HotelBookingSystem.Models.Response
{
    public class BookingRoomDetails
    {
        public int BookingRoomDetailsId { get; set; }
        public int BookingId { get; set; }
        public int RoomTypeId { get; set; }
        public int ServiceId { get; set; }
        public int RoomQuantity { get; set; }
        public DateTime Date { get; set; }
        public float RoomPrice { get; set; }
        public float ServicePrice { get; set; }
    }
}
