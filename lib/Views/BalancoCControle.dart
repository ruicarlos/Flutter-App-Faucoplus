import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/Views/Principal.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/utils/dbDao.dart';
import 'package:date_format/date_format.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'leitor.dart';

String valueText="";

class BalancoCControle extends StatefulWidget {
  BalancoCControle({Key ?key}) : super(key: key);

  @override
  _BalancoCControleState createState() => _BalancoCControleState();
}

class _BalancoCControleState extends State<BalancoCControle> {
  TextEditingController _textFieldController = TextEditingController();

  var _mapESTOQUE = ['LOJA', 'DEPOSITO'];
  var _EstoqOrigem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.production_quantity_limits),
        title: new Text('Inventário de Mercadoria',
            style: TextStyle(fontSize: 15, color: Colors.white)),
        backgroundColor: Color(0xFF3a8e74),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              selectEstoque(),
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
                          origemClique = 'INVENTARIOCCONTROLE';
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
                          origemClique = 'INVENTARIOCCONTROLE';
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
                            color: Colors.white,
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
                                vargInvquantDeposito = double.parse(valor);
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
                  salvarItemBalanco();
                },
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Text('  SALVAR '),
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
    );
  }

  salvarItemBalanco() {
    if (vargInvquantDeposito == 0) {
      Fluttertoast.showToast(
          msg: 'Informe a Quantidade',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (_EstoqOrigem == null) {
      Fluttertoast.showToast(
          msg: 'Informe a Origem',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _insertItenBalancoDeposito();
    }
  }

  selectEstoque() {
    return Container(
      child: Row(
        children: <Widget>[
          Text("ESTOQUE :  "),
          DropdownButton<String>(
            items: _mapESTOQUE.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: (String? novoItemSelecionado) {
              _dropDownItemSelected(novoItemSelecionado as String);
              setState(() {
                this._EstoqOrigem = novoItemSelecionado;
                EstoquedeOrigem = _EstoqOrigem;
              });
            },
            value: _EstoqOrigem,
            dropdownColor: Colors.blue[50],
          ),
          Text('   '),
        ],
      ),
      alignment: Alignment.topLeft,
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      this._EstoqOrigem = novoItem;
    });
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

_insertItenBalancoDeposito() async {
  final objetoItenBalanco = SQLBALANCOODAO();

  numdItemBalancoCadastradas = await objetoItenBalanco.count();

  numdItemBalancoCadastradas = numdItemBalancoCadastradas! + 1;

  final insertItem = BALANCODAO(
      numdItemBalancoCadastradas,
      vargInvcodbalanco,
      0,
      varG_id_Loja,
      varG_plu,
      0,
      vargInvquantDeposito,
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

  vargInvquantDeposito = 0;
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
      "escodigo": listContagem.escodigo,
      "quantidade": listContagem.quantidade,
      "quantidadedeposito": listContagem.quantidadedeposito,
      "datasolicitacao": listContagem.datasolicitacao,
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
