using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using Dapper;
using System.Data;

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class SearchController : Controller
    {
        //public RoomTypesController roomTypesController;
        public BaseRepository conn = new BaseRepository();

        public SearchController()
        {
            
        }
        [HttpPost]
        [Route("api/searchresult")]
        public IEnumerable<DateTime> EachDate(DateTime from, DateTime thru)
        {
            for (var day = from.Date; day.Date <= thru.Date; day = day.AddDays(1))
                yield return day;
        }
        [HttpPost]
        [Route("api/searchresult/search")]
        public SearchResult Search(SearchRequest request)
        {
            var roomTypes = (SqlMapper.QueryAsync<RoomType>(conn.con, "RoomType_GetAll", commandType: CommandType.StoredProcedure).Result).ToList();
            var roomSearchResults = new List<RoomSearchResult>();
            foreach (var roomRequest in request.RoomTypeSearchRequests)
            {
                var roomSearchResult = new RoomSearchResult()
                {
                    Adults = roomRequest.Adults,
                    Children = roomRequest.Children
                };
                var rooms = new List<RoomTypeSearchResultWithPricesList>();
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@Adult", roomRequest.Adults);
                parameters.Add("@Children", roomRequest.Children);
                parameters.Add("@CheckInDate", request.CheckInDate);
                parameters.Add("@CheckOutDate", request.CheckOutDate);
                var roomTypeSearchResults= SqlMapper.QueryAsync<RoomTypeSearchResult>(cnn: conn.con, sql: "RoomType_Search", param: parameters, commandType: CommandType.StoredProcedure).Result.ToList();
                //var roomTypeSearchResults = roomTypesController.Search(searchModel).ToList();
                foreach (var roomTypeSearchResult in roomTypeSearchResults)
                {
                    var prices = new List<RoomPriceSearchResult>();
                    foreach (var date in EachDate(request.CheckInDate, request.CheckOutDate.AddDays(-1)))
                    {
                        foreach (var roomType in roomTypes)
                        {
                            if (roomType.RoomTypeId == roomTypeSearchResult.RoomTypeId)
                            {
                                float discountRates = 0;/*promotionRepository.GetAvailablePromotionForDateAndRoomId(new GetAvailablePromotionForDateAndRoomIdRequest()
                                {
                                    Date = date,
                                    RoomTypeId = roomTypeSearchResult.RoomTypeId
                                });*/
                                prices.Add(new RoomPriceSearchResult()
                                {
                                    Date = date,
                                    Price = (int)(roomType.DefaultPrice * (1 - discountRates))
                                });
                            }
                        }
                    }
                    rooms.Add(new RoomTypeSearchResultWithPricesList()
                    {
                        RoomTypeId = roomTypeSearchResult.RoomTypeId,
                        MinRemain = roomTypeSearchResult.MinRemain,
                        RoomPriceSearchResults = prices
                    });
                }
                roomSearchResult.RoomTypeSearchResults = rooms.OrderBy(roomType => roomType.RoomPriceSearchResults.Sum(price => price.Price));
                roomSearchResults.Add(roomSearchResult);
            }

            var result = new SearchResult()
            {
                CheckInDate = request.CheckInDate,
                CheckOutDate = request.CheckOutDate,
                RoomSearchResults = roomSearchResults
            };
            return result;
        }
    }
}
