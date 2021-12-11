using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication1.Models
{
    public class Posts
    {
        public int Id { get; set; }
        public string Titulo { get; set; }
        public string Conteudo { get; set; }
        public User user { get; set; }
        public int UserId { get; set; }

        public Posts()
        {
        }

        public Posts(string titulo, string conteudo, int userId)
        {
            Titulo = titulo;
            Conteudo = conteudo;
            UserId = userId;
        }
    }
}
