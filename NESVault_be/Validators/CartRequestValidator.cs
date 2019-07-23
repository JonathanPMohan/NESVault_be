using NESVault_be.Models;

namespace NESVault_be.Validators
{
    public class CartRequestValidator
    {
        public bool Validate(CreateCartRequest requestToValidate)
        {
            return !(string.IsNullOrEmpty(requestToValidate.Name)
                || string.IsNullOrEmpty(requestToValidate.Genre)
                || string.IsNullOrEmpty(requestToValidate.ReleaseDate.ToString())
                || string.IsNullOrEmpty(requestToValidate.Loose.ToString())
                || string.IsNullOrEmpty(requestToValidate.Cib.ToString())
                || string.IsNullOrEmpty(requestToValidate.New.ToString()
                ));
        }
    }
}
