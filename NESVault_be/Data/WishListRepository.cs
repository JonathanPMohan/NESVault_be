using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using NESVault_be.Models;
using NESVault_be.Data;
using System.Data.SqlClient;
using Dapper;
using Microsoft.Extensions.Options;

namespace NESVault_be.Data
{
    public class WishListRepository
    {
        const string ConnectionString = "Server = localhost; Database = NesVault; Trusted_Connection = True;";

        

        // GET ALL WISHLISTS //
        public List<WishList> GetAllWishLists()
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var getAllWishListsQuery = @"
                 SELECT id,
                 UserId,
                 CartId,
                 Name,
                 Genre,
                 ReleaseDate,
                 ImageUrl,
                 FROM [Wishlist]";

                var allWishLists = db.Query<WishList>(getAllWishListsQuery).ToList();

                if (allWishLists != null)
                {
                    return allWishLists;
                }
            }
            throw new Exception("No NESVault Wish Lists Found");
        }

        // GET WISH LIST BY WISH LIST ID //
        public WishList GetWishListById(int id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var getWishListByIdQuery = @"
                    SELECT 
                      *
                    FROM [Wishlist] w
                    WHERE w.Id = @id";

                var selectedWishList = db.QueryFirstOrDefault<WishList>(getWishListByIdQuery, new { id });

                if (selectedWishList != null)
                {
                    return selectedWishList;
                }
                else
                {
                    return null;
                }

            }
            throw new Exception("NESVault WishList Not Found");
        }

        // GET WISHLIST BY USER ID//
        public IEnumerable<WishList> GetMyWishList(int id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var myWishList = db.Query<WishList>("select id, userId, cartId, imageUrl, name, genre, releaseDate from wishlist where userId = @id",
                        new { id }).ToList();


                return myWishList;
            }
        }
        

        // ADD NEW WISH LIST //
        public WishList AddNewWishList(CreateWishListRequest newWishList)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var newWishListQuery = @"
                        INSERT INTO [Wishlist] (UserId, CartId, Name, Genre, ReleaseDate, ImageUrl)
                        OUTPUT Inserted.*
                            VALUES(@UserId, @CartId, @name, @genre, @releaseDate, @imageUrl)";

                var MyNewWishList = db.QueryFirstOrDefault<WishList>(newWishListQuery, new
                {
                    newWishList.UserId,
                    newWishList.CartId,
                    newWishList.Name,
                    newWishList.Genre,
                    newWishList.ReleaseDate,
                    newWishList.ImageUrl,
                });

                if (MyNewWishList != null)
                {
                    return MyNewWishList;
                }
            }
            throw new Exception("NESVault Wish List Not Created");
        }

        // DELETE WISH LIST //
        public void DeleteWishList(int id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var deleteUserQuery = @"
                    UPDATE 
                      [Wishlist] 
                    SET 
                      [IsDeleted] = 1 
                    WHERE 
                      id = @id";

                var rowsAffected = db.Execute(deleteUserQuery, new { id });

                if (rowsAffected != 1)
                {
                    throw new Exception("Error Deleting The NESVault Wish List");
                }
            }


        }

        // EDIT WISH LIST //
        public WishList UpdateWishList(WishList updatedWishList)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var editWishListQuery = @"
                    UPDATE 
                      [Wishlist] 
                    SET 
                      [UserId] = @userId,
                      [CartId] = @cartId,
                      [Name] = @name,
                      [Genre] = @genre,
                      [ReleaseDate] = @releaseDate,
                      [ImageUrl] = @imageUrl
                    WHERE 
                      id = @id";

                var rowsAffected = db.Execute(editWishListQuery, updatedWishList);

                if (rowsAffected == 1)
                {
                    return updatedWishList;
                }
                throw new Exception("Could Not Update NESVault Wish List");
            }
        }

    }
}


