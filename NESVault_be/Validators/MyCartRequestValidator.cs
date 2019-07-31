using System;
using System.Collections.Generic;
using NESVault_be.Models;

namespace NESVault_be.Validators
{
    public class MyCartRequestValidator
    {
        public bool Validate(CreateMyCartRequest requestToValidate)
        {
            return !(string.IsNullOrEmpty(requestToValidate.Name)
                || string.IsNullOrEmpty(requestToValidate.Genre)
                || string.IsNullOrEmpty(requestToValidate.ReleaseDate.ToString())
                || string.IsNullOrEmpty(requestToValidate.Loose.ToString())
                );
        }
    }
}
