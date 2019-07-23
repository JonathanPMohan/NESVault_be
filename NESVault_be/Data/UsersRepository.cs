using Dapper;
using Microsoft.Extensions.Options;
using NESVault_be.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace NESVault_be.Data
{
    public class UsersRepository
    {
        readonly string _connectionString;

        public UsersRepository(IOptions<DbConfiguration> dbConfig)
        {
            _connectionString = dbConfig.Value.ConnectionString;
        }

        // GET ALL USERS //
        public List<User> GetAllUsers()
        {
            using (var db = new SqlConnection(_connectionString))
            {
                var getAllUsersQuery = @"
                 SELECT id,
                 UserName,
                 FirstName,
                 LastName,
                 Email,
                 FireBaseUid,
                 IsDeleted
                 FROM [Users]";

                var allUsers = db.Query<User>(getAllUsersQuery).ToList();

                if (allUsers != null)
                {
                    return allUsers;
                }
            }
            throw new Exception("No NESVault Users Found");
        }

        // GET USER BY FIREBASE ID //
        public User GetUserByFireBaseId(string id)
        {
            using (var db = new SqlConnection(_connectionString))
            {
                var getUserByIdQuery = @"
                    SELECT 
                      *
                    FROM [Users] u
                    WHERE u.FireBaseUid = @id";

                var selectedUser = db.QueryFirstOrDefault<User>(getUserByIdQuery, new { id });

                if (selectedUser != null)
                {
                    return selectedUser;
                }
            }
            throw new Exception("NESVault User Not Found");
        }

        // GET USER BY USER ID //
        public User GetUserByUserId(int id)
        {
            using (var db = new SqlConnection(_connectionString))
            {
                var getUserByIdQuery = @"
                    SELECT
                       *
                    FROM [Users] u
                    WHERE u.id = @id";

                var selectedUser = db.QueryFirstOrDefault<User>(getUserByIdQuery, new { id });

                if (selectedUser != null)
                {
                    return selectedUser;
                }
            }
            throw new Exception("NESVault User Not Found");
        }

        // ADD NEW USER //
        public User AddNewUser(CreateUserRequest newUserObj)
        {
            using (var db = new SqlConnection(_connectionString))
            {
                var newUserQuery = @"
                        INSERT INTO [Users] (UserName, FirstName, LastName, Email, FireBaseUid)
                        OUTPUT Inserted.*
                            VALUES(@UserName, @FirstName, @LastName, @Email, @FireBaseUid)";

                var newUser = db.QueryFirstOrDefault<User>(newUserQuery, new
                {
                    newUserObj.UserName,
                    newUserObj.FirstName,
                    newUserObj.LastName,
                    newUserObj.Email,
                    newUserObj.FireBaseUid,
                    newUserObj.IsDeleted,
                });

                if (newUser != null)
                {
                    return newUser;
                }
            }
            throw new Exception("NESVault User Not Created");
        }

        // DELETE USER //
        public void DeleteUser(int id)
        {
            using (var db = new SqlConnection(_connectionString))
            {
                var deleteUserQuery = @"
                    UPDATE 
                      [Users] 
                    SET 
                      [IsDeleted] = 1 
                    WHERE 
                      id = @id";

                var rowsAffected = db.Execute(deleteUserQuery, new { id });

                if (rowsAffected != 1)
                {
                    throw new Exception("Error Deleting The NESVault User");
                }
            }


        }

        // EDIT USER //
        public EditUserRequest UpdateUser(EditUserRequest updatedUserObj)
        {
            using (var db = new SqlConnection(_connectionString))
            {
                var editUserQuery = @"
                    UPDATE 
                      [Users] 
                    SET 
                      [UserName] = @userName,
                      [FirstName] = @firstName, 
                      [LastName] = @lastName, 
                      [Email] = @email, 
                      [FireBaseUid] = @firebaseUid,
                      [IsDeleted] = @isDeleted 
                    WHERE 
                      id = @id";

                var rowsAffected = db.Execute(editUserQuery, updatedUserObj);

                if (rowsAffected == 1)
                {
                    return updatedUserObj;
                }
                throw new Exception("Could Not Update NESVault User");
            }
        }

    }
}

