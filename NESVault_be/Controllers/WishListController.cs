using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using NESVault_be.Data;
using NESVault_be.Models;
using NESVault_be.Validators;
namespace NESVault_be.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WishListController : SecureControllerBase
    {
        readonly WishListRepository _wishListRepository;

        public WishListController()
        {
            _wishListRepository = new WishListRepository();
        }

        // ----- GET ALL WISHLISTS ----- //
        // GET: api/Wishlists
        [HttpGet("wishlists")]
        public ActionResult GetAllWishLists()
        {
            var allWishLists = _wishListRepository.GetAllWishLists();

            return Ok(allWishLists);
        }

        // GET WISHLIST BY USER ID //
        // GET: api/WishList/
        [HttpGet("{id}")]
        public ActionResult GetMyWishList(int Id)
        {
            var myWishList = _wishListRepository.GetMyWishList(Id);

            return Ok(myWishList);
        }

        //// GET WISHLIST CART BY CART ID //
        //// GET: api/WishList/5
        //[HttpGet("{id}")]
        //public ActionResult GetMyWishListCart(int Id)
        //{
        //    var myWishListCart = _wishListRepository.GetMyWishListCartById(Id);

        //    return Ok(myWishListCart);
        //}



        // ----- ADD NEW WISH LIST ---- //
        // POST: api/WishList
        [HttpPost]
        public ActionResult AddMyWishList(CreateWishListRequest createRequest)
        {
            var newWishList = _wishListRepository.AddNewWishList(createRequest);
            if (newWishList == null)
            {
                return BadRequest(new { error = "NESVault Requests You Fill All Necessary Fields." });
            }
            else
            {

                return Created($"api/wishlist/{newWishList.Id}", newWishList);
            }
        }

        // ----- UPDATE WISH LIST ---- //
        // PUT: api/WishList/Update/5
        [HttpPut("update/{id}")]
        public ActionResult UpdateWishList(int id, WishList wishListToUpdate)
        {
            if (id != wishListToUpdate.Id)
            {
                return BadRequest(new { Error = "NESVault Needs A Bit More Product Information." });
            }
            var updatedMyWishList = _wishListRepository.UpdateWishList(wishListToUpdate);

            return Ok(updatedMyWishList);
        }

        // ----- DELETE WISH LIST ITEM---- //
        // DELETE: api/WishList/Delete/5
        [HttpDelete("{id}")]
        public ActionResult DeleteWishList(int id)
        {
            _wishListRepository.DeleteWishList(id);

            return Ok("Your NESVault Wish List Item Has Been Deleted.");
        }
    }
}
