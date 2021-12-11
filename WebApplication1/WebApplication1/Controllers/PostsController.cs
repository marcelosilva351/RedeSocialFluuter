using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication1.Data;
using WebApplication1.Models;
using WebApplication1.Models.DTOS;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("v1/posts")]
    public class PostsController : ControllerBase
    {
        private readonly Context _context;

        public PostsController(Context context)
        {
            _context = context;
        }

        [HttpGet("PostsAll")]
        public async Task<ActionResult<List<ReadPostDTO>>> PostsAll()
        {
            var postsAll = await _context.Posts.Include(x => x.user).Select(x => new ReadPostDTO
            {
             
                Id = x.Id,
                Conteudo = x.Conteudo,
                Titulo = x.Titulo,
                UserName = x.user.Usarname
            }
                ).ToListAsync();

            if (postsAll == null)
            {
                return NotFound();
            }
            return Ok(postsAll);
        }


        [HttpGet("PostsUser/{email}")]
        public async Task<ActionResult<List<ReadPostDTO>>> PostUser(string email)
        {
            var user = _context.Users.FirstOrDefault(x => x.Email == email);


            var postsUser = await _context.Posts.Include(x => x.user).Where(x => x.UserId == user.Id).Select(x => new ReadPostDTO
            {
                Id = x.Id,
                Conteudo = x.Conteudo,
                Titulo = x.Titulo,
                UserName = x.user.Usarname
            }
                ).ToListAsync();
            if (postsUser == null)
            {
                return NotFound();
            }
            return postsUser;
        }
        [HttpPost]
        public async Task<ActionResult> CadastrarPost(PostCreateDTO postCreateDTO)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            var postAdd = new Posts(postCreateDTO.Titulo, postCreateDTO.Conteudo, postCreateDTO.UserId);
            _context.Add(postAdd);
            await _context.SaveChangesAsync();
            return Created("Criado", postAdd);
        }

        [HttpPut("{id}")]

        public async Task<ActionResult> atualiarPost(int id,string titulo, string conteudo)
        {
            var post = _context.Posts.FirstOrDefault(x => x.Id == id);
            post.Conteudo = conteudo;
            post.Titulo = titulo;
            _context.Update(post);
            await _context.SaveChangesAsync();
            return NoContent();


        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> apagar(int id)
        {
            var post = _context.Posts.FirstOrDefault(x => x.Id == id);
            _context.Posts.Remove(post);
            await _context.SaveChangesAsync();
            return NoContent();


        }


    }
}
