using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication1.Models.DTOS
{
    public class ReadPostDTO
    {
        public int Id { get; set; }
        public string Titulo { get; set; }
        public string Conteudo { get; set; }
        public string  UserName { get; set; }


        public ReadPostDTO()
        {

        }
        public ReadPostDTO(string titulo, string conteudo, string userName)
        {
            Titulo = titulo;
            Conteudo = conteudo;
            this.UserName = userName;
        }
    }
}
