class LOTEPORCODIGO{
  int? codigoloteproduto;
  int? codigoempresa;
  int? es_codigo;
  String? descricaoloteproduto;
  double? quantidade;
  String? datafabricacaolote;
  String? datavalidadelote;
  List <String>? roles;

  LOTEPORCODIGO( this.codigoempresa);

  LOTEPORCODIGO.fromJson(Map<dynamic, dynamic> json){
    codigoloteproduto               =json['codigoloteproduto'];
    codigoempresa                   =json['codigoempresa'];
    es_codigo                       =json['es_codigo'];
    descricaoloteproduto            =json['descricaoloteproduto'];
    quantidade                      =json['quantidade'];
    datafabricacaolote              =json['datafabricacaolote'];
    datavalidadelote                =json['datavalidadelote'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> lote = new Map<String, dynamic>();
    lote['codigoloteproduto']             = this.codigoloteproduto.toString();
    lote['codigoempresa']                 = this.codigoempresa.toString();
    lote['es_codigo']                     = this.es_codigo.toString();
    lote['descricaoloteproduto']          = this.descricaoloteproduto;
    lote['quantidade']                    = this.quantidade.toString();;
    lote['datafabricacaolote']            = this.datafabricacaolote;
    lote['datavalidadelote']              = this.datavalidadelote;
   
    return lote;
  }


}
