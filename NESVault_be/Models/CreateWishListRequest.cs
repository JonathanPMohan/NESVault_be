﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NESVault_be.Models
{
    public class CreateWishListRequest
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int CartId { get; set; }
    }
}
