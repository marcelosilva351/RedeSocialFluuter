using Microsoft.AspNet.Identity;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using TarefasApiApp;
using WebApplication1.Data;
using WebApplication1.Models;
using WebApplication1.Models.DTOS;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("v1/users")]
    public class UsersController : ControllerBase
    {
        private readonly Context _context;

        public UsersController(Context context)
        {
            _context = context;
        }


        [HttpPost("Cadastrar")]

        public async Task<ActionResult> CadastrarUsuario([FromBody] CreateUserDTO createUserDTO, [FromServices] IPasswordHasher hasher)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            var senha = hasher.HashPassword(createUserDTO.Senha);

            var UserAdd = new User(createUserDTO.Usarname, createUserDTO.Email, senha);
            _context.Users.Add(UserAdd);
            await _context.SaveChangesAsync();
            return Created("Usuario criado", UserAdd);
        }
        
        [HttpPost("Logar")]

        public async Task<ActionResult<string>> LogarUser(LoginUserDTO loginUserDTO,[FromServices] IPasswordHasher hasher)
        {
            var userFind = _context.Users.FirstOrDefault(x => x.Email == loginUserDTO.Email);
            if(userFind == null)
            {
                return NotFound("Não existe usuario com esse email");
            }
            var resultHash = hasher.VerifyHashedPassword(userFind.Senha, loginUserDTO.Senha);
            if (resultHash != Microsoft.AspNet.Identity.PasswordVerificationResult.Success)
            {
                return NotFound("Senha incorreta");
            }

            var token = GenerateToken(loginUserDTO);

            return Ok(token);

        }


        [HttpGet("{email}")]
        public async Task<ActionResult<User>> ObterUser(string email)
        {
            var user = await _context.Users.FirstOrDefaultAsync(x => x.Email == email);
            return Ok(user);
        }

        private string GenerateToken(LoginUserDTO user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var keyByte = Encoding.ASCII.GetBytes(SettingsAuthentication.Key);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.Name, user.Email),
                    new Claim(ClaimTypes.NameIdentifier, user.Email)


                }),
                Expires = DateTime.UtcNow.AddHours(2),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(keyByte), SecurityAlgorithms.HmacSha256Signature)

            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);

        }

    }
}
