using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication1.Models.DTOS
{
    public class CreateUserDTO
    {
        [Required]
        public string Usarname { get; set; }
        [Required]

        public string Email { get; set; }
        [Required]

        public string Senha { get; set; }
        [Compare("Senha", ErrorMessage ="Senhas não são iguais")]

        public string ReSenha { get; set; }
    }
}
