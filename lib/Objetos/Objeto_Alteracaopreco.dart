class SELECTLOTEALTPRECO{
     int? codigoid;
     int? codigoempresa;
     int? codcaixa;
     int? codigomotivo;
     String? obs;
     int? codusuario;

      List <String>? roles;

  SELECTLOTEALTPRECO( this.codigoempresa);

  SELECTLOTEALTPRECO.fromJson(Map<dynamic, dynamic> json){
    codigoid                  =json['codigoid'];
    codigoempresa             =json['codigoempresa'];
    codcaixa                  =json['codcaixa'];
    codigomotivo              =json['codigomotivo'];
    obs                       =json['obs'];
    codusuario                =json['codusuario'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> lotealtpreco = new Map<String, dynamic>();
    lotealtpreco['codigoid']                = this.codigoid.toString();
    lotealtpreco['codigoempresa']           = this.codigoempresa.toString();
    lotealtpreco['codcaixa']                = this.codcaixa.toString();
    lotealtpreco['codigomotivo']            = this.codigomotivo.toString();
    lotealtpreco['obs']                     = this.obs;
    lotealtpreco['codusuario']              = this.codusuario.toString();;   
    return lotealtpreco;
  }


}
