# Rede social flutter

Projeto de rede social onde é possivel cadastrar e logar usuarios
Criar,Editar e Excluir postagens

Projeto criado por mim desde o zero


TELAS: 


HOME - 

Consome rota "/v1/users/Cadastrar" Onde enviar os dados que o usuario digitou, caso algum campo esteja vazia o cadastro não acontece e é avisado na tela para o usuario
apos o Cadastro do usuario ele podera efetuar o login 

TELALOGIN -

Consome rota "/v1/users/Logar" onde é passado pelo usuario seu Email e senha, a api valida os dados retornando se houver algum problema e o flutter mostra na tela para o usuario
caso retorne status 200 + token jwt o usuario é logado

TELAUSER -

Tela do usuario onde vamos ter 2 botões 
Botao feed - navegação para a tela de feed
Botao meus posts - navegação para a tela de posts do usuario, onde é passado para a proxima tela seu email

TELAFEED -
consome rota "/v1/posts/PostsAll" 
onde é retornado pela api uma lista com todos os posts no banco de dados
o flutter usa um futurebuilder + listview + listtitle e mostra os posts com titulo, conteudo e o usuario que postou

TELAMEUSPOSTS -

Consome rota - /v1/posts/PostsUser/{email}" onde é retornando uma lista com os posts do mesmo email do usuaraio
ao clicar em um item dessa lista é aberto um Dialog com 2 botões
Botao Excluir - é passado o Id para a api em uma rota com o verbo http delete e o post será excluido

TELACADASTRARPOST - 

Envia para a api um CreatePostDTO + emailUser onde sera gravado seu novo post
qualquer erro sera apresentado para o usuario em tela

