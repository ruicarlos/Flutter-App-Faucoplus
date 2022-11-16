class SELECTPERDASLOTE{
     int?      codigoempresa;
     int?      codigomotivo;
     String?   obs;
     int?      codigousuario;
     int?      codcaixa;
    // String?   datasolitacao;

     List <String>? roles;

  SELECTPERDASLOTE( this.obs);

  SELECTPERDASLOTE.fromJson(Map<dynamic, dynamic> json){
    codigoempresa               =json['codigoempresa'];
    codigomotivo                =json['codigomotivo'];
    obs                         =json['obs'];
    codigousuario               =json['codigousuario'];
    codcaixa                    =json['codcaixa'];
   // datasolitacao               =json['datasolitacao'];

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> lotedeperda = new Map<String, dynamic>();
    lotedeperda['codigoempresa']              = this.codigoempresa.toString();
    lotedeperda['codigomotivo']               = this.codigomotivo.toString();
    lotedeperda['obs']                        = this.obs;
    lotedeperda['codigousuario']              = this.codigousuario.toString();
    lotedeperda['codcaixa']                   = this.codcaixa.toString();
  //  lotedeperda['datasolitacao']              = this.datasolitacao;
  
    return lotedeperda;
  }


}
