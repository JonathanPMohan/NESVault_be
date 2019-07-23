using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using NESVault_be.Data;
using NESVault_be.Models;
using NESVault_be.Validators;

namespace NESVault_be.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : SecureControllerBase
    {
        readonly UsersRepository _repo;
        readonly UserRequestValidator _validator;
        readonly EditUserValidator _editUserValidator;

        public UsersController(UsersRepository repo)
        {
            _repo = repo;
            _validator = new UserRequestValidator();
            _editUserValidator = new EditUserValidator();

        }

        // ---- GET ALL USERS ---- //
        // GET: api/Users
        [HttpGet]
        public ActionResult<User> GetAllUsers()
        {
            var allUsers = _repo.GetAllUsers();
            return Ok(allUsers);
        }

        // ----- GET USERS BY ID ----- //
        // GET: api/Users/5
        [HttpGet("{id}", Name = "GetUserById")]
        public ActionResult GetUserById(int id)
        {
            var user = _repo.GetUserByUserId(id);
            return Ok(user);
        }

        // ----- ADD NEW USER ----- //
        // POST: api/Users
        [HttpPost]
        public ActionResult<CreateUserRequest> CreateUser([FromBody] CreateUserRequest newUserObject)
        {
            newUserObject.FireBaseUid = UserId;
            if (!_validator.Validate(newUserObject))
            {
                return BadRequest(new { error = "NESVault User Object Validation Failed " });
            }

            var newUser = _repo.AddNewUser(newUserObject);

            return Ok(newUser);
        }

        // ----- EDIT USER ----- //
        // PUT: api/Users/5
        [HttpPut("{id}")]
        public ActionResult<EditUserRequest> UpdateUser(int id, [FromBody] EditUserRequest updatedUserObj)
        {
            var jwtFirebaseId = UserId;
            User submittingUser = _repo.GetUserByUserId(id);
            if (updatedUserObj.FireBaseUid != jwtFirebaseId == false)
            {
                // return 401 as the User they are passing in is not the same as the one making the request
                return Unauthorized();
            }

            if (!_editUserValidator.Validate(updatedUserObj))
            {
                return BadRequest(new { error = "NESVault User Object Validation Failed " });
            }
            //return null;
            var updatedUser = _repo.UpdateUser(updatedUserObj);

            return Ok(updatedUser);
        }

        // ----- DELETE USER ----- //
        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        public ActionResult DeleteUser(int id)
        {
            _repo.DeleteUser(id);

            return Ok("The NESVault User Was Deleted");
        }
    }
}
