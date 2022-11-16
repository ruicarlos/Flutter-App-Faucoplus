import 'package:flutter/material.dart';
import 'package:faucomplus/objetos/Objeto_MotivoPerda.dart';
import 'package:faucomplus/utils/Requisicoes.dart';
import 'package:faucomplus/utils/contantes.dart';

class ListadeMotivosperdas extends StatefulWidget {
  ListadeMotivosperdas({Key? key}) : super(key: key);

  @override
  _ListadeMotivosperdasState createState() => _ListadeMotivosperdasState();
}

class _ListadeMotivosperdasState extends State<ListadeMotivosperdas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecione o Motivo da Perda',
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
    Future<List<MOTIVOPERDA>?> motivoperdaFuture =
        motivosPerdasClass.consultarmotivo();
    return FutureBuilder(
      future: motivoperdaFuture,
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

        List<MOTIVOPERDA> produtos = snapshot.data as List<MOTIVOPERDA>;

        return _productList(produtos);
      },
    );
  }

  Container _productList(List<MOTIVOPERDA> motivs) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
          itemCount: motivs.length,
          itemBuilder: (context, index) {
            MOTIVOPERDA itmotiv = motivs[index];

            return ListTile(
              title: Text('${itmotiv.descricaomotivo}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black)),
              subtitle: Text('Codigo: ${itmotiv.codigomotivo}',
                  style: TextStyle(fontSize: 15, color: Colors.black)),
              onTap: () {
                varGCodigomotivo = itmotiv.codigomotivo!;
                varGdescricaomotivo = itmotiv.descricaomotivo!;
                Navigator.pushNamed(context, 'LotePerda');
              },
            );
          }),
      //   ],
    );
  }
}
