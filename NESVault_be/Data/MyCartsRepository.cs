using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using NESVault_be.Models;
using NESVault_be.Data;
using System.Data.SqlClient;
using Dapper;

namespace NESVault_be.Data
{
    public class MyCartsRepository
    {
        const string ConnectionString = "Server = localhost; Database = NesVault; Trusted_Connection = True;";

        // Add MyCart Command //

        public MyCart AddMyCart(CreateMyCartRequest createRequest)
        {
            createRequest.Loose = System.Convert.ToDecimal(createRequest.Loose);
            using (var db = new SqlConnection(ConnectionString))
            {
                var newMyCart = db.QueryFirstOrDefault<MyCart>(@"
                    Insert into myCarts (userId, cartsId, ImageUrl, name, genre, releaseDate, loose)
                    Output inserted.*
                    Values(@userId, @cartsId, @imageUrl, @name, @genre, @releaseDate, @loose)",
                    new
                    {
                        createRequest.UserId,
                        createRequest.CartsId,
                        createRequest.ImageUrl,
                        createRequest.Name,
                        createRequest.Genre,
                        createRequest.ReleaseDate,
                        createRequest.Loose,
                    });

                if (newMyCart != null)
                {
                    return newMyCart;
                }
            }

            throw new Exception("Sorry. No NESVault Cart Was Created.");
        }


        // Get All MyCarts Command //

        public IEnumerable<MyCart> GetMyCarts(int id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var myCarts = db.Query<MyCart>("select * from myCarts where userId = @id",
                        new { id }).ToList();


                return myCarts;
            }
        }


        // Get MyCarts By Genre //

        public IEnumerable<MyCart> GetMyCartsByGenre(string genre)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var myCartSelectedGenre = db.Query<MyCart>("select id, userId, cartsId, imageUrl, name, genre, releaseDate from myCarts where genre = @genre", new { genre });


                return myCartSelectedGenre;
            }
        }



        // Get Single MyCart By ID //

        public MyCart GetMyCartById(int Id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {


                var mySelectedCart = db.QueryFirstOrDefault<MyCart>("select * from myCarts where Id = @id", new { Id });


                return mySelectedCart;
            }
        }

        // Delete Cart Command //

        public void DeleteMyCart(int Id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var parameter = new { Id = Id };
                var deleteQuery = "UPDATE myCarts SET isDeleted = 1 WHERE id = @id";

                var rowsAffected = db.Execute(deleteQuery, parameter);

                if (rowsAffected != 1)
                {
                    throw new Exception("Error. We're Sorry, But Your NESVault Cart Was Not Deleted.");
                }
            }
        }

        // Update Cart Command //

        public MyCart UpdateMyCart(MyCart myCartToUpdate)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var updateQuery = @"Update MyCarts
                                Set UserId = @userId,
                                CartsId = @cartsId,
                                ImageUrl = @imageUrl,
                                Name = @name,
                                Genre = @genre,
                                ReleaseDate = @releaseDate,
                                Where Id = @id";

                var rowsAffected = db.Execute(updateQuery, myCartToUpdate);

                if (rowsAffected == 1)
                {
                    return myCartToUpdate;
                }

                throw new Exception("There Was An Error. Your NESVault Cart Wasn't Updated");
            }

        }
    }
}
