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
    public class TradeListRepository
    {
        const string ConnectionString = "Server = localhost; Database = NesVault; Trusted_Connection = True;";



        // GET ALL WISHLISTS //
        public List<TradeList> GetAllTradeLists()
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var getAllTradeListsQuery = @"
                 SELECT id,
                 UserId,
                 CartId,
                 Name,
                 Genre,
                 ReleaseDate,
                 ImageUrl,
                 FROM [Tradelist]";

                var allTradeLists = db.Query<TradeList>(getAllTradeListsQuery).ToList();

                if (allTradeLists != null)
                {
                    return allTradeLists;
                }
            }
            throw new Exception("No NESVault Trade Lists Found");
        }

        // GET TRADE LIST BY WISH LIST ID //
        public TradeList GetTradeListById(int id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var getTradeListByIdQuery = @"
                    SELECT 
                      *
                    FROM [Tradelist] w
                    WHERE w.Id = @id";

                var selectedTradeList = db.QueryFirstOrDefault<TradeList>(getTradeListByIdQuery, new { id });

                if (selectedTradeList != null)
                {
                    return selectedTradeList;
                }
                else
                {
                    return null;
                }

            }
            throw new Exception("NESVault TradeList Not Found");
        }

        // GET TRADELIST BY USER ID//
        public IEnumerable<TradeList> GetMyTradeList(int id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var myTradeList = db.Query<TradeList>("select id, userId, cartId, imageUrl, name, genre, releaseDate, loose, productId from tradelist where userId = @id",
                        new { id }).ToList();


                return myTradeList;
            }
        }

        // Get Single MyTradeListCart By ID //

        public MyCart GetMyTradeListCartById(int Id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {


                var mySelectedTradeListCart = db.QueryFirstOrDefault<MyCart>("select * from tradelist where Id = @id", new { Id });


                return mySelectedTradeListCart;
            }
        }


        // ADD NEW TRADE LIST //
        public TradeList AddNewTradeList(CreateTradeListRequest createRequest)
        {
            createRequest.Loose = System.Convert.ToDecimal(createRequest.Loose);
            using (var db = new SqlConnection(ConnectionString))
            {
                var newTradeListQuery = @"
                        INSERT INTO [Tradelist] (UserId, CartId, Name, Genre, ReleaseDate, ImageUrl, Loose, productId)
                        OUTPUT Inserted.*
                            VALUES(@UserId, @CartId, @name, @genre, @releaseDate, @imageUrl, @loose, @productId)";

                var MyNewTradeList = db.QueryFirstOrDefault<TradeList>(newTradeListQuery, new
                {
                    createRequest.UserId,
                    createRequest.CartId,
                    createRequest.Name,
                    createRequest.Genre,
                    createRequest.ReleaseDate,
                    createRequest.ImageUrl,
                    createRequest.Loose,
                    createRequest.ProductId,
                });

                if (MyNewTradeList != null)
                {
                    return MyNewTradeList;
                }
            }
            throw new Exception("NESVault Trade List Not Created");
        }

        // DELETE TRADE LIST ITEM //
        public void DeleteTradeListCart(int id)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var deleteUserQuery = "DELETE tradelist WHERE id = @id";

                var rowsAffected = db.Execute(deleteUserQuery, new { id });

                if (rowsAffected != 1)
                {
                    throw new Exception("Error Deleting The NESVault Trade List Cart");
                }
            }


        }

        // EDIT TRADE LIST //
        public TradeList UpdateTradeList(TradeList updatedTradeList)
        {
            using (var db = new SqlConnection(ConnectionString))
            {
                var editTradeListQuery = @"
                    UPDATE 
                      [Tradelist] 
                    SET 
                      [UserId] = @userId,
                      [CartId] = @cartId,
                      [Name] = @name,
                      [Genre] = @genre,
                      [ReleaseDate] = @releaseDate,
                      [ImageUrl] = @imageUrl
                    WHERE 
                      id = @id";

                var rowsAffected = db.Execute(editTradeListQuery, updatedTradeList);

                if (rowsAffected == 1)
                {
                    return updatedTradeList;
                }
                throw new Exception("Could Not Update NESVault Trade List");
            }
        }

    }
}

