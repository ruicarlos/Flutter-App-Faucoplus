import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:faucomplus/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/Objetos/Objeto_BalancoAtivo.dart';
import 'package:faucomplus/Views/Balanco.dart';
import 'package:faucomplus/Views/BalancoCControle.dart';
import 'package:faucomplus/objetos/Objeto_Etiqueta.dart';
import 'package:faucomplus/objetos/Objeto_EtiquetaItens.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/Requisicoes.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/utils/dbDao.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'leitor.dart';

var jsontoMapLote;
var jsontoMapMotivoPerda;

String fcmtoken = '';
int? numdeEtiqItensCadastrados = 0;
int? numdeItensdaEntradaCadastrados = 0;
int? numdeLoteSugestCadastrados = 0;
int numdeLotePerdaCadastrados = 0;
int? numdPerdasCadastradas = 0;
int? numdItemBalancoCadastradas = 0;

int deleteListaEtiqueta = 0;
int deleteListaPerdasItens = 0;
int deleteListaEntradaItens = 0;
int deleteLoteSugestao = 0;
int deleteAltItens = 0;
int deletePerdas = 0;
int deleteBalanco = 0;
int deleteEntItens = 0;
int idUltEtiqItens = 0;

int selectMaxEtiqItensnoDb = 0;
int selectMaxEntraItensnoDb = 0;
int selectMaxLotePerdasnoDb = 0;
int selectMaxPerdasItensnoDb = 0;
int selectMaxLoteSugestaonoDb = 0;

final etiquetaItensRecebido = SQLETIQUETAITENSDAO();
String txtEnvioPendente = '';

