import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/Views/Principal.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/utils/dbDao.dart';
import 'leitor.dart';

String produtoLocal = 'Sem Produto';
String valueText='';

class LancamentoPerdasCControle extends StatefulWidget {
  LancamentoPerdasCControle({Key? key}) : super(key: key);

  @override
  _LancamentoPerdasCControleState createState() =>
      _LancamentoPerdasCControleState();
}

class _LancamentoPerdasCControleState extends State<LancamentoPerdasCControle> {
  TextEditingController _textFieldController = TextEditingController();

  var _mapTipTroca = ['LOJA', 'DEPOSITO'];
  var _EstoqOrigem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.production_quantity_limits),
        title: new Text('Lançamento de Perdas e Trocas',
            style: TextStyle(fontSize: 15, color: Colors.white)),
        backgroundColor: corDegradeeInicio,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              corDegradeeInicio,
              corDegradeeFim,
            ],
            end: Alignment.bottomCenter,
          )),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              selectEstoque(),
              SizedBox(height: 20),
              Text('Scanear/Pesquisar o produto', style: kLabelStyle),
              Row(
                children: [
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          origemClique = 'lancamentodeperdas';
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
                          origemClique = 'lancamentodeperdas';
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
              Text('PRODUTO: ', style: kLabelStyle),
              SizedBox(
                height: 5,
              ),
              Text(produtoLocal,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Divider(),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  InkWell(
                    child: Column(
                      children: [
                        Text('Lote: ', style: kLabelStyle),
                        Text(varGcontrolelote.toString(),
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    onTap: () {
                      _displayInserteNumLote(context);
                    },
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    children: [
                      Text('Serie: ', style: kLabelStyle),
                      Text(varGcontrolenumSerie.toString(),
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(right: 270),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            hintText: '   1',
                            hintStyle: kHintTextStyle,
                          ),
                          onChanged: (valor) async {
                            setState(() {
                              if (valor != '') {
                                qtdPerdas = double.parse(valor);
                              }
                            });
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
              Center(
                  child: ElevatedButton.icon(
                onPressed: () async {
                  salvarTroca();
                },
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Text(' SALVAR '),
              )),
            ],
          ),
        ),
      ),
    );
  }

  salvarTroca() {
    if (qtdPerdas == 0) {
      Fluttertoast.showToast(
          msg: 'Informe a Quantidade',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    if (produtoLocal == 'Sem Produto') {
      Fluttertoast.showToast(
          msg: 'Selecione um Produto',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _insertItenPerda();
    }
  }

  selectEstoque() {
    return Container(
      child: Row(
        children: <Widget>[
          Text("ESTOQUE :  "),
          DropdownButton<String>(
            items: _mapTipTroca.map((String dropDownStringItem) {
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

_insertItenPerda() async {
  final objetoPerda = SQLPERDASITENSDAO();

  numdPerdasCadastradas = await objetoPerda.count();

  numdPerdasCadastradas = numdPerdasCadastradas! + 1;
  final insertperdaItem = PERDASITENSDAO(
      numdPerdasCadastradas,
      varGcodigoempresa,
      varGobs,
      varGcodigousuario,
      varGLotePerdacodigoid,
      varG_plu,
      qtdPerdas,
      0,
      0,
      0);
  final objperda = SQLPERDASITENSDAO();
  objperda.save(insertperdaItem);

  Fluttertoast.showToast(
      msg: 'Adicionado Perda ao DB',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
