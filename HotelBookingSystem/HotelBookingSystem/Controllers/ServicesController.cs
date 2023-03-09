using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelBookingSystem.Controllers
{
    /// <summary>
    ///
    /// </summary>
    [ApiController]
    public class ServicesController : ControllerBase
    {/*
        private readonly IServiceService serviceService;

        public ServicesController(IServiceService serviceService)
        {
            this.serviceService = serviceService;
        }

        [HttpGet]
        [Route("api/service/get")]
        public async Task<IEnumerable<Service>> Get()
        {
            return await serviceService.Get();
        }

        [HttpGet]
        [Route("api/service/getallwithimages")]
        public async Task<IEnumerable<Services>> GetAllWithImages()
        {
            return await serviceService.GetAllWithImages();
        }

        [HttpGet]
        [Route("api/service/get/{id}")]
        public async Task<Service> Get(int id)
        {
            return await serviceService.Get(id);
        }

        [HttpGet]
        [Route("api/service/getbyidwithimages/{id}")]
        public async Task<Service> GetByIdWithImages(int id)
        {
            return await serviceService.GetByIdWithImages(id);
        }

        [HttpPost]
        [Route("api/service/save")]
        public async Task<ActionsResults> Save([FromBody] CreateServiceRequest service)
        {
            return await serviceService.Save(service);
        }

        [HttpDelete]
        [Route("api/service/delete/{id}")]
        public async Task<ActionsResults> Remove(int id)
        {
            return await serviceService.Delete(id);
        }

        [HttpGet]
        [Route("api/service/search")]
        public async Task<IEnumerable<Service>> Search(string keyWord)
        {
            return await serviceService.Search(keyWord);
        }*/
    }
}