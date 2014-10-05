﻿namespace Articles.WebAPI.Controllers
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Net;
    using System.Net.Http;
    using System.Web.Http;

    using Articles.Data;

    public class BaseApiController : ApiController
    {
        protected IArticlesData data;

        public BaseApiController(IArticlesData data)
        {
            this.data = data;
        }
    }
}
