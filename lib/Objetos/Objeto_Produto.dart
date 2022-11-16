class PRODUTOPORCODBARRAS{
  int?     id_Loja;		
  String?  departamento;
  String?  categoria;		
  String?  subcategoria;      
  String?  marca;
  String?  unidade; 
  double?  volume; 
  String?  codigo_barra; 
  String?  nome; 
  String?  dt_cadastro;
  String?  dt_ultima_alteracao;
  double?  vlr_produto; 
  double?  vlr_promocao; 
  double?  qtd_estoque_atual; 
  double?  qtd_estoque_minimo; 
  String?  descricao;
  String?  ativo; 
  int?    plu; 
  double?  vlr_compra; 
  String?  validade_proxima;
  double?  vlr_atacado;
  double?  qtd_atacado; 
  String?  image_url; 
  bool?     controlelote;
  bool?     controlenumserie;
  List <String>? roles;

 
  PRODUTOPORCODBARRAS(this.codigo_barra);

  PRODUTOPORCODBARRAS.fromJson(Map<dynamic, dynamic> json){
    id_Loja                 =json['Id_Loja'];
    departamento            =json['Departamento'];
    categoria               =json['Categoria'];
    subcategoria            =json['Subcategoria'];
    marca                   =json['Marca'];
    unidade                 =json['Unidade'];
    volume                  =json['Volume'];
    codigo_barra            =json['codigo_barra'];
    nome                    =json['Nome'];
    dt_cadastro             =json['dt_cadastro'];
    dt_ultima_alteracao     =json['dt_ultima_alteracao'];
    vlr_produto             =json['vlr_produto'];
    vlr_promocao            =json['vlr_promocao'];
    qtd_estoque_atual       =json['qtd_estoque_atual'];
    qtd_estoque_minimo      =json['qtd_estoque_minimo'];
    descricao               =json['Descricao'];
    ativo                   =json['ativo'];
    plu                     =json['plu'];
    vlr_compra              =json['vlr_compra'];
    validade_proxima        =json['validade_proxima'];
    vlr_atacado             =json['vlr_atacado'];
    qtd_atacado             =json['qtd_atacado'];
    image_url               =json['image_url'];
    controlelote            =json['controlelote'];
    controlenumserie        =json['controlanumeroserie'];

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> produto = new Map<String, dynamic>();
    produto['Id_Loja']              = this.id_Loja.toString();
    produto['Departamento']         = this.departamento;
    produto['Categoria']            = this.categoria;
    produto['Subcategoria']         = this.subcategoria;
    produto['Marca']                = this.marca;
    produto['Unidade']              = this.unidade;
    produto['Volume']               = this.volume.toString();
    produto['codigo_barra']         = this.codigo_barra;
    produto['Nome']                 = this.nome;
    produto['dt_cadastro']          = this.dt_cadastro;
    produto['dt_ultima_alteracao']  = this.dt_ultima_alteracao;
    produto['vlr_produto']          = this.vlr_produto.toString();
    produto['vlr_promocao']         = this.vlr_produto.toString();
    produto['qtd_estoque_atual']    = this.qtd_estoque_atual.toString();
    produto['qtd_estoque_minimo']   = this.qtd_estoque_minimo.toString();
    produto['Descricao']            = this.descricao;
    produto['ativo']                = this.ativo;
    produto['plu']                  = this.plu.toString();
    produto['vlr_compra']           = this.vlr_compra.toString();
    produto['validade_proxima']     = this.validade_proxima;
    produto['vlr_atacado']          = this.vlr_atacado.toString();
    produto['qtd_atacado']          = this.qtd_atacado.toString();
    produto['controlelote']         = this.controlelote.toString();
    produto['controlanumeroserie']     = this.controlenumserie.toString();
   
    return produto;
  } 

}


class PRODUTOPORDESCRICAO{
  int?     id_Loja;		
  String?  departamento;
  String?  categoria;		
  String?  subcategoria;      
  String?  marca;
  String?  unidade; 
  double?  volume; 
  String?  codigo_barra; 
  String?  nome; 
  String?  dt_cadastro;
  String?  dt_ultima_alteracao;
  double?  vlr_produto; 
  double?  vlr_promocao; 
  double?  qtd_estoque_atual; 
  double?  qtd_estoque_minimo; 
  String?  descricao;
  String?  ativo; 
  int?     plu; 
  double?  vlr_compra; 
  String?  validade_proxima;
  double?  vlr_atacado;
  double?  qtd_atacado; 
  String?  image_url; 
  bool?     controlelote;
  bool?     controlenumserie;
  List <String>? roles;
 
  PRODUTOPORDESCRICAO(this.nome);

  PRODUTOPORDESCRICAO.fromJson(Map<dynamic, dynamic> json){
    id_Loja                 =json['id_Loja'];
    departamento            =json['departamento'];
    categoria               =json['categoria'];
    subcategoria            =json['subcategoria'];
    marca                   =json['marca'];
    unidade                 =json['unidade'];
    volume                  =json['volume'];
    codigo_barra            =json['codigo_barra'];
    nome                    =json['nome'];
    dt_cadastro             =json['dt_cadastro'];
    dt_ultima_alteracao     =json['dt_ultima_alteracao'];
    vlr_produto             =json['vlr_produto'];
    vlr_promocao            =json['vlr_promocao'];
    qtd_estoque_atual       =json['qtd_estoque_atual'];
    qtd_estoque_minimo      =json['qtd_estoque_minimo'];
    descricao               =json['descricao'];
    ativo                   =json['ativo'];
    plu                     =json['plu'];
    vlr_compra              =json['vlr_compra'];
    validade_proxima        =json['validade_proxima'];
    vlr_atacado             =json['vlr_atacado'];
    qtd_atacado             =json['qtd_atacado'];
    image_url               =json['image_url'];
    controlelote            =json['controlelote'];
    controlenumserie        =json['controlanumeroserie'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> produto = new Map<String, dynamic>();
    produto['id_Loja']              = this.id_Loja.toString();
    produto['departamento']         = this.departamento;
    produto['categoria']            = this.categoria;
    produto['subcategoria']         = this.subcategoria;
    produto['marca']                = this.marca;
    produto['unidade']              = this.unidade;
    produto['volume']               = this.volume.toString();
    produto['codigo_barra']         = this.codigo_barra;
    produto['nome']                 = this.nome;
    produto['dt_cadastro']          = this.dt_cadastro;
    produto['dt_ultima_alteracao']  = this.dt_ultima_alteracao;
    produto['vlr_produto']          = this.vlr_produto.toString();
    produto['vlr_promocao']         = this.vlr_produto.toString();
    produto['qtd_estoque_atual']    = this.qtd_estoque_atual.toString();
    produto['qtd_estoque_minimo']   = this.qtd_estoque_minimo.toString();
    produto['descricao']            = this.descricao;
    produto['ativo']                = this.ativo;
    produto['plu']                  = this.plu.toString();
    produto['vlr_compra']           = this.vlr_compra.toString();
    produto['validade_proxima']     = this.validade_proxima;
    produto['vlr_atacado']          = this.vlr_atacado.toString();
    produto['qtd_atacado']          = this.qtd_atacado.toString();
    produto['image_url']            = this.image_url;
    produto['controlelote']         = this.controlelote.toString();
    produto['controlanumeroserie']     = this.controlenumserie.toString();
   
    return produto;
  }

}
