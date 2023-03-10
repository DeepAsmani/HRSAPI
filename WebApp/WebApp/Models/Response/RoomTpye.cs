using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApp.Models.Response
{
    public class RoomType
    {

        public int RoomTypeId { get; set; }
        public string Name { get; set; }
        public int DefaultPrice { get; set; }
        public int Quantity { get; set; }
        public string Description { get; set; }
        public int MaxAdult { get; set; }
        public int MaxChildren { get; set; }
        public int MaxPeople { get; set; }
        public IEnumerable<Facility> Facilities { get; set; }
        public IEnumerable<RoomTypeImage> Images { get; set; }
    }
}
