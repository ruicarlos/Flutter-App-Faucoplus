import 'package:flutter/material.dart';

//### VALORES MUTÁVEIS  
String tipoConexao    ='http://';  //'http://';
String ipServidor     ='';  //'192.168.100.10';
String portaServidor  ='8080';  //'8080';
int codigoIdLoja      = 1;
String versaoApp      ='2.3';


// LINK/ROTAS DE API 
String apiHost                                          = tipoConexao+ipServidor+':'+portaServidor;
String apiProdutoporcodbarras                           = '/api/produtos/individual/porcodbarra/';                         //{Codbarra}/
String apiListaProdutopornomeeIdloja                    = '/api/produtos/lista/pornomeeidloja/';                           //{Nome}/{Id_Loja}
String apiListaProdutoporDeparteIdloja                  = '/api/produtos/lista/pordepartamentoeidloja';                    //{Departamento}/{Id_Loja}
String apiListaProdutoporDepartCategeIdloja             = '/api/produtos/lista/pordepartamentocategoriaidloja/';           //{Departamento}/{Categoria}/{Id_Loja}
String apiListaProdutoporDepartCatgSubceIdLoja          = '/api/produtos/lista/porDepCatSubcatIdloja/';                    //{Departamento}/{Categoria}/{Subcategoria}/{Id_Loja}
String apiListaProdutoporDepartCategSubcaMareIdloja     = '/api/produtos/lista/porDepCatSubcatMarcIdloja/';                //{Departamento}/{Categoria}/{Subcategoria}/{Marca}/{Id_Loja}
String apiListaProdutosporQtdemEstoque                  = '/api/produtos/lista/porQtdEstoque/';                            //{qtd_estoque_atual}/{Id_Loja}
String apiListaGrupoUsuariotodos                        = '/api/grupousuarios/lista/todos';
String apiGrupoUsuarioporCodigogrupo                    = '/api/grupousuarios/individual/porcodigo/';                      //{codigogrupousuario}
String apiGrupoUsuarioporNomegrupo                      = '/api/grupousuarios/individual/pornomeusuario/';                 //{nomegrupo}
String apiListaUsuarios                                 = '/api/usuarios/lista/todos';
String apiUsuarioporCodigo                              = '/api/usuarios/individual/porcodigo/';                            //{codigosuario}
String apiUsuarioporNomeusuario                         = '/api/usuarios/individual/pornomeusuario/';                       //{nomeusuario}
String apiUsuarioporNomeUsuarioeSenha                   = '/api/usuarios/individual/pornomeusuarioesenha/';                 //{nomeusuario}/{senha}';
String apiListaLicenca                                  = '/api/licenca/lista/todos';
String apiLicencaporToken                               = '/api/licenca/individual/portoken/';                              //{portoken}
String apiLicencaporCodigoestacao                       = '/api/licenca/individual/porcodigoestacao/';                      //{codigoestacao}';
String apiLicencaporNomeEstacao                         = '/api/licenca/individual/pornomeestacao/';                        //{nomeestacaomobile}';
String apiEtiquetaPost                                  = '/api/etiqueta/Imprimir/individual';                              //Post de etiqueta
String apiEtiquetaRegistraLotePost                      = '/api/etiqueta/lote/registrar';                                   //Post de Lote de Etiqueta
String apiConsultUltLoteEtiq                            = '/api/etiqueta/ultimolote';                                       //Get Ult Lote de Etiqueta
String apiPerdasItensPost                               = '/api/perdasitens/salvar';                                        //Post
String apiPerdasLotePost                                = '/api/perdasLote/registro';                                        //Post
String apiSugestaoPrecoPost                             = '/api/sugestaoPreco/salvar';                                      //Post
String apiMotivoPerdaTodos                              = '/api/motivoperda/lista';                                         //Get Listar todas opções
String apiEntradaloteTodos                              = '/api/entradaLote/lista';                                         //Get                   
String apiEntradaloteporEscodigo                        = '/api/entradaLote/loteporescodigo/';                              //{escodigo}                   
String apiEntradalotePost                               = '/api/entradalote/salvar';                                        //Post salvar Lote
String apiEntradaitensPost                              = '/api/entradaitens/salvar';                                        //Post salvar itens da entrada
String apiEntradaSerieTodos                             = '/api/entradaSerie/lista';                                        //Todos os Numeros de Series
String apiEntradaSerieporEscodigo                       = '/api/entradaSerie/serieporescodigo/';                            //{escodigo}'                                   
String apiEntradaSerieporNumSerie                       = '/api/entradaSerie/serieporNumeroserie/';                         //{Numeroserie}                                   
String apiEntradaSeriePost                              = '/api/entradaserie/salvar';                                       //Post                                   
String apiLoteporCodigo                                 = '/api/estoquelote/loteporcodigo/';                                 //{codigoloteproduto}                                 
String apiSerieporCodigo                                = '/api/estoqueserie/serieporcodigo/';                              //{codigoserie}                                  
String apiSugestaoPrecoLotePost                         = '/api/sugestao/lote/registrar';                                   //Post loteAltPreço                                  
String apimotivosparaaltepreco                          = '/api/motivosAltePreco/todos';                                    //Get Lista                                  
String apiParametros                                    = '/api/parametros/porEmpresa/';                                    //{codigoEmpresa}                                  
String apiEntradaMercValidToken                         = '/api/entradaMerc/validarToken/';                                 //{TokenEntrada}    
String apiBalancoAtivo                                  = '/api/balanco/balancoativo/';                                     //get ultimo Balanco    
String apiBalancoAtivoporEmpresa                        = '/api/balanco/balancoporempresa/';                                //{codigoempresa}  
String apiBalancoContagemPost                           = '/api/balancoItens/salvar/';                                      //Post  


