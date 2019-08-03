using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using NESVault_be.Data;
using NESVault_be.Models;
using NESVault_be.Validators;

namespace NESVault_be.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MyCartsController : SecureControllerBase
    {

        readonly MyCartsRepository _myCartRepository;
        readonly MyCartRequestValidator _validator;

        public MyCartsController()
        {
            _validator = new MyCartRequestValidator();
            _myCartRepository = new MyCartsRepository();
        }

        // ----- GET ALL MYCARTS ----- //
        // GET: api/MyCarts
        [HttpGet("mycollection/{id}")]
        public ActionResult GetAllMyCarts(int id)
        {
            var myCarts = _myCartRepository.GetMyCarts(id);

            return Ok(myCarts);
        }

        //// ----- GET ALL MY CART GENRES ---- //
        //// GET: api/MyCarts/Genres
        //[HttpGet("genres")]
        //public ActionResult GetMyCartsByGenre()
        //{
        //    var myCartGenres = _myCartRepository.GetMyCartsByGenre();

        //    return Ok(myCartGenres);
        //}

        // ----- GET ALL MY CARTS BY GENRE ID ----- //
        // GET: api/MyCarts/Genre/5
        [HttpGet("genre/{genreId}")]
        public ActionResult GetMyCartsByGenre(string genre)
        {
            var myCartSelectedGenre = _myCartRepository.GetMyCartsByGenre(genre);

            return Ok(myCartSelectedGenre);
        }

        // ----- GET MY CART BY ID ---- //
        // GET: api/MyCarts/5
        [HttpGet("{id}")]
        public ActionResult GetMyCartById(int id)
        {
            return Ok(_myCartRepository.GetMyCartById(id));
        }

        // ----- ADD NEW MY CART ---- //
        // POST: api/MyCart
        [HttpPost]
        public ActionResult AddMyCart(CreateMyCartRequest createRequest)
        {
            if (!_validator.Validate(createRequest))
            {
                return BadRequest(new { error = "NESVault Requests You Fill All Necessary Fields." });
            }

            var newMyCart = _myCartRepository.AddMyCart(createRequest);

            return Created($"api/mycart/{newMyCart.Id}", newMyCart);
        }

        // ----- UPDATE CART ---- //
        // PUT: api/MyCarts/Update/5
        [HttpPut("update/{id}")]
        public ActionResult UpdateMyCart(int id, MyCart myCartToUpdate)
        {
            if (id != myCartToUpdate.Id)
            {
                return BadRequest(new { Error = "NESVault Needs A Bit More Product Information." });
            }
            var updatedMyCart = _myCartRepository.UpdateMyCart(myCartToUpdate);

            return Ok(updatedMyCart);
        }

        // ----- DELETE My CART---- //
        // DELETE: api/MyCarts/Delete/5
        [HttpDelete("delete/{id}")]
        public ActionResult DeleteMyCart(int id)
        {
            _myCartRepository.DeleteMyCart(id);

            return Ok("Your NESVault Cart Has Been Deleted.");
        }
    }
}