class TOKENENTRAMERC{

  String? tokenmobile;
  String? data;
  String? fornecedor;
  List <String>? roles;

  TOKENENTRAMERC(this.tokenmobile);

  TOKENENTRAMERC.fromJson(Map<dynamic, dynamic> json){
    tokenmobile               =json['tokenmobile'];
    data                      =json['data'];
    fornecedor                =json['fornecedor'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> tokenEntr = new Map<String, dynamic>();
    tokenEntr['tokenmobile']              = this.tokenmobile;
    tokenEntr['data']                     = this.data;
    tokenEntr['fornecedor']               = this.fornecedor;
   
    return tokenEntr;
  }


}
