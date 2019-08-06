using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using NESVault_be.Data;
using NESVault_be.Models;
using NESVault_be.Validators;

namespace NESVault_be.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TradeListController : SecureControllerBase
    {
        readonly TradeListRepository _tradeListRepository;

        public TradeListController()
        {
            _tradeListRepository = new TradeListRepository();
        }

        // ----- GET ALL WISHLISTS ----- //
        // GET: api/Tradelists
        [HttpGet("tradelists")]
        public ActionResult GetAllTradeLists()
        {
            var allTradeLists = _tradeListRepository.GetAllTradeLists();

            return Ok(allTradeLists);
        }

        // GET TRADELIST BY USER ID //
        // GET: api/TradeList/
        [HttpGet("{id}")]
        public ActionResult GetMyTradeList(int Id)
        {
            var myTradeList = _tradeListRepository.GetMyTradeList(Id);

            return Ok(myTradeList);
        }

       
        // ----- ADD NEW TRADE LIST ---- //
        // POST: api/TradeList
        [HttpPost]
        public ActionResult AddMyTradeList(CreateTradeListRequest createRequest)
        {
            var newTradeList = _tradeListRepository.AddNewTradeList(createRequest);
            if (newTradeList == null)
            {
                return BadRequest(new { error = "NESVault Requests You Fill All Necessary Fields." });
            }
            else
            {

                return Created($"api/tradelist/{newTradeList.Id}", newTradeList);
            }
        }

        // ----- UPDATE TRADE LIST ---- //
        // PUT: api/TradeList/Update/5
        [HttpPut("update/{id}")]
        public ActionResult UpdateTradeList(int id, TradeList tradeListToUpdate)
        {
            if (id != tradeListToUpdate.Id)
            {
                return BadRequest(new { Error = "NESVault Needs A Bit More Product Information." });
            }
            var updatedMyTradeList = _tradeListRepository.UpdateTradeList(tradeListToUpdate);

            return Ok(updatedMyTradeList);
        }

        // ----- DELETE TRADE LIST ITEM---- //
        // DELETE: api/TradeList/Delete/5
        [HttpDelete("delete/{id}")]
        public ActionResult DeleteTradeList(int id)
        {
            _tradeListRepository.DeleteTradeListCart(id);

            return Ok("Your NESVault Trade List Item Has Been Deleted.");
        }
    }
}
