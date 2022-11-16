import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/Views/leitor.dart';
import 'package:faucomplus/main.dart';

import 'package:faucomplus/utils/contantes.dart';

class TokenEntradadeMercadorias extends StatefulWidget {
  TokenEntradadeMercadorias({Key? key}) : super(key: key);

  @override
  _TokenEntradadeMercadoriasState createState() =>
      _TokenEntradadeMercadoriasState();
}

class _TokenEntradadeMercadoriasState extends State<TokenEntradadeMercadorias> {
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return Container(
      child: Scaffold(
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
          ],
        ),
      ),
    );
  }

  Widget _btSalvarToken() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 10.0,
        onPressed: () async {
          var validarToken =
              await validarTokenEntradaMercadoria.consultaporToken();

          if (vargTokenEntradaValido == true) {
            origemClique = 'ENTRADAMERCADORIA';
            LercodigodeBarras().escanearCodigodeBarras(context);
          } else {
            Fluttertoast.showToast(
                msg: 'Token Inválido',
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
          'VALIDAR',
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

  Widget _insirirToken() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'TOKEN ENTRADA DE MERCADORIA',
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
                color: Colors.black,
                fontFamily: 'Titanone',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.vpn_key_rounded,
                  size: 20,
                  color: Colors.red,
                ),
                hintText: 'TOKEN:',
                hintStyle: kHintTextStyle,
              ),
              onChanged: (valor) async {
                setState(() {
                  vargTokenEntMercDigitado = valor;
                });
              }),
        ),
      ],
    );
  }
}
