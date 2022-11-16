class ETIQUETA{
     int?    codigoid;
     int?    es_codigo;
     int?    quantidadeetiqueta;
     double? precovenda;
     String? codigoean;

     List <String>? roles;

  ETIQUETA(this.codigoid, this.es_codigo, this.precovenda);

  ETIQUETA.fromJson(Map<dynamic, dynamic> json){
    codigoid               =json['codigoid'];
    es_codigo              =json['es_codigo'];
    quantidadeetiqueta     =json['quantidadeetiqueta'];
    precovenda             =json['precovenda'];
    codigoean              =json['codigoean'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> etiqueta = new Map<String, dynamic>();
    etiqueta['codigoid']             = this.codigoid.toString();
    etiqueta['es_codigo']            = this.es_codigo.toString();
    etiqueta['quantidadeetiqueta']   = this.quantidadeetiqueta.toString();
    etiqueta['precovenda']           = this.precovenda.toString();
    etiqueta['codigoean']            = this.codigoean;
   
    return etiqueta;
  }


}
