class SELECTPARAMETROS{

     int?      codigoempresa;
     bool?     controlaquantidadedeposito;
     List <String>? roles;


  SELECTPARAMETROS( this.codigoempresa);

  SELECTPARAMETROS.fromJson(Map<dynamic, dynamic> json){
    codigoempresa                  =json['codigoempresa'];
    controlaquantidadedeposito     =json['controlaquantidadedeposito'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> parametroControle = new Map<String, dynamic>();

    parametroControle['codigoempresa']                = this.codigoempresa.toString();
    parametroControle['controlaquantidadedeposito']   = this.controlaquantidadedeposito;
    return parametroControle;
  }


}
