using System.Collections.Generic;

namespace WebApp.Models.Response
{
    public class Service
    {
        public int ServiceId { get; set; }
        public string ServiceName { get; set; }
        public int Price { get; set; }
        public bool IsDelete { get; set; }
        public string Description { get; set; }
    }
}