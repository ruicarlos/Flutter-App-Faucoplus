class SELECTLOTEALTPRECOITENS{
     int? codigoid;
     int? es_codigo;
     double? precovenda;
     bool? promocao;    
     List <String>? roles;
 
  SELECTLOTEALTPRECOITENS( this.es_codigo);

  SELECTLOTEALTPRECOITENS.fromJson(Map<dynamic, dynamic> json){
    codigoid                  =json['codigoid'];
    es_codigo                 =json['es_codigo'];
    precovenda                =json['precovenda'];
    promocao                  =json['promocao'];

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> itensAlterados = new Map<String, dynamic>();
    itensAlterados['codigoid']                = this.codigoid.toString();
    itensAlterados['es_codigo']               = this.es_codigo.toString();
    itensAlterados['precovenda']              = this.precovenda.toString();
    itensAlterados['promocao']                = this.promocao.toString();

    return itensAlterados;
  }


}
