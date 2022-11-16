class USUARIOLOGIN{
     int?    codigousuario;
     int?    codigogrupousuario;
     String? nomeusuario;
     String? senha;

     List <String>? roles;

  USUARIOLOGIN(this.nomeusuario, this.senha);

  USUARIOLOGIN.fromJson(Map<dynamic, dynamic> json){
    codigousuario           =json['Codigousuario'];
    codigogrupousuario      =json['Codigogrupousuario'];
    nomeusuario             =json['Nomeusuario'];
    senha                   =json['senha'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> usuario = new Map<String, dynamic>();
    usuario['Codigousuario']          = this.codigousuario.toString();
    usuario['Codigogrupousuario']     = this.codigousuario;
    usuario['Nomeusuario']            = this.nomeusuario;
    usuario['Senha']                  = this.senha;
   
    return usuario;
  }

  

}
