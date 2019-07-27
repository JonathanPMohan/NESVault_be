using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace NESVault_be.Models
{
    public class UpdateUserRequest
    {
        public int Id { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string FavoriteGame { get; set; }
        public string Email { get; set; }
        public string FireBaseUid { get; set; }
        public bool IsDeleted { get; set; }
    }
}
