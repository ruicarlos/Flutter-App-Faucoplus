import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/main.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/utils/dbDao.dart';
import 'package:flutter/services.dart';

int? numdeConfigCadastrados = 0;
int? idUltConfig = 0;
final configRecebida = SQLCONFIGPHONEDAO();

String iplocal = '';
String conexaoloca = 'http://';
String portalocal = '8080';

class ConfigPage extends StatefulWidget {
  ConfigPage({Key? key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  void initState() {
    _carregarConfig();
    iplocal = '';
    conexaoloca = 'http://';
    portalocal = '8080';
    super.initState();
  }
 
   // Future<bool> _retornar() {
    Future<Object?> _retornar() {
		return 
	  Navigator.pushNamed(context, 'Token');
  }

  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    return 		Scaffold(
      backgroundColor: Color(0xFF007C82),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            corDegradeeInicio,
            corDegradeeFim,
          ],
          end: Alignment.bottomCenter,
        )),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                  'IPHOST: ' +
                      ipServidor +
                      '\nCONEXÃO: ' +
                      tipoConexao +
                      '\nPORTA: ' +
                      portaServidor,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 70.0),
              _insirirIp(),
              SizedBox(height: 10.0),
              _insirirConexao(),
              SizedBox(height: 10.0),
              _insirirPorta(),
              SizedBox(height: 20.0),
              _btSalvarConfig(),
              SizedBox(height: 20.0),
              mac(),
              SizedBox(height: 20.0),
              mei(),

            ],
          ),
        ),
      ),
    );
  }

  Widget _btSalvarConfig() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 10.0,
        onPressed: () async {
          if ((iplocal != '') && (conexaoloca != '') && (portalocal != '')) {
            tipoConexao = conexaoloca;
            ipServidor = iplocal;
            portaServidor = portalocal;
            _insertConfig(context);
          }  if ((iplocal != '') && (conexaoloca == '') && (portalocal == '')) {
            tipoConexao = tipoConexao;
            ipServidor = iplocal;
            portaServidor = portaServidor;
            _insertConfig(context);
          }else {
            Fluttertoast.showToast(
                msg: 'Verifique as Configurações',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.white)),
        color: Color(0xFF28353d),
        child: Text(
          'SALVAR CONFIGURAÇÃO',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _insirirIp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'IP',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Titanone',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.network_cell,
                  size: 20,
                  color: Color(0xFF026F75),
                ),
                //hintText: ipServidor,
                hintStyle: kHintTextStyle,
              ),
              onChanged: (valor) async {
                setState(() {
                  iplocal = valor;
                });
              }),
        ),
      ],
    );
  }

  Widget _insirirConexao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'CONEXÃO',
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
                  Icons.network_check,
                  size: 20,
                  color: Color(0xFF026F75),
                ),
                hintStyle: kHintTextStyle,
                hintText: conexaoloca
              ),
              onChanged: (valor) async {
                setState(() {
                  conexaoloca = valor;
                });
              }),
        ),
      ],
    );
  }

  Widget _insirirPorta() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'PORTA',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'Titanone',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.portable_wifi_off,
                  size: 20,
                  color: Color(0xFF026F75),
                ),
                hintStyle: kHintTextStyle,
              ),
              onChanged: (valor) async {
                setState(() {
                  portalocal = valor;
                });
              }),
        ),
      ],
    );
  }


  Widget mac() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mac',
          style: kLabelStyle,
        ),
        SizedBox(height: 3.0),
        Container(
          alignment: Alignment.centerLeft,
         // decoration: kBoxDecorationStyle,
          height: 50.0,
          child: InkWell(
            child: Text(macAdress),
            onTap: (){
              Clipboard.setData(ClipboardData(text: macAdress));
              Fluttertoast.showToast(
                msg:"Mac Copiado",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
                fontSize: 16.0
              );
            }            
            )
        ),
      ],
    );
  }

  Widget mei() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Imei',
          style: kLabelStyle,
        ),
        SizedBox(height: 3.0),
        Container(
          alignment: Alignment.centerLeft,
         // decoration: kBoxDecorationStyle,
          height: 50.0,
          child: InkWell(
            child: Text(varGemeidoAparelho),
            onTap: (){
              Clipboard.setData(ClipboardData(text: varGemeidoAparelho));
              Fluttertoast.showToast(
                msg:"Imei Copiado",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
                fontSize: 16.0
              );
            }
            )
        ),
      ],
    );
  }




}





_insertConfig(context) async {
  final objetoConfiguracao = SQLCONFIGPHONEDAO();

  objetoConfiguracao.deleteAll();
  numdeConfigCadastrados = await objetoConfiguracao.count();

  numdeConfigCadastrados = numdeConfigCadastrados! + 1;

  final novaConfig = CONFIGPHONEDAO(
      numdeConfigCadastrados, tipoConexao, ipServidor, portaServidor, 1);
  final daoConfi = SQLCONFIGPHONEDAO();
  daoConfi.save(novaConfig);
  _recarregarConfig(context);
}

_carregarConfig() async {
  final objConfig = SQLCONFIGPHONEDAO();
  idUltConfig = await objConfig.count();

  if (idUltConfig != 0) {
    CONFIGPHONEDAO configExistente = await configRecebida.findById(idUltConfig as int);
    tipoConexao = configExistente.tipoConexao!;
    ipServidor = configExistente.ipServidor!;
    portaServidor = configExistente.portaServidor!;
  }
}

_recarregarConfig(context) async {
  final objConfig = SQLCONFIGPHONEDAO();
  idUltConfig = await objConfig.count();

  if (idUltConfig != 0) {
    CONFIGPHONEDAO configExistente = await configRecebida.findById(idUltConfig as int);
    tipoConexao = configExistente.tipoConexao!;
    ipServidor = configExistente.ipServidor!;
    portaServidor = configExistente.portaServidor!;
    apiHost = tipoConexao + ipServidor + ':' + portaServidor;
    Fluttertoast.showToast(
        msg: 'Novas Configurações Salva',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
  } else {}
}