class Principal extends StatefulWidget {
  Principal({Key? key}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
 // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';

  @override
  void initState() {
    if (modoDemo){
      modo = 'Digitado';
    }else{
      modo = 'scan';
    }
    
    super.initState();
  }

  Future<bool> _onbackPressed()async {
    return( await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => AlertDialog(
        title: Text(
          'Deseja sair do Aplicativo?',
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Não',
                style: TextStyle(
                    color: Color(0xFF3a8e74),
                    fontSize: 20,
                    fontFamily: 'Pacifico')),
          ),
          FlatButton(
           // onPressed: () => SystemNavigator.pop(),
           onPressed:() { Navigator.pushReplacementNamed(context, 'login');},
            child: Text('Sim',
                style: TextStyle(
                    color: Colors.red, fontSize: 20, fontFamily: 'Pacifico')),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    WillPopScope(
      onWillPop: _onbackPressed,
      child: 
      
      Scaffold(
        backgroundColor: Color(0xFF3a8e74),
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Color(0xFF3a8e74),
          title: Image.asset(
            'assets/logo.png',
            height: 70,
            width: 100,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                  icon: _tipoEntrada(),
                  onPressed: () {
                    setState(() {
                      if (modo == 'scan') {
                        modo = 'key';
                        Fluttertoast.showToast(
                            msg: 'Modo Digitado Ativado',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                             
                            backgroundColor: Colors.lightBlue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        modo = 'scan';
                        Fluttertoast.showToast(
                            msg: 'Modo Scanner Ativado',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                             
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 5),
              child: IconButton(
                  icon: _envioPendenteIcon(),
                  onPressed: () {
                    setState(() {
                      _processarVerificacaodeLotePendentesComAlerta();
                    });
                  }),
            ),
          ],
        ),
        drawer: _drawDev(context),
        body: _newBody(),
      ),
    );
  }

  _tipoEntrada() {
    if (modo == 'scan') {
      return Icon(
        Icons.document_scanner,
        size: 40,
        color: Colors.white,
      );
    } else {
      return Icon(
        Icons.keyboard,
        size: 40,
        color: Colors.white,
      );
    }
  }

  _newBody() {
    return Container(
        padding: EdgeInsets.only(
            left: 10, right: 10, bottom: 60, top: alturaTela * 0.2),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20.0, left: 5, right: 5, bottom: 10),
            child: GridView(
                children: [
                  InkWell(
                    child: Container(
                      child: Card(
                          child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: btConsulta,
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text(
                                  "Consultar Produto",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                        ],
                      )),
                    ),
                    onTap: () {
                      _processarVerificacaodeLotePendentes();
                      origemClique = 'consultaitem';
                      pesquisaProdutoDigitado = '';
                      produtoPorCodbarra = false;
                      if (modo == 'scan') {
                        LercodigodeBarras().escanearCodigodeBarras(context);
                      } else {
                        Navigator.pushNamed(context, 'PesquisaDigi');            
                      }
                    },
                  ),


                  InkWell(
                    child: Container(
                      child: Card(
                          child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: btImpressao,
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text(
                                  "Impressão de Etiqueta",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                        ],
                      )),
                    ),
                    onTap: () async { 
                     // mensagemEmDev();
                      // Comentado para cliente
                      

                      _processarVerificacaodeLotePendentes();
                      
                      pesquisaProdutoDigitado = '';
                      produtoPorCodbarra = false;
                      preImpressaoEtiquetas();
                      
                      varG_plu =0;

                      if (modo == 'scan') {
                        LercodigodeBarras().escanearCodigodeBarras(context);
                      } else {
                        Navigator.pushNamed(context, 'PesquisaDigi');
                      }; 
                    },
                  ),

                  
                  InkWell(
                    child: Container(
                      child: Card(
                          child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: btBtSugestao,
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text(
                                  "Sugestão de Preço",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                        ],
                      )),
                    ),
                    onTap: () async {

                     // mensagemEmDev();
                      
                      _processarVerificacaodeLotePendentes();
                      if (envioSugestPende == 'N') {
                        Navigator.pushNamed(context, 'ListMotAlt');
                      } else {
                        origemClique = 'sugestaopreco';
                        pesquisaProdutoDigitado = '';
                        if (modo == 'scan') {
                          LercodigodeBarras().escanearCodigodeBarras(context);
                        } else {
                          Navigator.pushNamed(
                              context, 'PesquisaDigi');
                        }
                      } 
                      
                    },
                  ),
                  InkWell(
                      child: Container(
                        child: Card(
                            child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: btInventario,
                            ),
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Text(
                                    "Inventário de Mercadoria",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ))
                          ],
                        )),
                      ),
                      onTap: () async {
                     //   mensagemEmDev();
                        
                        _processarVerificacaodeLotePendentes();
                        preInventario(); 
                      }),
                  InkWell(
                    child: Container(
                      child: Card(
                          child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: btLancamento,
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text(
                                  "Lançamento de Perdas",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                        ],
                      )),
                    ),
                    onTap: () {
                    //  mensagemEmDev();
                      
                      _processarVerificacaodeLotePendentes();
                      preLancPerdas();
                      
                    },
                  ),
                  InkWell(
                    child: Container(
                      child: Card(
                          child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: btEntrada,
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text(
                                  "Entrada de Mercadorias",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                        ],
                      )),
                    ),
                    onTap: () {
                     // mensagemEmDev();
                      
                      _processarVerificacaodeLotePendentes();
                      Navigator.pushNamed(context, 'TokenMercEnt');
                      
                    },
                  ),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: btSair,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black87,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Deseja sair do Aplicativo?',
                            style: TextStyle(fontFamily: 'Pacifico'),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Não',
                                  style: TextStyle(
                                      color: Color(0xFF3a8e74),
                                      fontSize: 20,
                                      fontFamily: 'Pacifico')),
                            ),
                            FlatButton(
                              onPressed: () => SystemNavigator.pop(),
                              child: Text('Sim',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontFamily: 'Pacifico')),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3)),
          ),
        ));
  }

  void mensagemEmDev() {
     Fluttertoast.showToast(
      msg: 'Em Desenvolvimento',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0
    );
  }

  _insertEtiquetaItens() async {
    final objetoToken = SQLETIQUETAITENSDAO();
    numdeEtiqItensCadastrados = await objetoToken.count();
    numdeEtiqItensCadastrados = numdeEtiqItensCadastrados! + 1;
    final notaEtiquetaItem = ETIQUETAITENSDAO(numdeEtiqItensCadastrados,
        varG_plu, varGLOTEcodigoid, qtdEtiquetasaImp, varG_vlr_produto);
    final daoEtiquetaItem = SQLETIQUETAITENSDAO();
    daoEtiquetaItem.save(notaEtiquetaItem);

    Fluttertoast.showToast(
        msg: "Etiqueta Salva",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white,
        textColor: Colors.green,
        fontSize: 16.0);
    setState(() {
      qtdEtiquetasaImp = 1;
    });
  }

  preImpressaoEtiquetas() async {
    origemClique = 'impressaoetiqueta';
    pesquisaProdutoDigitado = '';
    var verificacao = await _selectMaxEtiquetaItens();

    if (selectMaxEtiqItensnoDb == null) {
      selectMaxEtiqItensnoDb = 0;
    }
    if (selectMaxEtiqItensnoDb == 0) {
      varGLoteRegistrou = false;
      if (envioEtiquetaPende == 'N') {
       var aguardar =await criarLoteEtiqueta();
       if (varGLoteRegistrou==true){
          var aguardar1 = await consultarUltLote.selectmaxLote(context);
       }
       
      }
    } else {
      envioEtiquetaPende = 'S';
      consultarUltLote.selectmaxLote(context);
    }
     if (varGLoteRegistrou==true){
      var aguardar = await _insertEtiquetaItens();
     }else{
 Fluttertoast.showToast(
        msg: "DB Error Reg Lote tb_Mobetiq",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white,
        textColor: Colors.green,
        fontSize: 16.0);
    setState(() {
      qtdEtiquetasaImp = 1;
    });      
     }
   
  }

  preInventario() async {
    BALANCO temBalanco =
        await consultarBalancoAtivo.verificarseTemBalancoAtivo();
    if (vargInvemaberto == true) {
      if (varGControleqtdDeposito == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BalancoCControle()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Balanco()),
        );
      }
    } else {
      Fluttertoast.showToast(
          msg: "Não Existe Balanço em Aberto",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  preLancPerdas() async {
    var verificacao = await _selectMaxPerdasLote();

    if (selectMaxLotePerdasnoDb == null) {
      selectMaxLotePerdasnoDb = 0;
    }

    if (selectMaxLotePerdasnoDb == 0) {
      if (envioPerdaPende == 'N') {
        Navigator.pushNamed(context, 'ListMotPer');
      } else {
      //  if (EstoquedeOrigem == true) {
        if (varGControleqtdDeposito == 1) {
          Navigator.pushNamed(context, 'LancPerdaCContr');
        } else {
          Navigator.pushNamed(context, 'LancPerdas');
        }
      }
    } else {
      print('nº Perdas ' + selectMaxLotePerdasnoDb.toString());
     // envioPerdaPende = 'S';
      if (envioPerdaPende == 'N') {
       // if (EstoquedeOrigem == true) {
        if (varGControleqtdDeposito == 1) {
          Navigator.pushNamed(context, 'LancPerdaCContr');
        } else {
          Navigator.pushNamed(context, 'LancPerdas');
        }
      }
    }
  }

  _drawDev(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          /*
          new UserAccountsDrawerHeader(
            accountName: Text(
              'Olá: ' + varGUsuario,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              'Focus Informática\n Av Humberto Monte, 2929 - Sala 201S,\nPici - Fortaleza-CE',
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 12),
            ),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/logo.png'),
              ),
            ),
            decoration: new BoxDecoration(
              color: Color(0xFF3a8e74),
            ),
          ),*/

          Container(
            height: 120,
            color: Color(0xFF3a8e74),
            child: 
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: CircleAvatar(
                      radius:35,
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/logo.png', height: 35, width: 70,),
                      ),
                   ),
                  ],
                ),
                
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Focus Informática\n\n Av Humberto Monte, 2929\nSala 201S, Pici\nFortaleza-CE',
                            overflow: TextOverflow.fade,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                              
                      ),
                    ],
                ),
                 ),
              ],
            ),
          ),

          InkWell(
            onTap: () async {

              _processarVerificacaodeLotePendentes();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Principal(),
                  ));
            },
            child: ListTile(
              title: Text('Home', style: TextStyle(color: Color(0xFF3a8e74))),
              leading: Icon(
                Icons.home,
                color: Color(0xFF28353d),
              ),
            ),
          ),

          InkWell(
            onTap: () => {
              _processarVerificacaodeLotePendentes(),
              origemClique = 'consultaitem',
              pesquisaProdutoDigitado = '',
              if (modo == 'scan')
                {
                  LercodigodeBarras().escanearCodigodeBarras(context),
                }
              else
                {
                  Navigator.pushNamed(context, 'PesquisaDigi'),
                }
            },
            child: ListTile(
              title: Text('Consulta Item',
                  style: TextStyle(color: Color(0xFF3a8e74))),
              leading: Icon(
                Icons.qr_code_scanner,
                color: Color(0xFF28353d),
              ),
            ),
          ),

          InkWell(
            onTap: () async {
              
              mensagemEmDev();
              /*
              _processarVerificacaodeLotePendentes();
              pesquisaProdutoDigitado = '';
              produtoPorCodbarra = false;
              preImpressaoEtiquetas();
              varG_plu =0;
              if (modo == 'scan') {
                LercodigodeBarras().escanearCodigodeBarras(context);
              } else {
                Navigator.pushNamed(context, 'PesquisaDigi');
              };
              */
            },
            child: ListTile(
              title: Text('Impressão de Etiqueta',
                  style: TextStyle(color: Color(0xFF3a8e74))),
              leading: Icon(
                Icons.print_sharp,
                color: Color(0xFF28353d),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              
              //mensagemEmDev();
              
              _processarVerificacaodeLotePendentes();
              if (envioSugestPende == 'N') {
                Navigator.pushNamed(context, 'ListMotAlt');
              } else {
                origemClique = 'sugestaopreco';
                pesquisaProdutoDigitado = '';
                if (modo == 'scan') {
                  LercodigodeBarras().escanearCodigodeBarras(context);
                } else {
                  Navigator.pushNamed(context, 'PesquisaDigi');
                }
                ;
              }
              
            },
            child: ListTile(
              title: Text('Sugestão de Preço',
                  style: TextStyle(color: Color(0xFF3a8e74))),
              leading: Icon(
                Icons.wifi_protected_setup,
                color: Color(0xFF28353d),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              
              mensagemEmDev();
              /*
              _processarVerificacaodeLotePendentes();
              preInventario();
              */
            },
            child: ListTile(
              title: Text('Inventário de Mercadoria',
                  style: TextStyle(color: Color(0xFF3a8e74))),
              leading: Icon(
                Icons.add_chart,
                color: Color(0xFF28353d),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              mensagemEmDev();
              /*
              _processarVerificacaodeLotePendentes();
              preLancPerdas();
              */
            },
            child: ListTile(
              title: Text('Lançamento de Perdas',
                  style: TextStyle(color: Color(0xFF3a8e74))),
              leading: Icon(
                Icons.content_paste_rounded,
                color: Color(0xFF28353d),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              mensagemEmDev();
              /*
              _processarVerificacaodeLotePendentes();
              Navigator.pushNamed(context, 'TokenMercEnt');

              */
            },
            child: ListTile(
              title: Text(
                'Entrada de Mercadoria',
                style: TextStyle(color: Color(0xFF3a8e74)),
              ),
              leading: Icon(
                Icons.add_business_rounded,
                color: Color(0xFF28353d),
              ),
            ),
          ),
          InkWell(
            onTap: () => {
              mensagemEmDev(),
              /*
              _processarVerificacaodeLotePendentes(),
              Navigator.pushNamed(context, 'LancPerdaCContr'),

              */
            },
            child: ListTile(
              title: Text(
                'Token',
                style: TextStyle(color: Color(0xFF3a8e74)),
              ),
              leading: Icon(
                Icons.vpn_key_outlined,
                color: Color(0xFF28353d),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () => {

              mensagemEmDev(),
              /*
              _processarVerificacaodeLotePendentes(),
              Navigator.pushNamed(context, 'Config'),
              */
            },
            child: ListTile(
              title: Text('Configuração',
                  style: TextStyle(
                    color: Color(0xFF3a8e74),
                  )),
              leading: Icon(
                Icons.settings,
                color: Color(0xFF3a8e74),
              ),
            ),
          ),
          InkWell(
            onTap: () => {
              _deletarListaEtiquetasItens(),
              _deletarListaPerdasasItens(),
              _deletarLoteSugesta(),
              _deletarAlteracoesItens(),
              _deletarEntradaItens(),
              _deletarPerdas(),
              _deletarBalanco(),
              _deletarEntradaItens(),
              _deletarListaEntradaItens(),
              Fluttertoast.showToast(
                  msg: 'Resert Finalizado',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 16.0),
            },
            child: ListTile(
              title: Text('Resert Database',
                  style: TextStyle(
                    color: Color(0xFF3a8e74),
                  )),
              leading: Icon(
                Icons.published_with_changes,
                color: Color(0xFF3a8e74),
              ),
            ),
          ),
          InkWell(
            onTap: () => {},
            child: ListTile(
              title: Text('Versão '+versaoApp,
                  style: TextStyle(
                    color: Color(0xFF3a8e74),
                  )),
              leading: Icon(
                Icons.verified_user_rounded,
                color: Color(0xFF3a8e74),
              ),
            ),
          ),
          InkWell(
            onTap: () => {},
            child: ListTile(
              title: Text('Sair', style: TextStyle(color: Colors.red)),
              leading: Icon(Icons.exit_to_app, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  _processarVerificacaodeLotePendentes() {
    int maisdeumenvio = 0;
    txtEnvioPendente = '';
    setState(() {
      envioEtiquetaPende = 'N';
      envioPerdaPende = 'N';
      envioSugestPende = 'N';
      envioEntradPende = 'N';
    });

    selectMaxEtiqItensnoDb = 0;
    selectMaxEntraItensnoDb = 0;
    selectMaxLotePerdasnoDb = 0;
    selectMaxLoteSugestaonoDb = 0;

    _selectMaxEtiquetaItens();
    _selectMaxPerdasLote();
    _selectMaxLoteSugestao();
    _selectMaxEntradaItens();


    if (selectMaxEtiqItensnoDb > 0) {
      envioEtiquetaPende = 'S';
    }

    if (selectMaxLotePerdasnoDb > 0) {
      envioPerdaPende = 'S';
    }

    if (selectMaxLoteSugestaonoDb > 0) {
      envioSugestPende = 'S';
    }
    
    if (selectMaxEntraItensnoDb > 0) {
      envioEntradPende = 'S';
    }


    if ((envioEtiquetaPende == 'N') &&
        (envioPerdaPende == 'N') &&
        (envioSugestPende == 'N')&&
        (envioEntradPende == 'N')) {
      Fluttertoast.showToast(
          msg: 'Sem Envios Pendentes :)',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: 'Você tem Envios Pendentes',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      _envioPendenteIcon();
      maisdeumenvio = 0;
      txtEnvioPendente = '';

      if (envioEtiquetaPende != 'N') {
        if (maisdeumenvio == 0) {
          txtEnvioPendente = txtEnvioPendente + ' Etiquetas';
          maisdeumenvio = maisdeumenvio + 1;
        } else {
          txtEnvioPendente = txtEnvioPendente + ', Etiquetas';
          maisdeumenvio = maisdeumenvio + 1;
        }
      }
      if (envioPerdaPende != 'N') {
        if (maisdeumenvio == 0) {
          txtEnvioPendente = txtEnvioPendente + ' Perdas';
          maisdeumenvio = maisdeumenvio + 1;
        } else {
          txtEnvioPendente = txtEnvioPendente + ', Perdas';
          maisdeumenvio = maisdeumenvio + 1;
        }
      }
      if (envioSugestPende != 'N') {
        if (maisdeumenvio == 0) {
          txtEnvioPendente = txtEnvioPendente + ' Sugetão de Preço';
          maisdeumenvio = maisdeumenvio + 1;
        } else {
          txtEnvioPendente = txtEnvioPendente + ', Sugetão de Preço';
          maisdeumenvio = maisdeumenvio + 1;
        }
      }
      if (envioEntradPende != 'N') {
        if (maisdeumenvio == 0) {
          txtEnvioPendente = txtEnvioPendente + ' Entrada de Itens';
          maisdeumenvio = maisdeumenvio + 1;
        } else {
          txtEnvioPendente = txtEnvioPendente + ', Entrada de Itens';
          maisdeumenvio = maisdeumenvio + 1;
        }
      }
      if (maisdeumenvio == 0) {
        txtEnvioPendente = 'Envio Pendente: ' + txtEnvioPendente;
      } else {
        txtEnvioPendente = 'Envios Pendentes: ' + txtEnvioPendente;
      }
    }
  }

  _processarVerificacaodeLotePendentesComAlerta() async{
    int maisdeumenvio = 0;
    txtEnvioPendente = '';
    setState(() {
      envioEtiquetaPende = 'N';
      envioPerdaPende = 'N';
      envioSugestPende = 'N';
    });

    selectMaxEtiqItensnoDb = 0;
    selectMaxEntraItensnoDb = 0;
    selectMaxLotePerdasnoDb = 0;
    selectMaxLoteSugestaonoDb = 0;

   var aguardar1 = await _selectMaxEtiquetaItens();
   var aguardar2 = await _selectMaxPerdasLote();
   var aguardar3 = await _selectMaxLoteSugestao();
   var aguardar4 = await _selectMaxEntradaItens();
  

    if (selectMaxEtiqItensnoDb > 0) {
      envioEtiquetaPende = 'S';
    }

    if (selectMaxLotePerdasnoDb > 0) {
      envioPerdaPende = 'S';
    }

    if (selectMaxLoteSugestaonoDb > 0) {
      envioSugestPende = 'S';
    }

   if (selectMaxEntraItensnoDb > 0) {
      envioEntradPende = 'S';
    }
    if ((envioEtiquetaPende == 'N') &&
        (envioPerdaPende == 'N') &&
        (envioSugestPende == 'N')&&
        (envioEntradPende == 'N')) {
      Fluttertoast.showToast(
          msg: 'Sem Envios Pendentes :)',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: 'Você tem Envios Pendentes',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      _envioPendenteIcon();
      maisdeumenvio = 0;
      txtEnvioPendente = '';

      if (envioEtiquetaPende != 'N') {
        if (maisdeumenvio == 0) {
          txtEnvioPendente = txtEnvioPendente + ' Etiquetas';
          maisdeumenvio = maisdeumenvio + 1;
        } else {
          txtEnvioPendente = txtEnvioPendente + ', Etiquetas';
          maisdeumenvio = maisdeumenvio + 1;
        }
      }
      if (envioPerdaPende != 'N') {
        if (maisdeumenvio == 0) {
          txtEnvioPendente = txtEnvioPendente + ' Perdas';
          maisdeumenvio = maisdeumenvio + 1;
        } else {
          txtEnvioPendente = txtEnvioPendente + ', Perdas';
          maisdeumenvio = maisdeumenvio + 1;
        }
      }
      if (envioSugestPende != 'N') {
        if (maisdeumenvio == 0) {
          txtEnvioPendente = txtEnvioPendente + ' Sugetão de Preço';
          maisdeumenvio = maisdeumenvio + 1;
        } else {
          txtEnvioPendente = txtEnvioPendente + ', Sugetão de Preço';
          maisdeumenvio = maisdeumenvio + 1;
        }
      }
      if (envioEntradPende != 'N') {
        if (maisdeumenvio == 0) {
          txtEnvioPendente = txtEnvioPendente + ' Entrada de Itens';
          maisdeumenvio = maisdeumenvio + 1;
        } else {
          txtEnvioPendente = txtEnvioPendente + ', Entrada de Itens';
          maisdeumenvio = maisdeumenvio + 1;
        }
      }
      if (maisdeumenvio == 0) {
        txtEnvioPendente = 'Envio Pendente: ' + txtEnvioPendente;
      } else {
        txtEnvioPendente = 'Envios Pendentes: ' + txtEnvioPendente;
      }

      showDialog(
        context: context,
        barrierColor: Colors.black87,
        builder: (context) => AlertDialog(
          title: Text(txtEnvioPendente),
          actions: <Widget>[
            ElevatedButton.icon(
              onPressed: () async {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              label: Text('Não',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Pacifico')),
            ),
            ElevatedButton.icon(
              onPressed: () async {

                if (envioEtiquetaPende == 'S'){
                  var aguardarEnvio1 = await _listaEtiquetaseEnviar();
                }
                if (envioPerdaPende == 'S'){
                  var aguardarEnvio2 = await _listarPerdaseEnviar();
                }
                if (envioEntradPende == 'S'){
                  var aguardarEnvio3 = await _listarEntradaItensseEnviar();
                }
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              label: Text('Sim',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Pacifico')),
            ),
          ],
        ),
      );
    }
  }

  _envioPendenteIcon() {
    if ((envioEtiquetaPende == 'N') &&
        (envioPerdaPende == 'N') &&
        (envioSugestPende == 'N')) {
     // return Icon(Icons.send, size: 30, color: Color(0xFF3a8e74));
      return Icon(Icons.send, size: 30, color:Colors.teal[800]);
    } else {
      return Icon(
        Icons.send,
        size: 30,
        color: Colors.red,
      );
    }
  }
}

Future criarLoteEtiqueta() async {
  var loteetiqueta = ETIQUETALOTE(0, 0, 0);

  Fluttertoast.showToast(
      msg: 'Registrando Lote',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);

  var url = apiHost + apiEtiquetaRegistraLotePost;
  Map registrarLote = {
    "codigoempresa": codigoIdLoja,
    "codigousuario": varGcodigousuario,
    "codcaixa": 0,
    "usuarioprocessamento": varGUsuario
  };

  var body = convert.json.encode(registrarLote);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);
  print("${response.statusCode}");
  print("${response.body}");


  final objListDelete = SQLETIQUETAITENSDAO();
  int? quantidadeDelte = await objListDelete.count();


  if ((response.statusCode == 200)&&(quantidadeDelte!=0)) {
    selectMaxEtiqItensnoDb =1;
    varGLoteRegistrou =true;
    envioEtiquetaPende = 'S';
  }else{
    envioEtiquetaPende = 'N';
    selectMaxEtiqItensnoDb =0;
    varGLoteRegistrou =false;
  }
}

Future enviarEtiqueta() async {
  var etiqueta = ETIQUETA(0, 0, 0.0);

  Fluttertoast.showToast(
      msg: 'Enviando Etiquetas',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);

  print("${varG_codigo_barra} , ${varG_vlr_produto} ");

  var url = apiHost + apiEtiquetaPost;
  Map enviarEtiqueta = {
    "codigoid": varGLOTEcodigoid,
    "es_codigo":varG_plu,
  //  "quantidade": 1,
    "quantidadeetiqueta": 1,
    "precovenda": varG_vlr_produto.toDouble()
  };

  var body = convert.json.encode(enviarEtiqueta);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);
  print("${response.statusCode}");
  print("${response.body}");
}

Future enviarPerdaItem() async {
  var etiqueta = ETIQUETA(0, 0, 0.0);

  Fluttertoast.showToast(
      msg: 'Salvando Perdas',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);

  print("${varG_plu} , ${varG_vlr_produto} ");

  var url = apiHost + apiPerdasItensPost;
  Map enviarSugestao = {
    "codigoid": 0,
    "es_codigo":varG_plu,
    "quantidade": qtdPerdas,
    "quantidadedeposito": 0
  };

  var body = convert.json.encode(enviarSugestao);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);
  print("${response.statusCode}");
  print("${response.body}");
}

_selectMaxEtiquetaItens() async {

  final objetoListaEtiquetas = SQLETIQUETAITENSDAO();
  List<ETIQUETAITENSDAO> todosasEtiquetasSalvas =
      await objetoListaEtiquetas.findAll();

  selectMaxEtiqItensnoDb = todosasEtiquetasSalvas.length;
print('Nº  etiquetas Itens: '+selectMaxEtiqItensnoDb.toString());
  
}

_selectMaxPerdasLote() async {

   final objetoListaPerdaslote = SQLPERDASDAO();
  List<PERDASDAO> todosasperdasSalvaslote =
      await objetoListaPerdaslote.findAll();

  selectMaxLotePerdasnoDb = todosasperdasSalvaslote.length;
print('Nº  Lote perdas: '+selectMaxLotePerdasnoDb.toString());

}

_selectMaxPerdasItens() async {
   final objetoListaPerdas = SQLPERDASITENSDAO();
  List<PERDASITENSDAO> todosasperdasSalvas =
      await objetoListaPerdas.findAll();

  selectMaxPerdasItensnoDb = todosasperdasSalvas.length;
print('Nº  Itens perdas: '+selectMaxPerdasItensnoDb.toString());

}


_selectMaxEntradaItens() async {

  final objetoListaEntradas = SQLENTRADAITENSDAO();
  List<ENTRADAITENSDAO> todosasEntradasSalvas =
      await objetoListaEntradas.findAll();

  selectMaxEntraItensnoDb = todosasEntradasSalvas.length;
print('Nº  etiquetas Itens: '+selectMaxEntraItensnoDb.toString());
  
}



_selectMaxLoteSugestao() async {

   final objetoListaSugestaolote = SQLLOTESUGESTAODAO();
  List<LOTESUGESTAODAO> todosassugestaoSalvasLote =
      await objetoListaSugestaolote.findAll();

  selectMaxLoteSugestaonoDb = todosassugestaoSalvasLote.length;

  print('Nº  Lote Sugestao: '+selectMaxLoteSugestaonoDb.toString());


}

_listarEtiquetas() async {
  final objetoListaEtiquetas = SQLETIQUETAITENSDAO();
  List<ETIQUETAITENSDAO> todosasEtiquetasSalvas =
      await objetoListaEtiquetas.findAll();

  countIndex = 0;

  while (countIndex < todosasEtiquetasSalvas.length) {
    ETIQUETAITENSDAO et = todosasEtiquetasSalvas[countIndex];

    print('AI: ' +
        et.id.toString() +
        ' Codigo Id: ' +
        et.codigoid.toString() +
        ' Es_Codigo: ' +
        et.escodigo.toString() +
        ' Qtd: ' +
        et.quantidade.toString() +
        ' Preço: ' +
        et.precovenda.toString());
    print('');
    countIndex = countIndex + 1;
  }
  
}


_listarPerdaItens() async {
  final objetoListaPerda = SQLPERDASITENSDAO();
  List<PERDASITENSDAO> todosasPerdasSalvas = await objetoListaPerda.findAll();

  countIndex = 0;

  while (countIndex < todosasPerdasSalvas.length) {
    PERDASITENSDAO perdasList = todosasPerdasSalvas[countIndex];

    countIndex = countIndex + 1;
  }
  ;
}

_listaEtiquetaseEnviar() async {
  final objetoListaEtiquetas = SQLETIQUETAITENSDAO();
  List<ETIQUETAITENSDAO> todosasEtiquetasSalvas =
      await objetoListaEtiquetas.findAll();

  countIndex = 0;
  loteEtiquetasStatus200 = false;

  while (countIndex < todosasEtiquetasSalvas.length) {
    ETIQUETAITENSDAO et = todosasEtiquetasSalvas[countIndex];

    print('AI: ' +
        et.id.toString() +
        ' Codigo Id: ' +
        et.codigoid.toString() +
        ' Es_Codigo: ' +
        et.escodigo.toString() +
        ' Qtd: ' +
        et.quantidade.toString() +
        ' Preço: ' +
        et.precovenda.toString());
    print('');

    var url = apiHost + apiEtiquetaPost;
    Map enviarEtiqueta = {
      "codigoid": et.codigoid,
      "es_codigo": et.escodigo,
     // "quantidade": et.quantidade,
      "quantidadeetiqueta": et.quantidade,
      "precovenda": et.precovenda
    };

    var body = convert.json.encode(enviarEtiqueta);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200){
     
      loteEtiquetasStatus200 = true;

    } else {
      loteEtiquetasStatus200 = false;
    }

    countIndex = countIndex + 1;
  }
  ;

  if (loteEtiquetasStatus200) {
    Fluttertoast.showToast(
        msg: 'Enviado com Sucesso!!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
        envioEtiquetaPende ='N';
    var espeDelet = await _deletarListaEtiquetasItens();
  } else {
    Fluttertoast.showToast(
        msg: 'Falha no Envio tente Novamente',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

_listarPerdaseEnviar() async {
  final objetoListaPerdas = SQLPERDASITENSDAO();
  List<PERDASITENSDAO> todosasPerdasSalvas = await objetoListaPerdas.findAll();

  countIndex = 0;
  lotePerdasStatus200 = false;

  while (countIndex < todosasPerdasSalvas.length) {
    PERDASITENSDAO perdaLst = todosasPerdasSalvas[countIndex];

    var url = apiHost + apiPerdasItensPost;
    Map enviarPerdas = {
      "codigoid": perdaLst.codigoid,
      "es_codigo": perdaLst.escodigo, 
      "quantidade": perdaLst.quantidade,
      "quantidadedeposito": perdaLst.quantidadedeposito
    };

    var body = convert.json.encode(enviarPerdas);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      lotePerdasStatus200 = true;

    } else {
      lotePerdasStatus200 = false;
    }

    countIndex = countIndex + 1;
  }
  ;

  if (lotePerdasStatus200) {
    Fluttertoast.showToast(
        msg: 'Enviado com Sucesso!!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
        envioPerdaPende ='N';
        _deletarListaPerdasasItens();
        _deletarPerdas();
  } else {
    Fluttertoast.showToast(
        msg: 'Falha no Envio tente Novamente',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}


_listarEntradaItensseEnviar() async {
  final objetoListaPerdas = SQLENTRADAITENSDAO();
  List<ENTRADAITENSDAO> todosasEntradasSalvas = await objetoListaPerdas.findAll();

  countIndex = 0;
  EntradasItemStatus200 = false;

  while (countIndex < todosasEntradasSalvas.length) {
    ENTRADAITENSDAO entrLst = todosasEntradasSalvas[countIndex];

    var url = apiHost + apiEntradaitensPost;
    Map enviarEntradas = {
      "tokenmobile": entrLst.tokenmobile,
      "Es_codigo": entrLst.escodigo, 
      "codigoean": entrLst.codigoean, 
      "quantidade": entrLst.quantidade,
      "quantidadepeca": entrLst.quantidadepecas
    };

    var body = convert.json.encode(enviarEntradas);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      EntradasItemStatus200 = true;
      
    } else {
      EntradasItemStatus200 = false;
    }

    countIndex = countIndex + 1;
  }
  ;

  if (EntradasItemStatus200) {
    Fluttertoast.showToast(
        msg: 'Enviado com Sucesso!!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
        envioPerdaPende ='N';
        _deletarListaEntradaItens();
  } else {
    Fluttertoast.showToast(
        msg: 'Falha no Envio tente Novamente',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}


_deletarListaEtiquetasItens() async {
  final objetoListaEtiquetas = SQLETIQUETAITENSDAO();
  deleteListaEtiqueta = await objetoListaEtiquetas.deleteAll();
}

_deletarListaPerdasasItens() async {
  final objetoListaPerdasitens = SQLPERDASITENSDAO();
  deleteListaPerdasItens = await objetoListaPerdasitens.deleteAll();
}


_deletarListaEntradaItens() async {
  final objetoListaEntradaitens = SQLENTRADAITENSDAO();
  deleteListaEntradaItens = await objetoListaEntradaitens.deleteAll();
}


_deletarLoteSugesta() async {
  final objetoLotesugestao = SQLLOTESUGESTAODAO();
  deleteLoteSugestao = await objetoLotesugestao.deleteAll();
}

_deletarAlteracoesItens() async {
  final objetoAltItens = SQLALTERACAOITENSDAO();
  deleteAltItens = await objetoAltItens.deleteAll();
}

_deletarEntradaItens() async {
  final objetoEntradaItens = SQLENTRADAITENSDAO();
  deleteEntItens = await objetoEntradaItens.deleteAll();
}

_deletarPerdas() async {
  final objetoPerdas = SQLPERDASDAO();
  deletePerdas = await objetoPerdas.deleteAll();
}

_deletarBalanco() async {
  final objetoBalanco = SQLBALANCOODAO();
  deleteBalanco = await objetoBalanco.deleteAll();
}

Future criarLotePerda() async {
  Fluttertoast.showToast(
      msg: 'Registrando Lote Perda',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);

  var url = apiHost + apiPerdasLotePost;
  Map registrarLotePerda = {
    "codigoempresa": codigoIdLoja,
    "codigomotivo": varGCodigomotivo,
    "obs": varGobs,
    "codigousuario": varGcodigousuario,
    "codcaixa": 0,
    "datasolitacao": varGdatahoje =
        formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy])
  //  "usuarioprocessamento": varGUsuario
  };

  var body = convert.json.encode(registrarLotePerda);
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);
  jsontoMapLotePerda = response.body;
  print("${response.statusCode}");
  print("${response.body}");

  if (response.statusCode == 200) {
    var parsedJson = convert.json.decode(jsontoMapLotePerda);
    varGLotePerdacodigoid = parsedJson['codigoid'];
    envioPerdaPende = 'S';

    final loteaSalvar = SQLPERDASDAO();
    final novoLotePerda = PERDASDAO(
        varGLotePerdacodigoid,
        varG_id_Loja,
        varGCodigomotivo,
        varGobs,
        varGcodigousuario,
        0,
        formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy])
        );
    final daolote = SQLPERDASDAO();
    daolote.save(novoLotePerda);
  }
}

Future enviarSugestaoPreco() async {
  var etiqueta = ETIQUETA(0, 0, 0.0);

  print("${varG_plu} , ${varG_vlr_produto} ");

  var url = apiHost + apiSugestaoPrecoPost;
  Map enviarSugestao = {
    "codigoid": varGSugPreLote,
    "es_codigo":varG_plu,
    "precovenda": precoSugerido.toDouble(),
    "promocao": 0,
    "iniciopromocao": "",
    "fimpromocao": ""
  };

  var body = convert.json.encode(enviarSugestao);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);
  print("${response.statusCode}");
  print("${response.body}");

  if (response.statusCode == 200) {
    Fluttertoast.showToast(
        msg: 'Sugestão de preço Enviada',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    Fluttertoast.showToast(
        msg: 'Falha no Envio',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

Future enviarSugestaoPrecoComPromocao() async {
  var etiqueta = ETIQUETA(0, 0, 0.0);

  print("${varG_plu} , ${varG_vlr_produto} ");

  var url = apiHost + apiSugestaoPrecoPost;
  Map enviarSugestao = {
    "codigoid": varGSugPreLote,
    "es_codigo":varG_plu, 
    "precovenda": precoSugerido.toDouble(),
    "promocao": 1,
    "iniciopromocao": varGSugDtInicioPromo,
    "fimpromocao": varGSugDtFimPromo
  };

  var body = convert.json.encode(enviarSugestao);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);
  print("${response.statusCode}");
  print("${response.body}");

  if (response.statusCode == 200) {
    Fluttertoast.showToast(
        msg: 'Sugestão com Promoção Enviada',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    Fluttertoast.showToast(
        msg: 'Falha no Envio',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

Future criarLoteSugestaoPreco() async {
  Fluttertoast.showToast(
      msg: 'Registrando Lote Sugestão de Preco',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);

  if (varGmotivCodigomotiv == 0) {
    varGmotivCodigomotiv = 1;
  }

  var url = apiHost + apiSugestaoPrecoLotePost;
  Map registrarLoteSugestao = {
    "codigoempresa": codigoIdLoja,
    "codigomotivo": varGmotivCodigomotiv,
    "obs": varGSugPreObs,
    "codigousuario": varGcodigousuario,
    "codcaixa": 0,
    "datasolitacao": varGdatahoje =
        formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy])
  };
  var body = convert.json.encode(registrarLoteSugestao);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"}, body: body);
  jsonMapLoteSugestao = response.body;
  print("${response.statusCode}");
  print("${response.body}");

  if (response.statusCode == 200) {
    var parsedJson = convert.json.decode(jsonMapLoteSugestao);
    varGSugPreLote = parsedJson['codigoid'];

    final loteaSalvar = SQLLOTESUGESTAODAO();
    numdeLoteSugestCadastrados = await loteaSalvar.count();
    numdeLoteSugestCadastrados = numdeLoteSugestCadastrados! + 1;
    final novoLote = LOTESUGESTAODAO(
        varGSugPreLote,
        varG_id_Loja,
        varGmotivCodigomotiv,
        varGSugPreObs,
        varGcodigousuario,
        0,
        varGdatahoje = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]));
    final daolote = SQLLOTESUGESTAODAO();
    daolote.save(novoLote);
  
    envioSugestPende = 'S';
  }
}

class consultarBalancoAtivo {
  static int get codigoempresaLocal => 0;

  static Future<BALANCO> verificarseTemBalancoAtivo() async {
    var url = apiHost + apiBalancoAtivoporEmpresa + varG_id_Loja.toString();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "CharacterEncoding": "UTF-8"
    };

    Map params = {
      'codigoempresa': codigoempresaLocal,
    };

    String s = convert.json.encode(params);
    final balancoRetornada = BALANCO(codigoempresaLocal);
    var response = await http.get(Uri.parse(url));
    jsonMapBalanco = response.body;

    if (response.body != '') {
      var parsedJson = convert.json.decode(jsonMapBalanco);
      vargInvcodbalanco = int.parse(parsedJson['codigobalanco']);
      vargInvemaberto = true;
    } else {
      vargInvemaberto = false;
    }

    return balancoRetornada;
  }
}

class consultarUltLote {
  static int get codigousuario => 0;
  static int get codigoempresa => 0;
  static int get codigoid => 0;
  static int get codcaixa => 0;
  static String get usuarioprocessamento => '';

  static Future<ETIQUETALOTE> selectmaxLote(context) async {
    var url = apiHost + apiConsultUltLoteEtiq;

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "CharacterEncoding": "UTF-8"
    };

    Map params = {
      'codigoempresa': codigoempresa,
    };

    String s = convert.json.encode(params);

    final loteRetornado = ETIQUETALOTE(
       // codigoempresa, codigousuario, codcaixa, usuarioprocessamento);
        codigoempresa, codigousuario, codcaixa);

    var response = await http.get(Uri.parse(url));

    jsontoMapLote = response.body;

    if (response.body != '') {
      var parsedJson = convert.json.decode(jsontoMapLote);

      varGLOTEcodigousuario = parsedJson['codigousuario'];
      varGLOTEcodigoempresa = parsedJson['codigoempresa'];
      varGLOTEcodigoid = parsedJson['codigoid'];
      varGLOTEcodcaixa = parsedJson['codcaixa'];
     // varGLOTEusuarioprocessamento =  parsedJson['usuarioprocessamento'].toString();

      print(
          'Resultado Final:  $varGLOTEusuarioprocessamento, $varGLOTEcodigousuario ultimo Lote: $varGLOTEcodigoid');

      loteRetornado.codigousuario = varGLOTEcodigousuario;
      loteRetornado.codigoempresa = varGLOTEcodigoempresa;
      loteRetornado.codigoid = varGLOTEcodigoid;
      loteRetornado.codcaixa = varGLOTEcodcaixa;
    //  loteRetornado.usuarioprocessamento = varGLOTEusuarioprocessamento;

      if (loteRetornado.codigoid != 0) {
        print('SelectMax Lote: ' + varGLOTEcodigoid.toString());
      } else {
        Fluttertoast.showToast(
            msg: "Falha ao consulta Lote",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Vazio, Limpando DB Local, Cancele e Repita a Operação ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      _deletarListaEtiquetasItens();
    }
    return loteRetornado;
  }
}
