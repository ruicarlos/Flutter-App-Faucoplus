class BALANCO{
     int?    codigobalanco;
     int?    codigoempresa;
     String? datainicio;
     List <String>? roles;

  BALANCO(this.codigoempresa);

  BALANCO.fromJson(Map<dynamic, dynamic> json){
    codigobalanco             =json['codigobalanco'];
    codigoempresa             =json['codigoempresa'];
    datainicio                =json['datainicio'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> balanco = new Map<String, dynamic>();
    balanco['codigobalanco']            = this.codigobalanco.toString();
    balanco['codigoempresa']            = this.codigoempresa.toString();
    balanco['datainicio']               = this.datainicio;

    return balanco;
  }


}
