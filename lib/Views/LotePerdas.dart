import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/Views/Principal.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/utils/dbDao.dart';

String produtoLocal = 'Sem Produto';

class LotePerdas extends StatefulWidget {
  LotePerdas({Key? key}) : super(key: key);

  @override
  _LotePerdasState createState() => _LotePerdasState();
}

class _LotePerdasState extends State<LotePerdas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.production_quantity_limits),
        title: new Text('Gerar Lote de Perdas',
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
                  'MOTIVO DA PERDA: ' +
                      varGCodigomotivo.toString() +
                      ' ' +
                      varGdescricaomotivo,
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
                                  varGobs = valor;
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
                      // style: ButtonStyle(),
                      onPressed: () async {
                        salvarTroca();
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

  salvarTroca() async {
    if ("_tipoPerda" == null) {
      Fluttertoast.showToast(
          msg: 'Selecione o Tipo de Troca',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      var teste = await criarLotePerda();

      var espera2 = await _selectMaxPerdasLote();

      print(selectMaxLotePerdasnoDb);

      if (envioPerdaPende == 'S') {
        if (EstoquedeOrigem == true) {
          Navigator.pushNamed(context, 'LancPerdaCContr');
        } else {
          Navigator.pushNamed(context, 'LancPerdas');
        }
      }
      
    }
  }
}


_selectMaxPerdasLote() async {

   final objetoListaPerdaslote = SQLPERDASDAO();
  List<PERDASDAO> todosasperdasSalvaslote =
      await objetoListaPerdaslote.findAll();

  selectMaxLotePerdasnoDb = todosasperdasSalvaslote.length;
print('Nº  Lote perdas: '+selectMaxLotePerdasnoDb.toString());

}
