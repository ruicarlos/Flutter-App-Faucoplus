import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faucomplus/Objetos/Objeto_Parametros.dart';
import 'package:faucomplus/Views/Balanco.dart';
import 'package:faucomplus/Views/BalancoCControle.dart';
import 'package:faucomplus/Views/DetalhesProduto.dart';
import 'package:faucomplus/Views/EntradaMercadoria.dart';
import 'package:faucomplus/objetos/Objeto_Usuario.dart';
import 'package:faucomplus/Views/config.dart';
import 'package:faucomplus/Views/token.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/Requisicoes.dart';
import 'package:faucomplus/utils/dbDao.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert' as converts;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/Views/Principal.dart';
import 'Objetos/Objeto_TokenEntradaMerc.dart';
import 'Views/LancamentoPerdaCControle.dart';
import 'Views/LancamentoPerdas.dart';
import 'Views/ListaMotivoAlterPreco.dart';
import 'Views/ListaMotivoPerdas.dart';
import 'Views/LotePerdas.dart';
import 'Views/LoteSugestao.dart';
import 'Views/PesquisaDigitada.dart';
import 'Views/PrecoSugerido.dart';
import 'Views/TokenMercadoria.dart';
import 'objetos/Objeto_Licenca.dart';
//import 'package:imei_plugin/imei_plugin.dart';
import 'package:macadress_gen/macadress_gen.dart';

