import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/Views/Principal.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/utils/dbDao.dart';
import 'package:date_format/date_format.dart';
import 'leitor.dart';

String valueText ="";

class Balanco extends StatefulWidget {
  Balanco({Key? key}) : super(key: key);

  @override
  _BalancoState createState() => _BalancoState();
}

class _BalancoState extends State<Balanco> {
  TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.production_quantity_limits),
        title: new Text('Inventário de Mercadoria',
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
                SizedBox(height: 20),
                Text('Nº Balanço: ' + vargInvcodbalanco.toString(),
                    style: kLabelStyle),
                SizedBox(height: 20),
                Text('Scanear/Pesquisar o produto', style: kLabelStyle),
                Row(
                  children: [
                    Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            origemClique = 'INVENTARIO';
                            LercodigodeBarras().escanearCodigodeBarras(context);
                          },
                          icon: Icon(Icons.scanner, color: Colors.white),
                          label: Text(' Scanear '),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            origemClique = 'INVENTARIO';
                            Navigator.pushNamed(
                                context, 'PesquisaDigi');
                          },
                          icon: Icon(Icons.keyboard, color: Colors.white),
                          label: Text('Pesquisar'),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Divider(),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 125, right: 125),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Quantidade', style: kLabelStyle),
                      SizedBox(height: 10.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: kBoxDecorationStyle,
                        height: 50.0,
                        child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(14.0),
                              hintText: '  0',
                              hintStyle: kHintTextStyle,
                            ),
                            onChanged: (valor) async {
                              setState(() {
                                if (valor != '') {
                                  vargInvquantLoja = double.parse(valor);
                                }
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                Center(
                    child: ElevatedButton.icon(
                  onPressed: () async {
                    salvarItem();
                  },
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  label: Text(' SALVAR '),
                )),
                SizedBox(height: 30),
                Center(
                    child: ElevatedButton.icon(
                  onPressed: () async {
                    var enviar = await _listarBalancoeEnviar();
                    if (loteBalancoStatus200 == true) {
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Tente Novamente',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.red,
                  ),
                  label: Text('FINALIZAR'),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  salvarItem() {
    if (vargInvquantLoja == 0) {
      Fluttertoast.showToast(
          msg: 'Informe a Quantidade',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _insertItenBalanco();
    }
  }

  Future<void> _displayInserteNumLote(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Informe o Lote'),
            content: TextField(
              onChanged: (value) {
                if (value != '') {
                  setState(() {
                    varGperdaNumloteInformado = value;
                  });
                }
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Numero do Lote"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCELAR'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Salvar'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}

_insertItenBalanco() async {
  final objetoItenBalanco = SQLBALANCOODAO();

  numdItemBalancoCadastradas = await objetoItenBalanco.count();

  numdItemBalancoCadastradas = numdItemBalancoCadastradas! + 1;

  final insertItem = BALANCODAO(
      numdItemBalancoCadastradas,
      vargInvcodbalanco,
      0,
      varG_id_Loja,
      varG_plu,
      vargInvquantLoja,
      0,
      formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]),
      varGcodigousuario);
  final objBalancoItem = SQLBALANCOODAO();
  objBalancoItem.save(insertItem);

  Fluttertoast.showToast(
      msg: 'Item Salvo',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);

  vargInvquantLoja = 0;
}

_listarBalancoeEnviar() async {
  final objetoListadoInventario = SQLBALANCOODAO();
  List<BALANCODAO> inventarioSalvo = await objetoListadoInventario.findAll();

  countIndex = 0;
  loteBalancoStatus200 = false;

  while (countIndex < inventarioSalvo.length) {
    BALANCODAO listContagem = inventarioSalvo[countIndex];

    var url = apiHost + apiBalancoContagemPost;
    Map enviarContagem = {
      "codigobalanco": listContagem.codigobalanco,
      "codcaixa": listContagem.codcaixa,
      "codigoempresa": listContagem.codigoempresa,
      "es_codigo": listContagem.escodigo,
      "quantidade": listContagem.quantidade,
      "quantidadedeposito": listContagem.quantidadedeposito,
      "datasolitacao": listContagem.datasolicitacao,
      "codigousuario": listContagem.codigousuario
    };

    var body = convert.json.encode(enviarContagem);

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      loteBalancoStatus200 = true;
    } else {
      loteBalancoStatus200 = false;
    }

    countIndex = countIndex + 1;
  }
  ;

  if (loteBalancoStatus200) {
    Fluttertoast.showToast(
        msg: 'Enviado com Sucesso!!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
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
