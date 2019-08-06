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
    public class CartsRepository
    {
        const string ConnectionString = "Server = localhost; Database = NesVault; Trusted_Connection = True;";


        public Cart AddCart(CreateCartRequest createRequest)
        {
            createRequest.Loose = System.Convert.ToDecimal(createRequest.Loose);
            createRequest.Cib= System.Convert.ToDecimal(createRequest.Cib);
            createRequest.New = System.Convert.ToDecimal(createRequest.New);
            using (var db = new SqlConnection(ConnectionString))
            {
                var newCart = db.QueryFirstOrDefault<Cart>(@"
                    Insert into carts (name, imageUrl, genre, releasedate, loose, cib, new, productId)
                    Output inserted.*
                    Values(@name, @imageUrl, @genre, @releasedate, @loose, @cib, @new, @productId)",
                    new
                    {
                        createRequest.Name,
                        createRequest.ImageUrl,
                        createRequest.Genre,
                        createRequest.ReleaseDate,
                        createRequest.Loose,
                        createRequest.Cib,
                        createRequest.New,
                        createRequest.ProductId,
                    });

                if (newCart != null)
                {
                    return newCart;
                }
            }

            throw new Exception("Sorry. No NESVault Cart Was Created.");
        }


        // Get All Carts Command //

        public IEnumerable<Cart> GetCarts()
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var carts = db.Query<Cart>("select id, name, imageUrl, genre, releaseDate, loose, cib, new, productId from carts").ToList();


                return carts;
            }
        }

        // Get All Cart Genres //

        public IEnumerable<Cart> GetCartGenres()
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var cartGenres = db.Query<Cart>("select genre from carts").ToList();

                return cartGenres;
            }
        }

        // Get Carts By Genre //

        public IEnumerable<Cart> GetCartsByGenre(string genre)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var selectedGenre = db.Query<Cart>("select id, name, imageUrl, genre, releaseDate, loose, cib, new from carts where genre = @genre", new { genre });


                return selectedGenre;
            }
        }



        // Get Single Cart By ID //

        public Cart GetCartById(int Id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {


                var selectedCart = db.QueryFirstOrDefault<Cart>("select id, name, imageUrl, genre, releaseDate, loose, cib, new, productId from carts where Id = @id", new { Id });


                return selectedCart;
            }
        }

        // Delete Cart Command //

        public void DeleteCart(int Id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var parameter = new { Id = Id };
                var deleteQuery = "UPDATE carts SET isDeleted = 1 WHERE id = @id";

                var rowsAffected = db.Execute(deleteQuery, parameter);

                if (rowsAffected != 1)
                {
                    throw new Exception("Error. We're Sorry, But Your NESVault Cart Was Not Deleted.");
                }
            }
        }

        // Update Cart Command //

        public Cart UpdateCart(Cart cartToUpdate)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var updateQuery = @"Update Carts
                                Set Name = @name,
                                ImageUrl = @imageUrl,
                                Genre = @genre,
                                ReleaseDate = @releaseDate,
                                Loose = @loose,
                                Cib = @cib,
                                New = @new
                                Where Id = @id";

                var rowsAffected = db.Execute(updateQuery, cartToUpdate);

                if (rowsAffected == 1)
                {
                    return cartToUpdate;
                }

                throw new Exception("There Was An Error. Your NESVault Cart Wasn't Updated");
            }

        }
    }
}