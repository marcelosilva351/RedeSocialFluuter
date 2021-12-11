class postModel {
  int Id;
  String Titulo;
  String Conteudo;
  int UserId;
  String UserName;
  postModel(this.Id, this.Titulo, this.Conteudo,  this.UserName);

  factory postModel.fromJson(Map json){
    return postModel(json['id'], json['titulo'], json['conteudo'], json['userName']);
  }


  Map toJson(){
    return {
      "titulo" : Titulo,
      "conteudo" : Conteudo,
      "userId" : UserId
    };
  }


}
