using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NESVault_be.Models
{
    public class CreateCartRequest
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string ImageUrl { get; set; }
        public string Genre { get; set; }
        public DateTime ReleaseDate { get; set; }
        public decimal Loose { get; set; }
        public decimal Cib { get; set; }
        public decimal New { get; set; }
        public int ProductId { get; set; }
    }
}
