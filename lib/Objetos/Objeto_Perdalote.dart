class SELECTPERDALOTE{

     int?      codigoid;
     int?      codigoloteproduto;
     double?   quantidade;
     List <String>? roles;

 
  SELECTPERDALOTE( this.codigoid, this.codigoloteproduto, this.quantidade );

  SELECTPERDALOTE.fromJson(Map<dynamic, dynamic> json){
    codigoid                  =json['codigoid'];
    codigoloteproduto         =json['codigoloteproduto'];
    quantidade                =json['quantidade'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> lotePerda = new Map<String, dynamic>();
    lotePerda['codigoid']            = this.codigoid.toString();
    lotePerda['codigoloteproduto']   = this.codigoloteproduto.toString();
    lotePerda['quantidade']          = this.quantidade.toString();   
    return lotePerda;
  }


}
