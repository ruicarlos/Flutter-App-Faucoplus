class MOTIVOALTERACAOPRECO{
     int?    codigomotivo;
     String? descricaomotivo;
     List <String>? roles;

  MOTIVOALTERACAOPRECO(this.descricaomotivo);

  MOTIVOALTERACAOPRECO.fromJson(Map<dynamic, dynamic> json){
    codigomotivo          =json['codigomotivo'];
    descricaomotivo       =json['descricaomotivo'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> motivoalter = new Map<String, dynamic>();
    motivoalter['codigomotivo']          = this.codigomotivo.toString();
    motivoalter['descricaomotivo']       = this.descricaomotivo; 
    return motivoalter;
  }

  

}
