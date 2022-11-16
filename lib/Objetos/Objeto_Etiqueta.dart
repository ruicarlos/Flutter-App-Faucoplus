class ETIQUETALOTE{
     int?    codigoid;
     int?    codigoempresa;
     int?    codigousuario;
     int?    codcaixa;
    // String? usuarioprocessamento;
     List <String>? roles;

  //ETIQUETALOTE( this.codigoempresa, this.codigousuario, this.codcaixa ,this.usuarioprocessamento);
  ETIQUETALOTE( this.codigoempresa, this.codigousuario, this.codcaixa );

  ETIQUETALOTE.fromJson(Map<dynamic, dynamic> json){
    codigoid               =json['codigoid'];
    codigoempresa          =json['codigoempresa'];
    codigousuario          =json['codigousuario'];
    codcaixa               =json['codcaixa'];
  //  usuarioprocessamento   =json['usuarioprocessamento'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> novolote = new Map<String, dynamic>();
    novolote['codigoid']              = this.codigoempresa.toString();
    novolote['codigoempresa']         = this.codigoempresa.toString();
    novolote['codigousuario']         = this.codigousuario.toString();
    novolote['codcaixa']              = this.codcaixa.toString();
   // novolote['usuarioprocessamento']  = this.usuarioprocessamento;
   
    return novolote;
  }


}
