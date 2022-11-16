
class SELECTPERDASERIE{

     int?      codigoid;
     int?      codigoserie;
     List <String>? roles;
 
  SELECTPERDASERIE( this.codigoid, this.codigoserie);

  SELECTPERDASERIE.fromJson(Map<dynamic, dynamic> json){
    codigoid                  =json['codigoid'];
    codigoserie               =json['codigoserie'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> serieperda = new Map<String, dynamic>();
    serieperda['codigoid']            = this.codigoid.toString();
    serieperda['codigoserie']         = this.codigoserie.toString();
    return serieperda;
  }


}
