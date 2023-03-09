using MySql.Data.MySqlClient;

namespace HotelBookingSystem.Controllers
{
    public class BaseRepository
    {
        public MySqlConnection con;    
        
        public BaseRepository()
        {
            this.con = new MySqlConnection("Data Source=sql12.freemysqlhosting.net;Database=sql12603873;User Id=sql12603873;Password=lyvWpBXl4Q");
            this.con.Open();
        }
    }
}
