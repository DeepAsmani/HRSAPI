using WebApp.Models.Response;
using WebApp.Ultilities;
using Microsoft.AspNetCore.Mvc;

namespace WebApp.Controllers
{/*
    public class FileUploadController : Controller
    {
        [HttpPost]
        public JsonResult FileUpload([FromBody] FilesUpload filesUpload)
        {
            ActionsResult result = new ActionsResult()
            {
                Id = 0,
                Message = "Error"
            };
            if (filesUpload.Files != null)
            {
                result = ApiHelper<ActionsResult>.HttpPostAsync($"{Helper.ApiUrl}api/ImageUpload", filesUpload);
            }
            return Json(new { result });
        }
    }*/
}