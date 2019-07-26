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
        readonly string _connectionString;

        public WishListRepository(IOptions<DbConfiguration> dbConfig)
        {
            _connectionString = dbConfig.Value.ConnectionString;
        }

        // GET ALL WISHLISTS //
        public List<WishList> GetAllWishLists()
        {
            using (var db = new SqlConnection(_connectionString))
            {
                var getAllWishListsQuery = @"
                 SELECT id,
                 UserId,
                 CartId,
                 FROM [Wishlist]";

                var allWishLists = db.Query<User>(getAllWishListsQuery).ToList();

                if (allWishLists != null)
                {
                    return allWishLists;
                }
            }
            throw new Exception("No NESVault Wish Lists Found");
        }

        // GET WISH LIST BY FIREBASE ID //
        public WishList GetWishListById(int id)
        {
            using (var db = new SqlConnection(_connectionString))
            {
                var getWishListByIdQuery = @"
                    SELECT 
                      *
                    FROM [Wishlist] w
                    WHERE w.Id = @id";

                var selectedWishList = db.QueryFirstOrDefault<User>(getWishListByIdQuery, new { id });

                if (selectedWishList != null)
                {
                    return selectedWishList;
                }
                else
                {
                    return null;
                }

            }
            throw new Exception("NESVault User Not Found");
        }

        // GET USER BY USER ID //
        //public User GetUserByUserId(int id)
        //{
        //    using (var db = new SqlConnection(_connectionString))
        //    {
        //        var getUserByIdQuery = @"
        //            SELECT
        //               *
        //            FROM [Users] u
        //            WHERE u.id = @id";

        //        var selectedUser = db.QueryFirstOrDefault<User>(getUserByIdQuery, new { id });

        //        if (selectedUser != null)
        //        {
        //            return selectedUser;
        //        }
        //    }
        //    throw new Exception("NESVault User Not Found");
        //}

        // ADD NEW WISH LIST //
        public WishList AddNewWishList(CreateWishListRequest newWishList)
        {
            using (var db = new SqlConnection(_connectionString))
            {
                var newWishListQuery = @"
                        INSERT INTO [Wishlist] (UserId, CartId)
                        OUTPUT Inserted.*
                            VALUES(@UserId, @CartId)";

                var newWishList = db.QueryFirstOrDefault<WishList>(newWishListQuery, new
                {
                    newWishList.UserId,
                    newWishList.CartId,
                });

                if (newWishList != null)
                {
                    return newWishList;
                }
            }
            throw new Exception("NESVault Wish List Not Created");
        }

        // DELETE WISH LIST //
        public void DeleteWishList(int id)
        {
            using (var db = new SqlConnection(_connectionString))
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
        public UpdateWishListRequest UpdateWishList(UpdateWishListRequest updatedWishList)
        {
            using (var db = new SqlConnection(_connectionString))
            {
                var editWishListQuery = @"
                    UPDATE 
                      [Wishlist] 
                    SET 
                      [UserId] = @userId,
                      [CartId] = @cartId
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


