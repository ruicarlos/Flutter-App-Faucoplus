import 'package:flutter/material.dart';
import 'package:faucomplus/Views/Principal.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'leitor.dart';

class LoteSugestaoPreco extends StatefulWidget {
  LoteSugestaoPreco({Key? key}) : super(key: key);

  @override
  _LoteSugestaoPrecoState createState() => _LoteSugestaoPrecoState();
}

class _LoteSugestaoPrecoState extends State<LoteSugestaoPreco> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.production_quantity_limits),
        title: new Text('Gerar Lote de Sugestão',
            style: TextStyle(fontSize: 15, color: Colors.white)),
        backgroundColor: corDegradeeInicio,
        elevation: 0,
      ),
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
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 30),
                Text(
                  'USUÁRIO: ' + varGUsuario,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'MOTIVO DA ALTERAÇÃO: ' +
                      varGmotivCodigomotiv.toString() +
                      ' ' +
                      varGmotivDescricaomotiv,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Observação', style: kLabelStyle),
                      SizedBox(height: 10.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 50.0,
                        child: TextField(
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(14.0),
                              hintText: 'Informe uma Observação',
                              hintStyle: kHintTextStyle,
                            ),
                            onChanged: (valor) async {
                              setState(() {
                                if (valor != '') {
                                  varGSugPreObs = valor;
                                }
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 100),
                Column(
                  children: <Widget>[
                    Center(
                        child: ElevatedButton.icon(
                      onPressed: () async {
                        var VamosEsperarumRetorno = await salvarLoteSugestao();
                        if (envioSugestPende == 'S') {
                          origemClique = 'sugestaopreco';

                      if (modo == 'scan') {
                        LercodigodeBarras().escanearCodigodeBarras(context);
                      } else {
                        Navigator.pushReplacementNamed(context, 'PesquisaDigi');
                      }
                        }
                      },
                      icon: Icon(
                        Icons.save_alt_sharp,
                        color: Colors.white,
                      ),
                      label: Text(' GERAR LOTE '),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  salvarLoteSugestao() async {
    var sugestao = await criarLoteSugestaoPreco();
  }
}
