using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication1.Models.DTOS
{
    public class PostCreateDTO
    {
        [Required]
        public string Titulo { get; set; }
        [Required]
        public string Conteudo { get; set; }
        [Required]
        public int UserId { get; set; }
    }
}