//********************************************************************* VARIAVEIS DE USO GERAL ******************************************************************************
int countIndex =0;
String origemClique='';
String pesquisaProdutoDigitado='';
String modo='scan';
String envioEtiquetaPende='N';
String envioPerdaPende='N';
String envioSugestPende='N';
String envioEntradPende='N';
int qtdEtiquetasaImp= 1;
String? usuarioRecebido, senhaRecebida, codbarraRecebido, qtdEtiquetasaImp_Str, precoSugerido_Str = '';
double precoSugerido= 0.0;
double qtdPerdas= 0.0;
String qtdPerdas_STR= '0';
bool loteEtiquetasStatus200 = false;
bool lotePerdasStatus200 = false;
bool EntradasItemStatus200 = false;
bool loteBalancoStatus200 = false;
DateTime? dt_inicioPromocao;
DateTime? dt_fimPromocao;
String  varGdatahoje='';

// Balanço
var vargInvemaberto       =false;
var vargInvcodbalanco     =0;
var vargInvquantLoja      =0.0;
var vargInvquantDeposito  =0.0;

// Entrada de Mercadoria 
var vargTokenEntMerc          ='';
var vargTokenEntMercDigitado  ='';
var vargTokenEntradaValido    = false;
var vargEntMercQuant          =0.0;
var vargEntMercQuantpeca      =0;


// Parametros
int    varGControleqtdDeposito = 0;
var varempresaContro          = null;
var varControContro           = null;

// Controle de Requisições
int retornoLoteSugestao = 0;



// Motivo Alterar Preco

  var varGmotivCodigomotiv                =0;
  var varGmotivDescricaomotiv             ='';
  var varGmotivInativo                    =false;

// Sugestão Lote
  var varGSugPreLote                      =0;
  var varGSugPreObs                       ='';
  var varGSugPreCodMotiv                  =0;
  var varGSugPreDescMotiv                 ='';
  var varGSugPreBTPromoAtivo              = false;

  String varGSugDtInicioPromo='';
  String varGSugDtFimPromo='';

// Estoque Lote

  var varGEstLotecodigoloteproduto        =0;
  var varGEstLotecodigoempresa            =0;
  var varGEstLotees_codigo                =0;
  var varGEstLotedescricaoloteproduto     ='';
  var varGEstLotequantidade               =0.0;
  var varGEstLotedatafabricacao           ='';
  var varGEstLotedatavalidadelote         ='';

// Estoque Serie Variaveis Gerais

  var varGEstSeriecodigoempresa          =0;
  var varGEstSeriecodigoserie             =0;
  var varGEstSeriees_codigo               =0;
  var varGEstSerienumeroserie             ='';

