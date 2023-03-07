using HotelBookingSystem.Interface.BAL;
using HotelBookingSystem.Interface.DAL;
using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace HotelBookingSystem.Controllers
{
    [ApiController]
    public class SearchController : Controller
    {
        private readonly ISearchService searchService;

        public SearchController(ISearchService searchService)
        {
            this.searchService = searchService;
        }
        [HttpPost]
        [Route("api/[controller]")]
        public async Task<SearchResult> Search(SearchRequest request)
        {
            return await searchService.Search(request);
        }
    }
}
