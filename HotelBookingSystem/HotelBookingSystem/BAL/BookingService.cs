using HotelBookingSystem.Models.Response;
using HotelBookingSystem.Interface.BAL;
using HotelBookingSystem.Interface.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace HotelBookingSystem.BAL
{
    public class BookingService : IBookingService
    {
        private readonly IBookingRepository bookingRepository;
        private readonly IBookingRoomDetailsRepository bookingRoomDetailsRepository;
        //private readonly IBookingServiceDetailsRepository bookingServiceDetailsRepository;
        private readonly ICustomerRepository customerRepository;
        private readonly IOfferRepository couponRepository;
        private readonly ISupportRepository supportRepository;

        public BookingService(
             IBookingRepository bookingRepository
            , IBookingRoomDetailsRepository bookingRoomDetailsRepository
            //, IBookingServiceDetailsRepository bookingServiceDetailsRepository
            , ICustomerRepository customerRepository
            , IOfferRepository couponRepository
            , ISupportRepository supportRepository)
        {
            this.bookingRepository = bookingRepository;
            this.bookingRoomDetailsRepository = bookingRoomDetailsRepository;
            //this.bookingServiceDetailsRepository = bookingServiceDetailsRepository;
            this.customerRepository = customerRepository;
            this.couponRepository = couponRepository;
            this.supportRepository = supportRepository;
        }

        public Task<ActionsResult> Delete(int id)
        {
            return bookingRepository.Delete(id);
        }

        public async Task<IEnumerable<Booking>> Get()
        {
            var bookings = (await bookingRepository.Get()).ToList();
            foreach (var item in bookings)
            {
                //var bookingServiceDetails = (await bookingServiceDetailsRepository.Get(item.BookingId)).ToList();
                //item.bookingServiceDetails = bookingServiceDetails;
                var bookingRoomDetails = (await bookingRoomDetailsRepository.Display(item.BookingId)).ToList();
                item.bookingRoomDetails = bookingRoomDetails;
            }

            var customers = await customerRepository.Get();
            var coupons = await couponRepository.GetAll();
            var data = (from b in bookings
                        join c in customers
                        on b.CustomerId equals c.idCustomer
                        join cp in coupons
                        on b.CouponId equals cp.OfferId into temp
                        from subtemp in temp.DefaultIfEmpty()
                        select new Booking
                        {
                            BookingId = b.BookingId,
                            CreateDate = b.CreateDate,
                            CheckinDate = b.CheckinDate,
                            CheckoutDate = b.CheckoutDate,
                            IsCanceled = b.IsCanceled,
                            CustomerId = c.idCustomer,
                            BookingCustomer = c,
                            NumberofAdults = b.NumberofAdults,
                            NumberofChildren = b.NumberofChildren,
                            CouponId = b.CouponId,
                            BookingCoupon = subtemp,
                            bookingRoomDetails = b.bookingRoomDetails,
                            //bookingServiceDetails = b.bookingServiceDetails,
                            RoomAmount = b.RoomAmount,
                            ServiceAmount = b.ServiceAmount,
                        });
            return data;
        }

        public async Task<Booking> Get(int id)
        {
            var booking = await bookingRepository.Get(id);
            //var bookingServiceDetails = (await bookingServiceDetailsRepository.Get(booking.BookingId)).ToList();
            var bookingRoomDetails = (await bookingRoomDetailsRepository.Display(booking.BookingId)).ToList();
            var customer = await customerRepository.Get(booking.CustomerId);
            var coupon = await couponRepository.GetById(booking.CouponId.GetValueOrDefault());
            var data = new Booking()
            {
                BookingId = booking.BookingId,
                CreateDate = booking.CreateDate,
                CheckinDate = booking.CheckinDate,
                CheckoutDate = booking.CheckoutDate,
                NumberofAdults = booking.NumberofAdults,
                NumberofChildren = booking.NumberofChildren,
                IsCanceled = booking.IsCanceled,
                CustomerId = customer.idCustomer,
                BookingCustomer = customer,
                CouponId = booking.CouponId,
                BookingCoupon = coupon,
                bookingRoomDetails = bookingRoomDetails,
                //bookingServiceDetails = bookingServiceDetails,
                RoomAmount = booking.RoomAmount,
                ServiceAmount = booking.ServiceAmount,
            };
            return data;
        }

        public Task<IEnumerable<DateTime>> GetListDate(int id)
        {
            return bookingRepository.GetListDate(id);
        }

        public Task<ActionsResult> Save(Booking booking)
        {
            return bookingRepository.Save(booking);
        }

        //public Task<ActionsResult> Save(Booking booking)
        //{
        //}
    }
}