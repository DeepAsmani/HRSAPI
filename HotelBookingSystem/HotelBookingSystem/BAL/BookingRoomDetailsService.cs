using HotelBookingSystem.Interface.BAL;
using HotelBookingSystem.Interface.DAL;
using HotelBookingSystem.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.BAL
{
    public class BookingRoomDetailsService : IBookingRoomDetailsService
    {
        private readonly IBookingRoomDetailsRepository bookingRoomDetailsRepository;

        public BookingRoomDetailsService(IBookingRoomDetailsRepository bookingRoomDetailsRepository)
        {
            this.bookingRoomDetailsRepository = bookingRoomDetailsRepository;
        }

        public async Task<IEnumerable<BookingRoomDetails>> Get(int id)
        {
            return await bookingRoomDetailsRepository.Get(id);
        }

        public async Task<IEnumerable<BookingRoomDetails>> Display(int id)
        {
            return await bookingRoomDetailsRepository.Display(id);
        }

        public async Task<ActionsResult> Delete(int id)
        {
            return await bookingRoomDetailsRepository.Delete(id);
        }

        public async Task<ActionsResult> Save(BookingRoomDetails bookingRoomDetails)
        {
            return await bookingRoomDetailsRepository.Save(bookingRoomDetails);
        }

        public async Task<ActionsResult> DeleteByBookingId(int id)
        {
            return await bookingRoomDetailsRepository.DeleteByBookingId(id);
        }
    }
}