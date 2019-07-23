using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using NESVault_be.Data;
using NESVault_be.Models;
using NESVault_be.Validators;

namespace NESVault_be.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CartsController : SecureControllerBase
    {

        readonly CartsRepository _cartRepository;
        readonly CartRequestValidator _validator;

        public CartsController()
        {
            _validator = new CartRequestValidator();
            _cartRepository = new CartsRepository();
        }

        // ----- GET ALL CARTS ----- //
        // GET: api/Carts
        [HttpGet]
        public ActionResult GetAllCarts()
        {
            var carts = _cartRepository.GetCarts();

            return Ok(carts);
        }

        // ----- GET ALL CART GENRES ---- //
        // GET: api/Carts/Genres
        [HttpGet("genres")]
        public ActionResult GetCartGenres()
        {
            var cartGenres = _cartRepository.GetCartGenres();

            return Ok(cartGenres);
        }

        // ----- GET ALL CARTS BY GENRE ID ----- //
        // GET: api/Carts/Genre/5
        [HttpGet("genre/{genreId}")]
        public ActionResult GetCartsByGenre(string genre)
        {
            var selectedGenre = _cartRepository.GetCartsByGenre(genre);

            return Ok(selectedGenre);
        }

        // ----- GET CART BY ID ---- //
        // GET: api/Carts/5
        [HttpGet("{id}")]
        public ActionResult GetCartById(int id)
        {
            return Ok(_cartRepository.GetCartById(id));
        }

        // ----- ADD NEW CART ---- //
        // POST: api/Cart
        [HttpPost]
        public ActionResult AddCart(CreateCartRequest createRequest)
        {
            if (!_validator.Validate(createRequest))
            {
                return BadRequest(new { error = "NESVault Requests You Fill All Necessary Fields." });
            }

            var newCart = _cartRepository.AddCart(createRequest);

            return Created($"api/cart/{newCart.Id}", newCart);
        }

        // ----- UPDATE CART ---- //
        // PUT: api/Carts/Update/5
        [HttpPut("update/{id}")]
        public ActionResult UpdateCart(int id, Cart cartToUpdate)
        {
            if (id != cartToUpdate.Id)
            {
                return BadRequest(new { Error = "NESVault Needs A Bit More Product Information." });
            }
            var updatedCart = _cartRepository.UpdateCart(cartToUpdate);

            return Ok(updatedCart);
        }

        // ----- DELETE CART---- //
        // DELETE: api/Carts/Delete/5
        [HttpDelete("{id}")]
        public ActionResult DeleteCart(int id)
        {
            _cartRepository.DeleteCart(id);

            return Ok("Your NESVault Cart Has Been Deleted.");
        }
    }
}