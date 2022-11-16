class SERIEPORCODIGO{
  int? codigoempresa;
  int? codigoserie;
  int? es_codigo;
  String? numeroserie;
  List <String>? roles;

  SERIEPORCODIGO( this.codigoempresa);

  SERIEPORCODIGO.fromJson(Map<dynamic, dynamic> json){
    codigoempresa                 =json['codigoempresa'];
    codigoserie                   =json['codigoserie'];
    es_codigo                     =json['es_codigo'];
    numeroserie                   =json['numeroserie'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> serie = new Map<String, dynamic>();
    serie['codigoempresa']              = this.codigoempresa.toString();
    serie['codigoserie']                = this.codigoserie.toString();
    serie['es_codigo']                  = this.es_codigo.toString();
    serie['numeroserie']                = this.numeroserie;
   
    return serie;
  }


}
