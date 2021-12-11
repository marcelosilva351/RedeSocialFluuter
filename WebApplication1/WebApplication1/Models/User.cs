using System.Collections.Generic;

namespace WebApplication1.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Usarname { get; set; }
        public string Email { get; set; }
        public string Senha { get; set; }
        public List<Posts> Posts { get; set; } = new List<Posts>();


        public User()
        {

        }
        public User(string username, string email, string senha)
        {
            Usarname = username;
            Email = email;
            Senha = senha;
        }
    }
}