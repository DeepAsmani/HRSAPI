using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HotelBookingSystem.Models;
using HotelBookingSystem.Models.Request;
using HotelBookingSystem.Models.Response;

namespace HotelBookingSystem
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddControllers();
            services.AddMvc();
            services.AddControllers();
            services.AddSwaggerGen();
            //services.AddDbContext<AppDbContext>(options => options.UseSqlServer(Common.ConnectionString));
            //services.AddTransient<IAccountService, AccountService>();
            //services.AddTransient<IAccountRepository, AccountRepository>();
            //services.AddIdentity<ApplicationUser, IdentityRole>().AddEntityFrameworkStores<AppDbContext>();
            //services.AddTransient<IBookingRoomDetailsService, BookingRoomDetailsService>();
            //services.AddTransient<IBookingService, BookingService>();
            //services.AddTransient<IBookingServiceDetailsService, BookingServiceDetailsService>();
            //services.AddTransient<IRoomTypeService, RoomTypeService>();
            //services.AddTransient<IServiceService, ServiceService>();
            //services.AddTransient<ICustomerSevice, CustomerSerice>();
            //services.AddTransient<IBookingRepository, BookingRepository>();
            //services.AddTransient<IBookingRoomDetailsRepository, BookingRoomDetailsRepository>();
            //services.AddTransient<IBookingServiceDetailsRepository, BookingServiceDetailsRepository>();
            //services.AddTransient<IRoomTypeRepository, RoomTypeRepository>();
            //services.AddTransient<IServiceRepository, ServiceRepository>();
            //services.AddTransient<ICustomerRepository, CustomerRepository>();
            //services.AddTransient<IPromotionRepository, PromotionRepository>();
            //services.AddTransient<IPromotionService, PromotionService>();
            //services.AddTransient<IPromotionApplyRepository, PromotionApplyRepository>();
            //services.AddTransient<IPromotionApplyService, PromotionApplyService>();
            //services.AddTransient<IFacilityRepository, FacilityRepository>();
            //services.AddTransient<IFacilityService, FacilityService>();
            //services.AddTransient<IFacilityApplyRepository, FacilityApplyRepository>();
            //services.AddTransient<IFacilityApplyService, FacilityApplyService>();
            //services.AddTransient<IOfferRepository, OfferRepository>();
            //services.AddTransient<IOfferService, OfferService>();
            //services.AddTransient<IRoomTypeImageRepository, RoomTypeImageRepository>();
            //services.AddTransient<IRoomTypeImageService, RoomTypeImageService>();
            //services.AddTransient<ISupportRepository, SupportRepository>();
            //services.AddTransient<ISupportService, SupportService>();
            //services.AddTransient<IServiceImageRepository, ServiceImageRepository>();
            //services.AddTransient<IServiceImageService, ServiceImageService>();
            //services.AddTransient<ISearchService, SearchService>();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "HotelBookingSystem", Version = "v1" });
            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "HotelBookingSystem v1"));
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseHsts();
            app.UseHttpsRedirection();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
