class MOTIVOPERDA{
     int?    codigomotivo;
     String? descricaomotivo;
     List <String>? roles;

  MOTIVOPERDA(this.descricaomotivo);

  MOTIVOPERDA.fromJson(Map<dynamic, dynamic> json){
    codigomotivo          =json['codigomotivo'];
    descricaomotivo       =json['descricaomotivo'];
  }

  Map<dynamic, dynamic> toJson(){
    final Map<dynamic, dynamic> motivoperd = new Map<dynamic, dynamic>();
    motivoperd['codigomotivo']          = this.codigomotivo.toString();
    motivoperd['descricaomotivo']     = this.descricaomotivo;
  
    return motivoperd;
  }

  

}
