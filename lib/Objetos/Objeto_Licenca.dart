class SELECTLICENCA{
     int?    codigoempresa;
     int?    codigoestacao;
     String? nomeestacaomobile;
     String? descricaomobile;
     String? numeroseriemobile;
     String? versaomobile;
     String? tokenmobile;
     List <String>? roles;

 
  SELECTLICENCA(this.tokenmobile);

  SELECTLICENCA.fromJson(Map<dynamic, dynamic> json){
    codigoempresa             =json['codigoempresa'];
    codigoestacao             =json['codigoestacao'];
    nomeestacaomobile         =json['nomeestacaomobile'];
    descricaomobile           =json['descricaomobile'];
    numeroseriemobile         =json['numeroseriemobile'];
    versaomobile              =json['versaomobile'];
    tokenmobile               =json['tokenmobile'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> licenca = new Map<String, dynamic>();
    licenca['codigoempresa']           = this.codigoempresa.toString();
    licenca['codigoestacao']           = this.codigoestacao.toString();
    licenca['nomeestacaomobile']       = this.nomeestacaomobile;
    licenca['descricaomobile']         = this.descricaomobile;
    licenca['numeroseriemobile']       = this.numeroseriemobile;
    licenca['versaomobile']            = this.versaomobile;
    licenca['tokenmobile']             = this.tokenmobile;
   
    return licenca;
  }


}