// lote perda
int?      varGcodigoempresa;
int?      varGcodigomotivo;
String?   varGobs = ' ';
int?      varGcodcaixa;
String?   varGdatasolicitacao;
int?      varGLotePerdacodigoid;

// PERDA ITEM
String EstoquedeOrigem = '';


// Motivo de perda

int varGCodigomotivo =0;
String varGdescricaomotivo ='';

// Usuario recebido do Get Usuario do Main.dart
  String    varGUsuario               ='';
  String    varGsenhaAcesso           ='';
  int       varGcodigogrupo           =0;
  int       varGcodigousuario         =0;


// Requisições de Produtos (Setar  Produto)
  var varG_id_Loja              = 1;	
  var varG_departamento         = null;
  var varG_categoria            = null;		
  var varG_subcategoria         = null;      
  var varG_marca                = null;
  var varG_unidade              = null; 
  var varG_volume               = 0.0;
  var varG_codigo_barra         = null; 
  var varG_nome                 = null;
  var varG_dt_cadastro          = null;
  var varG_dt_ultima_alteracao  = null;
  var varG_vlr_produto          = 0.0; 
  var varG_vlr_promocao         = 0.0; 
  var varG_qtd_estoque_atual    = 0.0;
  var varG_qtd_estoque_minimo   = 0.0;
  var varG_descricao            = null;
  var varG_ativo                = null; 
  var varG_plu                  = 0; 
  var varG_vlr_compra           =0.0; 
  var varG_validade_proxima     = null;
  var varG_vlr_atacado          = 0.0;
  var varG_qtd_atacado          = 0.0;
  var varG_image_url            = null;
  var varGcontrolelote          = false;
  var varGcontrolenumSerie      = false;
  var varGperdaNumloteInformado = null;
  var varGperdaNumSerieInformado = null;
  bool produtoPorCodbarra = false;


// Lote e Etiquetas
  int     varGLOTEcodigoid              = 0;
  int     varGLOTEcodigousuario         = 0;
  int     varGLOTEcodigoempresa         = 0;
  int     varGLOTEcodcaixa              = 0;
  String  varGLOTEusuarioprocessamento  ='';
  bool    varGLoteRegistrou             =false;

  // Licença Mobile
  //o numero de serie é o EMEI <= isso na versão 1 do APP
  //o numero de serie é o MAC
  String varGemeidoAparelho             = '';
  String tokenmobilenoAparelho          = '';
  String tokenmobilenoServidor          = '';
  int    varGcodigoestacao              = 0;
  String varGnomeestacaomobile          = '';
  String varGdescricaomobile            = '';     
  String varGnumeroseriemobile          = '';
  String varGversaomobile               = '';
  String varGtokenmobile                = '';

// ************************************************* STYLE *****************************************************



final kHintTextStyle = TextStyle(
 // color: Color(0xFFA4CE46),
  color: Colors.white,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  //color: Color(0xFF28353d),
  color: Colors.black54,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);


// p
final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);


Image btConsulta    = Image.asset('assets/imagens/butoes/BtConsulta.png',);
Image btEntrada     = Image.asset('assets/imagens/butoes/BtEntrada.png',);
Image btImpressao   = Image.asset('assets/imagens/butoes/BtImpressao.png',);
Image btInventario  = Image.asset('assets/imagens/butoes/BtInventario.png',);
Image btLancamento  = Image.asset('assets/imagens/butoes/BtLancamento.png',);
Image btSair        = Image.asset('assets/imagens/butoes/BtSair.png');
Image btBtSugestao  = Image.asset('assets/imagens/butoes/BtSugestao.png',);


Color corIcones         =  Color(0xFF26F75);
Color corDegradeeInicio =  Color(0xFF35E3C0);
Color corDegradeeFim    =  Color(0xFF007C82);

BoxDecoration fundoDegradee = 
BoxDecoration(
                    gradient:LinearGradient(
  begin: Alignment.topCenter,
    colors:[
      corDegradeeInicio,
      corDegradeeFim,
    ],
  end: Alignment.bottomCenter,
));

var larguradaTela,alturaTela;