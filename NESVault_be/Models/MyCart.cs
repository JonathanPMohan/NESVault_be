using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NESVault_be.Models
{
    public class MyCart
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int CartsId { get; set; }
        public string ImageUrl{ get; set; }
    }
}
