using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HotelBookingSystem.Models;
using MySql.Data.MySqlClient;
using MySql.Data.Common;
using Microsoft.Extensions.Configuration;

namespace HotelBookingSystem.Controllers
{
    public class BaseRepository
    {
        protected MySqlConnection con;    
        
        public BaseRepository()
        {
            //this.con = new MySqlConnection("Data Source=sql12.freemysqlhosting.net;Database=sql12602557;User Id=sql12602557;Password=yKkcKGu4mS");
            this.con = new MySqlConnection("Data Source=sql12.freemysqlhosting.net;Database=sql12602557;User Id=sql12602557;Password=yKkcKGu4mS");
    }
    }
}
