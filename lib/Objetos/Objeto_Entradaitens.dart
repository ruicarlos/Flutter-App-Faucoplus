class SELECTENTRADAITENS{
     String?   tokenmobile;
     int?      es_codigo;
     String?   codigoean;
     int?      quantidadepecas;
     double?   quantidade;
     List <String>? roles;

  SELECTENTRADAITENS( this.tokenmobile, this.es_codigo, this.codigoean ,this.quantidadepecas, this.quantidade);

  SELECTENTRADAITENS.fromJson(Map<dynamic, dynamic> json){
    tokenmobile               =json['tokenmobile'];
    es_codigo                 =json['es_codigo'];
    codigoean                 =json['codigoean'];
    quantidadepecas           =json['quantidadepecas'];
    quantidade                =json['quantidade'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> entrada = new Map<String, dynamic>();
    entrada['tokenmobile']            = this.tokenmobile;
    entrada['es_codigo']              = this.es_codigo.toString();
    entrada['codigoean']              = this.codigoean;
    entrada['quantidadepecas']        = this.quantidadepecas.toString();
    entrada['quantidade']             = this.quantidade.toString();
   
    return entrada;
  }


}