var jsontoMap;
var varnomeusuario = null;
var varsenha = null;
var varcodigousuario = null;
var varcodigogrupo = null;
bool usuariovalidado = false;
bool tokenvalidado = false;
bool cepExiste = false;
String macAdress = '';
bool esconderSenha = true;
bool modoDemo = false;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Informática',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'login',
      routes: {
        'login': (context) => MyHomePage(),
        'Principal': (context) => Principal(),
        'Balanco': (context) => Balanco(),
        'BalancoCControle': (context) => BalancoCControle(),
        'Config': (context) => ConfigPage(),
        'DetalheProduto': (context) => ProductDetails(),
        'EntMerc': (context) => EntradaItens(),
        'LancPerdaCContr': (context) => LancamentoPerdasCControle(),
        'LancPerdas': (context) => LancamentoPerdasGeral(),
        'ListMotAlt': (context) => ListadeMotivosaltPreco(),
        'ListMotPer': (context) => ListadeMotivosperdas(),
        'LotePerda': (context) => LotePerdas(),
        'LoteSugestap': (context) => LoteSugestaoPreco(),
        'PrecoSugest': (context) => SugestaodePreco(),
        'PesquisaDigi': (context) => PesquisarProduto(),
        'Token': (context) => TokenPage(),
        'TokenMercEnt': (context) => TokenEntradadeMercadorias(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key ? key, this.title}) : super(key: key);

  final String?  title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MacadressGen macadressGen = MacadressGen();
  String _platformImei = 'Desconhecido';
  String uniqueId = "Desconhecido";

  @override
  void initState() {
    super.initState();
   // initPlatformState();
    _carregarTokenoAparelho();
    _recarregarConfig();
    getMAc();
  }

  Future getMAc() async {
    macAdress = await macadressGen.getMac();
    if (macAdress.length >=20){
      macAdress = macAdress.substring(0, 20);
      print('Cortado MAc');
      Fluttertoast.showToast(
        msg:"Mac Reduz: "+macAdress,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0
    );
    }
   // varGemeidoAparelho = macAdress;
 /*   Fluttertoast.showToast(
      msg:"Endereço Mac: "+macAdress,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 16.0
    ); */
}


  Future<bool> _onbackPressed() async {
    return ( await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Você deseja sair do Aplicativo?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Não',
                style: TextStyle(color: Colors.green, fontSize: 20)),
          ),
          FlatButton(
            onPressed: () => SystemNavigator.pop(),
            child:
                Text('Sim', style: TextStyle(color: Colors.red, fontSize: 20)),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    larguradaTela = MediaQuery.of(context).size.width;
    alturaTela = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onbackPressed,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: fundoDegradee),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: alturaTela * 0.50),
                        Text("Versão "+versaoApp, style: TextStyle(fontSize: 15, color: Colors.white),),
                        _insirirUsuario(),
                        SizedBox(height: 20.0),
                        _insirirSenha(),
                        _revelarSenhga(),
                        _loginBtnFocus(),
                        
    
                        TextButton(
                          onPressed: () {
                          //  Navigator.pushNamed(context, 'Token');
                            Navigator.of(context).pushNamed('Token');
                          },
                          child: Text("Token",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        )
                      ],
                    ),
                  ),
                ),
                _logoSobreposta(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Center(
        child: Image.asset(
          'assets/logo.png',
          height: 250,
          width: 350,
        ),
      ),
    );
  }

  Widget _logoSobreposta() {
    return Container(
      padding: EdgeInsets.only(top: alturaTela * 0.10),
      alignment: Alignment.topCenter,
      child: Image.asset(
        'assets/logo.png',
        height: 150,
        width: 170,
      ),
    );
  }

  Widget _skin() {
    return Container(
      child: Image.asset(
        'assets/skin.jpeg',
      ),
    );
  }

  Widget _insirirUsuario() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Usuário',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Titanone',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.person,
                  size: 20,
                  color: Color(0xFF026F75),
                ),
                hintText: 'Usuário',
                hintStyle: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'OpenSans',
                ),
              ),
              onChanged: (valor) async {
                setState(() {
                  usuarioRecebido = valor;
                });
              }),
        ),
      ],
    );
  }

  Widget _insirirSenha() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
              obscuringCharacter: '.',
              obscureText: esconderSenha,
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Titanone',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  size: 20,
                  color: Color(0xFF026F75),
                ),
                hintText: 'Senha',
                hintStyle: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'OpenSans',
                ),
              ),
              onChanged: (valor) async {
                setState(() {
                  senhaRecebida = valor;
                });
              }),
        ),
      ],
    );
  }

  visualizarSenha(){
    if (esconderSenha == true){
      setState(() {
        esconderSenha = false;
      });
      
    }else{
      setState(() {
        esconderSenha = true;
      });
    }
  }

  Widget _loginBtnFocus() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF5026F75))),
        child: Text(
          "Entrar",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
        ),
        onPressed: () async {
          print(varGemeidoAparelho);
          if((senhaRecebida =='12345')&&(usuarioRecebido =='DEMO')){
            modoDemo = true; 
            Navigator.pushNamed(context, 'Principal'); 
                
          }else{
          if (apiHost == ':') {
            Fluttertoast.showToast(
                msg: "Configure o App",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            String senhaSha1 = sha1.convert(converts.utf8.encode(senhaRecebida!)).toString();
            senhaRecebida = senhaSha1;

            USUARIOLOGIN? novoLogin =  await fazerLogin.consultaUsuarioInformado();

            SELECTPARAMETROS controlaDeposito =  await carregarParametros.consultarParametro();

            SELECTLICENCA verificar =
                await consultarLicenca.validarTokenMobile();

            if (usuariovalidado) {
              if (tokenmobilenoAparelho == tokenmobilenoServidor) {
               if ((varGnumeroseriemobile == varGemeidoAparelho) ||(varGnumeroseriemobile == macAdress)) { //  VERIFICA POR IMEI
               // if (varGnumeroseriemobile == macAdress) { // VERIFICA POR MAC
               modoDemo = false; 
                  Navigator.pushNamed(context, 'Principal');
                } else {
                  Fluttertoast.showToast(
                     // msg: "FMEI: Entre em contato com o Suporte :(",
                      msg: "Serie no DB:"+varGnumeroseriemobile+" MAC: "+macAdress+"  Fmei:"+varGemeidoAparelho,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                       
                      backgroundColor: Colors.brown[600],
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              } else {
                Fluttertoast.showToast(
                    msg: "Token em Branco",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                     
                    backgroundColor: Colors.blueAccent,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          }
          }
        },
      ),
    );
  }

  Widget _revelarSenhga() {
    return Container(
    //  padding: EdgeInsets.only(left: 15, right: 20),
      child:   SwitchListTile(
        activeColor: Colors.white,
        title: Text('Esconder Senha', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
        value: esconderSenha, 
        selected: false,
        onChanged:(valor){
        setState(() {
          esconderSenha = valor;
        }
      );
  
    }
  
    ),
);;
  }


}

class OuterClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 4);

    path.cubicTo(size.width * 0.55, size.height * 0.16, size.width * 0.85,
        size.height * 0.05, size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class InnerClippedPart extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width * 0.7, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.1);

    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.11, size.width * 0.7, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class fazerLogin {
  static int get codigousuario => 0;
  static int get codigogrupo => 0;
  static String get nomeusuario => '';
  static String get senha => '';

  static Future<USUARIOLOGIN?> consultaUsuarioInformado() async {
    try {
      var url = apiHost +
          apiUsuarioporNomeUsuarioeSenha +
          usuarioRecebido! +
          '/' +
          senhaRecebida!;
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "CharacterEncoding": "UTF-8"
      };

      Map params = {
        'Codigogrupousuario': codigogrupo,
      };

      String s = converts.json.encode(params);
      final usuarioRetornado = USUARIOLOGIN(nomeusuario, senha);
      try{
      var response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      jsontoMap = response.body;

      if (response.body != '') {
        var parsedJson = converts.json.decode(jsontoMap);
        varnomeusuario = parsedJson['nomeusuario'];
        varsenha = parsedJson['senha'];
        varcodigogrupo = parsedJson['codigogrupousuario'];
        varcodigousuario = parsedJson['codigousuario'];

        varGUsuario = varnomeusuario.toString();
        varGsenhaAcesso = varsenha.toString();
        varGcodigogrupo = varcodigogrupo;
        varGcodigousuario = varcodigousuario;

        print(
            'Resultado Final:  $varnomeusuario, $varsenha e $varcodigogrupo  $varcodigousuario');

        usuarioRetornado.codigousuario = varcodigousuario;
        usuarioRetornado.codigogrupousuario = varcodigogrupo;
        usuarioRetornado.nomeusuario = varnomeusuario;
        usuarioRetornado.senha = varsenha;

        if (usuarioRetornado.nomeusuario != null) {
          usuariovalidado = true;
        } else {
          usuariovalidado = false;
          Fluttertoast.showToast(
              msg: "Verifique Usuário e Senha",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
               
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        usuariovalidado = false;
        Fluttertoast.showToast(
            msg: "Verifique Usuário e Senha",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
             
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      return usuarioRetornado;


      } on TimeoutException  catch (e){
        Fluttertoast.showToast(
          msg: "Verifique Conexão",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
           
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      }

    } catch (e) {
     // print('Erro foi: ' + e);
    }
  }
}

class carregarParametros {
  static int get codigemp => 0;
  static bool get controla => false;

  static Future<SELECTPARAMETROS> consultarParametro() async {
    var url = apiHost + apiParametros + '/' + codigoIdLoja.toString();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "CharacterEncoding": "UTF-8"
    };

    Map params = {
      'codigoempresa': codigemp,
    };

    String p = converts.json.encode(params);
    final parametroRetornado = SELECTPARAMETROS(codigemp);
    var response = await http.get(Uri.parse(url));
    jsonMapParametros = response.body;

    if (response.body != '') {
      var parsedJson = converts.json.decode(jsonMapParametros);
      varempresaContro = parsedJson['codigoempresa'];
      varControContro = parsedJson['controlaquantidadedeposito'];
      if(varControContro){
        varGControleqtdDeposito = 1;
      }else{
        varGControleqtdDeposito = 0;
      }

      
      print('Controla Estoque: '+varControContro.toString());
    } else {
      varGControleqtdDeposito = 0;
    }
    return parametroRetornado;
  }
}

class consultarLicenca {
  static String get ntoken => '';

  static Future<SELECTLICENCA> validarTokenMobile() async {
    var url = apiHost + apiLicencaporToken + tokenmobilenoAparelho;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "CharacterEncoding": "UTF-8"
    };

    Map params = {
      'toknemobile': ntoken,
    };

    String s = converts.json.encode(params);
    final licencaRetornada = SELECTLICENCA(ntoken);
    var response = await http.get(Uri.parse(url));
    jsontoMap = response.body;

    if (response.body != '') {
      var parsedJson = converts.json.decode(jsontoMap);
      varGcodigoestacao = parsedJson['codigoestacao'];
      varGnomeestacaomobile = parsedJson['nomeestacaomobile'];
      varGdescricaomobile = parsedJson['descricaomobile'];
      varGnumeroseriemobile = parsedJson['numeroseriemobile'];
      varGversaomobile = parsedJson['versaomobile'];
      varGtokenmobile = parsedJson['tokenmobile'];
      tokenmobilenoServidor = parsedJson['tokenmobile'];

      print(
          'Resultado Final:  Token Servidor $varGtokenmobile, nome da Estação $varGnomeestacaomobile');

      licencaRetornada.codigoestacao = varGcodigoestacao;
      licencaRetornada.nomeestacaomobile = varGnomeestacaomobile;
      licencaRetornada.descricaomobile = varGdescricaomobile;
      licencaRetornada.numeroseriemobile = varGnumeroseriemobile;
      licencaRetornada.versaomobile = varGversaomobile;
      licencaRetornada.tokenmobile = varGtokenmobile;

      tokenvalidado = true;
    } else {
      tokenvalidado = false;
      Fluttertoast.showToast(
          msg: "Token Inválido",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
           
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    return licencaRetornada;
  }
}

class validarTokenEntradaMercadoria {
  static String get tokenEntrada => '';

  static Future<TOKENENTRAMERC> consultaporToken() async {
    var url = apiHost + apiEntradaMercValidToken + vargTokenEntMercDigitado;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "CharacterEncoding": "UTF-8"
    };

    Map params = {
      'toknemobile': tokenEntrada,
    };

    String s = converts.json.encode(params);
    final tokenLicencaRetornada = TOKENENTRAMERC(tokenEntrada);
    var response = await http.get(Uri.parse(url));
    jsonMapTokenEntrada = response.body;

    if (response.body != '') {
      var parsedJson = converts.json.decode(jsonMapTokenEntrada);
      vargTokenEntMerc = parsedJson['tokenmobile'];
      vargTokenEntradaValido = true;
    } else {
      vargTokenEntradaValido = false;
      Fluttertoast.showToast(
          msg: "Token Inválido",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
           
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return tokenLicencaRetornada;
  }
}

_carregarTokenoAparelho() async {
  final objToken = SQLTOKENPHONEDAO();
  idUltToken = await objToken.count();

  if (idUltToken != 0) {
    TOKENPHONEDAO tokenExistente = await tokenRecebido.findById(idUltToken);
    tokenmobilenoAparelho = tokenExistente.token!;
  } else {
    Fluttertoast.showToast(
        msg: 'Informe um Token',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

_recarregarConfig() async {
  final objConfig = SQLCONFIGPHONEDAO();
  idUltConfig = 0;
  idUltConfig = await objConfig.count();

  if (idUltConfig != 0) {
    CONFIGPHONEDAO configExistente = await configRecebida.findById(idUltConfig as int);
    tipoConexao = configExistente.tipoConexao!;
    ipServidor = configExistente.ipServidor!;
    portaServidor = configExistente.portaServidor!;
    apiHost = tipoConexao + ipServidor + ':' + portaServidor;
  } else {
    Fluttertoast.showToast(
        msg: 'Configure o APP',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
