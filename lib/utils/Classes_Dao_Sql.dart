class TOKENPHONEDAO{
  int? id;
  String? token;
  List <String>? roles;
     
  TOKENPHONEDAO(this.id,this. token);

  TOKENPHONEDAO.fromJson(Map<String, dynamic> json){
    id                =json['id'];
    token             =json['token'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> tokenRetorno = new Map<String, dynamic>();
    tokenRetorno['id']            = this.id.toString();
    tokenRetorno['token']         = this.token;
   
    return tokenRetorno;
  }
}

class CONFIGPHONEDAO{
  int? id;
  String? tipoConexao;
  String? ipServidor;
  String? portaServidor;
  int? codigoIdLoja;
  List <String>? roles;
     
  CONFIGPHONEDAO(this.id,this.tipoConexao, this.ipServidor, this.portaServidor, this.codigoIdLoja);

  CONFIGPHONEDAO.fromJson(Map<String, dynamic> json){
    id                  =json['id'];
    tipoConexao         =json['tipoconexao'];
    ipServidor          =json['ipservidor'];
    portaServidor       =json['portaservidor'];
    codigoIdLoja        =json['codigoidloja'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> configRetorno = new Map<String, dynamic>();
    configRetorno['id']              = this.id.toString();
    configRetorno['tipoconexao']     = this.tipoConexao;
    configRetorno['ipservidor']      = this.ipServidor;
    configRetorno['portaservidor']   = this.portaServidor;
    configRetorno['codigoidloja']    = this.codigoIdLoja.toString();
   
    return configRetorno;
  }
}

class ETIQUETAITENSDAO{
  int? id;
  int? codigoid;
  int? quantidade;
  int? escodigo;
  double? precovenda;
  List <String>? roles;
     
  ETIQUETAITENSDAO(this.id, this. escodigo, this.codigoid, this.quantidade, this.precovenda);

  ETIQUETAITENSDAO.fromJson(Map<String, dynamic> json){
    id                  =json['id'];
    codigoid            =json['codigoid'];
    quantidade          =json['quantidade'];
    escodigo            =json['escodigo'];
    precovenda          =json['precovenda'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> etiquetaItensRetorno = new Map<String, dynamic>();
    etiquetaItensRetorno['id']            = this.id.toString();
    etiquetaItensRetorno['codigoid']      = this.codigoid.toString();
    etiquetaItensRetorno['quantidade']    = this.quantidade.toString();
    etiquetaItensRetorno['escodigo']      = this.escodigo.toString();
    etiquetaItensRetorno['precovenda']    = this.precovenda.toString();
   
    return etiquetaItensRetorno;
  }
}

class ALTERACAOITENSDAO{
  int? id;
  int? codigoid;
  double? precovenda;
  bool? promocao;
  List <String>? roles;
     
  ALTERACAOITENSDAO(this. codigoid);

  ALTERACAOITENSDAO.fromJson(Map<String, dynamic> json){
    id                  =json['id'];
    codigoid            =json['codigoid'];
    precovenda          =json['precovenda'];
    promocao            =json['promocao'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> alteracaoItensRetorno = new Map<String, dynamic>();
    alteracaoItensRetorno['id']            = this.id.toString();
    alteracaoItensRetorno['escodigo']      = this.codigoid.toString();
    alteracaoItensRetorno['precovenda']    = this.precovenda.toString();
    alteracaoItensRetorno['promocao']       = this.promocao.toString();
   
    return alteracaoItensRetorno;
  }
}

class ENTRADAITENSDAO{
  int? id;
  String? tokenmobile;
  int? escodigo;
  String? codigoean;
  double? quantidade;
  int? quantidadepecas;
  List <String>? roles;
     
  ENTRADAITENSDAO(this.id, this. tokenmobile, this.escodigo, this.codigoean, this.quantidade, this.quantidadepecas);

  ENTRADAITENSDAO.fromJson(Map<String, dynamic> json){
    id                      =json['id'];
    tokenmobile             =json['tokenmobile'];
    escodigo                =json['escodigo'];
    codigoean               =json['codigoean'];
    quantidade              =json['quantidade'];
    quantidadepecas         =json['quantidadepecas'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> entradaItensRetorno = new Map<String, dynamic>();
    entradaItensRetorno['id']                 = this.id.toString();
    entradaItensRetorno['tokenmobile']        = this.tokenmobile;
    entradaItensRetorno['escodigo']           = this.escodigo.toString();
    entradaItensRetorno['codigoean']          = this.codigoean;
    entradaItensRetorno['quantidade']         = this.quantidade.toString();
    entradaItensRetorno['quantidadepecas']    = this.quantidadepecas.toString();
   
    return entradaItensRetorno;
  }
}

class PERDASITENSDAO{
  int? id;
  int? codigoempresa;
  String? motivo;
  int? codigousuario;
  int? codigoid;
  int? escodigo;
  double? quantidade;
  double? quantidadedeposito;
  int? lote;
  int? serie;

  List <String>? roles;
     
  PERDASITENSDAO(this.id, this.codigoempresa, this.motivo, this.codigousuario, this.codigoid, this.escodigo, this.quantidade, this.quantidadedeposito, this.lote, this.serie );
PERDASITENSDAO.fromJson(Map<String, dynamic> json){
    id                      =json['id'];
    codigoempresa           =json['codigoempresa'];
    motivo                  =json['motivo'];
    codigousuario           =json['codigousuario'];
    codigoid                =json['codigoid'];
    escodigo                =json['escodigo'];
    quantidade              =json['quantidade'];
    quantidadedeposito      =json['quantidadedeposito'];
    lote                    =json['lote'];
    serie                   =json['serie'];

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> perdasItensRetorno = new Map<String, dynamic>();
    perdasItensRetorno['id']                    = this.id.toString();
    perdasItensRetorno['codigoempresa']         = this.codigoempresa.toString();
    perdasItensRetorno['motivo']                = this.motivo;
    perdasItensRetorno['codigousuario']         = this.codigousuario.toString();
    perdasItensRetorno['codigoid']              = this.codigoid.toString();
    perdasItensRetorno['escodigo']              = this.escodigo.toString();
    perdasItensRetorno['quantidade']            = this.quantidade.toString();
    perdasItensRetorno['quantidadedeposito']    = this.quantidadedeposito.toString();
    perdasItensRetorno['lote']                  = this.lote.toString();
    perdasItensRetorno['serie']                 = this.serie.toString();

   
    return perdasItensRetorno;
  }
}

class PERDASDAO{
  int? id;
  int? codigoid;
  int? codigoempresa;
  int? codigomotivo;
  String? obs;
  int? codigousuario;
  int? codcaixa;
  String? datasolitacao;


  List <String>? roles;
     
  PERDASDAO(this.codigoid, this.codigoempresa, this.codigomotivo, this.obs, 
  this.codigousuario, this.codcaixa, this.datasolitacao);
 // this.codigousuario, this.codcaixa);

  PERDASDAO.fromJson(Map<String, dynamic> json){
    id                      =json['id'];
    codigoid                =json['codigoid'];
    codigoempresa           =json['codigoempresa'];
    codigomotivo            =json['codigomotivo'];
    obs                     =json['obs'];
    codigousuario           =json['codigousuario'];
    codcaixa                =json['codcaixa'];
    datasolitacao           =json['datasolitacao'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> perdasRetorno = new Map<String, dynamic>();
    perdasRetorno['codigoid']               = this.codigoid.toString();
    perdasRetorno['codigoempresa']          = this.codigoempresa.toString();
    perdasRetorno['codigomotivo']           = this.codigomotivo.toString();
    perdasRetorno['obs']                    = this.obs;
    perdasRetorno['codigousuario']          = this.codigousuario.toString();
    perdasRetorno['codcaixa']               = this.codcaixa.toString();
    perdasRetorno['datasolitacao']        = this.datasolitacao;


   
    return perdasRetorno;
  }
}

class LOTESUGESTAODAO{
  int? id;
  int? codigoid;
  int? codigoempresa;
  int? codigomotivo;
  String? obs;
  int? codigousuario;
  int? codcaixa;
  String? datasolitacao;

  List <String>? roles;
     
  LOTESUGESTAODAO(this.codigoid, this.codigoempresa, this.codigomotivo, this.obs, this.codigousuario, this.codcaixa, this.datasolitacao);

  LOTESUGESTAODAO.fromJson(Map<String, dynamic> json){
    id                      =json['id'];
    codigoid                =json['codigoid'];
    codigoempresa           =json['codigoempresa'];
    codigomotivo            =json['codigomotivo'];
    obs                     =json['obs'];
    codigousuario           =json['codigousuario'];
    codcaixa                =json['codcaixa'];
    datasolitacao          =json['datasolitacao'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> loteSugestao = new Map<String, dynamic>();
    loteSugestao['id']                     = this.id.toString();
    loteSugestao['codigoid']               = this.codigoid.toString();
    loteSugestao['codigoempresa']          = this.codigoempresa.toString();
    loteSugestao['codigomotivo']           = this.codigomotivo.toString();
    loteSugestao['obs']                    = this.obs;
    loteSugestao['codigousuario']          = this.codigousuario.toString();
    loteSugestao['codcaixa']               = this.codcaixa.toString();
    loteSugestao['datasolitacao']          = this.datasolitacao;


   
    return loteSugestao;
  }
}

class BALANCODAO{
  int? id;
  int? codigobalanco;
  int? codcaixa;
  int? codigoempresa;
  int? escodigo;
  double? quantidade;
  double? quantidadedeposito;
  String? datasolicitacao;
  int? codigousuario;
  List <String>? roles;
     
  BALANCODAO(this.id, this.codigobalanco, this.codcaixa, this.codigoempresa, this.escodigo, this.quantidade, this.quantidadedeposito, this.datasolicitacao ,this.codigousuario);

  BALANCODAO.fromJson(Map<String, dynamic> json){
    id                        =json['id'];
    codigobalanco             =json['codigobalanco'];
    codcaixa                  =json['codcaixa'];
    codigoempresa             =json['codigoempresa'];
    escodigo                  =json['escodigo'];
    quantidade                =json['quantidade'];
    quantidadedeposito        =json['quantidadedeposito'];
    datasolicitacao           =json['datasolicitacao'];
    codigousuario             =json['codigousuario'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> balanco = new Map<String, dynamic>();
    balanco['id']                       = this.id.toString();
    balanco['codigobalanco']            = this.codigobalanco.toString();
    balanco['codigoempresa']            = this.codigoempresa.toString();
    balanco['codcaixa']                 = this.codcaixa.toString();
    balanco['escodigo']                 = this.escodigo.toString();
    balanco['quantidade']               = this.quantidade.toString();
    balanco['quantidadedeposito']       = this.quantidadedeposito.toString();
    balanco['datasolicitacao']            = this.datasolicitacao;
    balanco['codigousuario']            = this.codigousuario.toString();
    return balanco;
  }
}
