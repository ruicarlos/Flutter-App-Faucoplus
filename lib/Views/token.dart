import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/utils/dbDao.dart';

int? numdetokensCadastrados = 0;
int? idUltToken = 0;
final tokenRecebido = SQLTOKENPHONEDAO();

class TokenPage extends StatefulWidget {
  TokenPage({Key? key}) : super(key: key);

  @override
  _TokenPageState createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  @override
  void initState() {
    _carregarToken();
    super.initState();
  }
/*
  Future<bool> _retornar() {
    return
        Navigator.of(context).pushNamed('login');
  }
  */

  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                corDegradeeInicio,
                corDegradeeFim,
              ],
              end: Alignment.bottomCenter,
            )),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                //    vertical: 120.0,
                vertical: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 270.0),
                  _insirirToken(),
                  SizedBox(height: 20.0),
                  _btSalvarToken(),
                ],
              ),
            ),
          ),
          _logoSobreposta(),
        ],
      ),
    );
  }

  Widget _logoSobreposta() {
    return Container(
      padding: EdgeInsets.only(top: 50),
      alignment: Alignment.topCenter,
      child: Image.asset(
        'assets/logo.png',
        height: 150,
        width: 170,
      ),
    );
  }

  Widget _btSalvarToken() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF026F75))),
        child: Text(
          "Salvar Token",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
        ),
        onPressed: () async {
          if (tokenmobilenoAparelho != '') {
            _insertToken(context);
          } else {
            Fluttertoast.showToast(
                msg: 'Informe um Token',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        onLongPress: () {
          Navigator.pushNamed(context, 'Config');
        },
      ),
    );
  }

  Widget _insirirToken() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'INSIRA O TOKEN',
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
                  Icons.vpn_key_rounded,
                  size: 20,
                  color: Color(0xFF026F75),
                ),
                hintText: 'TOKEN: 5S7415SW',
                hintStyle: kHintTextStyle,
              ),
              onChanged: (valor) async {
                setState(() {
                  tokenmobilenoAparelho = valor;
                });
              }),
        ),
      ],
    );
  }
}

_insertToken(context) async {
  final objetoToken = SQLTOKENPHONEDAO();

  objetoToken.deleteAll();
  numdetokensCadastrados = await objetoToken.count();

  numdetokensCadastrados = numdetokensCadastrados! + 1;

  final novoToken =
      TOKENPHONEDAO(numdetokensCadastrados, tokenmobilenoAparelho);
  final daoToken = SQLTOKENPHONEDAO();
  daoToken.save(novoToken);
  Fluttertoast.showToast(
      msg: 'Token Salvo',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
  Navigator.pop(context);
}

_carregarToken() async {
  final objToken = SQLTOKENPHONEDAO();
  idUltToken = await objToken.count();

  if (idUltToken != 0) {
    TOKENPHONEDAO tokenExistente = await tokenRecebido.findById(idUltToken);
    tokenmobilenoAparelho = tokenExistente.token!;
  }
}
