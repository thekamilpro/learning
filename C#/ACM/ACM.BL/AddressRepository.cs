using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ACM.BL
{
   public class AddressRepository
    {
        public Address Retrieve(int AddressId)
        {
            Address address = new Address(AddressId);

            if (AddressId == 1)
            {
                address.AddressType = 1;
                address.StreetLine1 = "Bag End";
                address.StringLine2 = "Bagshot row";
                address.City = "Hobbiton";
                address.State = "Shire";
                address.Country = "Middle Earth";
                address.PostalCode = "144";
            }
            return address;
        }

        public IEnumerable<Address> RetrieveByCustomerId(int customerId)
        {
            var addressList = new List<Address>();
            Address address = new Address(1)
            {
                AddressType = 1,
            StreetLine1 = "Bag End",
            StringLine2 = "Bagshot row",
            City = "Hobbiton",
            State = "Shire",
            Country = "Middle Earth",
            PostalCode = "144"
        };
            addressList.Add(address);

            address = new Address(2)
            {
                AddressType = 2,
                StreetLine1 = "Green Dragon",
                City = "Bywater",
                State = "Shire",
                Country = "Middle Earth",
                PostalCode = "146"
            };

            return addressList;
        }
        public bool Save(Address add)
        {
            return true;
        }
    }
}
