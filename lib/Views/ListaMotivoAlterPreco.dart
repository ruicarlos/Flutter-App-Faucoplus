import 'package:flutter/material.dart';
import 'package:faucomplus/Objetos/Objeto_MotivoAlterPreco.dart';
import 'package:faucomplus/utils/Requisicoes.dart';
import 'package:faucomplus/utils/contantes.dart';

class ListadeMotivosaltPreco extends StatefulWidget {
  ListadeMotivosaltPreco({Key ? key}) : super(key: key);

  @override
  _ListadeMotivosaltPrecoState createState() => _ListadeMotivosaltPrecoState();
}

class _ListadeMotivosaltPrecoState extends State<ListadeMotivosaltPreco> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecione o Motivo da Alteração',
          style: TextStyle(fontSize: 19),
        ),
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
        child: SafeArea(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Expanded(child: _body())
          ],
        )),
      ),
    );
  }

  _body() {
    Future<List<MOTIVOALTERACAOPRECO>?> motivoaltPFuture =
        motivosAlterprecoClass.consultarmotivoAlteracao();
    return FutureBuilder(
      future: motivoaltPFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Não foi possível recarregar"),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text('Carregando...'),
          );
        }

        List<MOTIVOALTERACAOPRECO> varios = snapshot.data as List<MOTIVOALTERACAOPRECO>;

        return _motivosList(varios);
      },
    );
  }

  Container _motivosList(List<MOTIVOALTERACAOPRECO> mmotiv) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
          itemCount: mmotiv.length,
          itemBuilder: (context, index) {
            MOTIVOALTERACAOPRECO itmotiv = mmotiv[index];

            return ListTile(
              title: Text('${itmotiv.descricaomotivo}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black)),
              subtitle: Text('Codigo: ${itmotiv.codigomotivo}',
                  style: TextStyle(fontSize: 15, color: Colors.black)),
              onTap: () {
                varGmotivCodigomotiv = itmotiv.codigomotivo!;
                varGmotivDescricaomotiv = itmotiv.descricaomotivo!;

                print(varGmotivCodigomotiv.toString() +
                    ' Motivo: ' +
                    varGmotivDescricaomotiv);
                Navigator.pushNamed(context, 'LoteSugestap');
              },
            );
          }),
      //   ],
    );
  }
}
