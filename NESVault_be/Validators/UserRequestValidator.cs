﻿using NESVault_be.Models;

namespace NESVault_be.Validators
{
    public class UserRequestValidator
    {
        public bool Validate(CreateUserRequest requestToValidate)
        {
            return !(string.IsNullOrEmpty(requestToValidate.FireBaseUid)
                || string.IsNullOrEmpty(requestToValidate.FirstName)
                || string.IsNullOrEmpty(requestToValidate.LastName)
                || string.IsNullOrEmpty(requestToValidate.UserName)
                || string.IsNullOrEmpty(requestToValidate.Email));
        }
    }
}
