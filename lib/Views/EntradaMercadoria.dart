import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/Views/Principal.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/utils/dbDao.dart';
import 'leitor.dart';

class EntradaItens extends StatefulWidget {
  EntradaItens({Key ? key}) : super(key: key);

  @override
  _EntradaItensState createState() => _EntradaItensState();
}

class _EntradaItensState extends State<EntradaItens> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.add_chart_outlined),
        title: new Text('Entrada de Itens'),
        backgroundColor: corDegradeeInicio,
        elevation: 0,
      ),
      body: corpo(),
    );
  }

  corpo() {
    return Container(
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
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
              child: Text(
                'Codigo de Barras:   ${varG_codigo_barra}',
                style: TextStyle(fontFamily: "Acme"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
              child: Text(
                'Código do Produto:   ${varG_plu}',
                style: TextStyle(fontFamily: "Acme"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
              child: Text(
                'Token Recebimento:   ${vargTokenEntMerc}',
                style: TextStyle(fontFamily: "Acme"),
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Quantidade Recebida', style: kLabelStyle),
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
                        prefixIcon: Icon(Icons.space_dashboard,
                            size: 25, color: Colors.white),
                        hintText: 'Quantidade',
                        hintStyle: kHintTextStyle,
                      ),
                      onChanged: (valor) async {
                        setState(() {
                          vargEntMercQuant = double.parse(valor);
                        });
                      }),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Quantidade Peças', style: kLabelStyle),
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
                        prefixIcon: Icon(Icons.fact_check,
                            size: 25, color: Colors.white),
                        hintText: 'Nº Peças',
                        hintStyle: kHintTextStyle,
                      ),
                      onChanged: (valor) async {
                        setState(() {
                          vargEntMercQuant = double.parse(valor);
                        });
                      }),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: ElevatedButton.icon(
              onPressed: () async {
                var aguardar = await _insertItensdaEntrada();
              },
              icon: Icon(Icons.save),
              label: Text("Salvar"),
            ),
          ),
        ],
      ),
    );
  }

  _insertItensdaEntrada() async {
    final obejtoItensEntrada = SQLENTRADAITENSDAO();

    ENTRADAITENSDAO existe = await obejtoItensEntrada.findByTokenAndEscodigo(
        vargTokenEntMerc, varG_plu);

    numdeItensdaEntradaCadastrados = await obejtoItensEntrada.count();
    numdeItensdaEntradaCadastrados = numdeItensdaEntradaCadastrados! + 1;

    int identificadoritem = 0;
    String tokenexistente = '';
    if (existe != null) {
      tokenexistente = existe.tokenmobile!;
      identificadoritem = existe.id!;
    } else {
      tokenexistente = '';
    }

    if (tokenexistente == '') {
      final addnovo = ENTRADAITENSDAO(
          numdeItensdaEntradaCadastrados,
          vargTokenEntMerc,
          varG_plu,
          varG_codigo_barra,
          vargEntMercQuant,
          vargEntMercQuantpeca);
      final daoEntradaItem = SQLENTRADAITENSDAO();
      daoEntradaItem.save(addnovo);

      Fluttertoast.showToast(
          msg: 'Item Salvo',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      origemClique = 'ENTRADAMERCADORIA';
      LercodigodeBarras().escanearCodigodeBarras(context);
    } else {
      Fluttertoast.showToast(
          msg: 'Item já Bipado',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      var deletarEntrada = await obejtoItensEntrada.delete(identificadoritem);

      Fluttertoast.showToast(
          msg: 'Deletando...',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      final addnovo = ENTRADAITENSDAO(
          numdeItensdaEntradaCadastrados,
          vargTokenEntMerc,
          varG_plu,
          varG_codigo_barra,
          vargEntMercQuant,
          vargEntMercQuantpeca);
      final daoEntradaItem = SQLENTRADAITENSDAO();
      daoEntradaItem.save(addnovo);

      Fluttertoast.showToast(
          msg: 'Item Salvo',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      origemClique = 'ENTRADAMERCADORIA';
      LercodigodeBarras().escanearCodigodeBarras(context);
    }
  }
}
