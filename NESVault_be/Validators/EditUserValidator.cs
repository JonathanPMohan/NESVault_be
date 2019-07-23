using NESVault_be.Models;

namespace NESVault_be.Validators
{
    public class EditUserValidator
    {

        public bool Validate(EditUserRequest requestToValidate)
        {
            return !(string.IsNullOrEmpty(requestToValidate.FireBaseUid)
                || string.IsNullOrEmpty(requestToValidate.FirstName)
                || string.IsNullOrEmpty(requestToValidate.LastName)
                || string.IsNullOrEmpty(requestToValidate.UserName)
                || string.IsNullOrEmpty(requestToValidate.Email));
        }

    }
}