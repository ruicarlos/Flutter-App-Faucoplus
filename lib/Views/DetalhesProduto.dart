import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/utils/dbDao.dart';
import 'package:intl/intl.dart';
import 'package:faucomplus/utils/credit_card_widget.dart';
import 'Principal.dart';

NumberFormat? prodTotalFormat;

String precoVisual = '';
String productImg =
    'https://cestapp.angraz.com.br/1/0' + varG_codigo_barra + '.jpg';
String nEtiquetasStr='';
int qtdint = 0;
double prodTotal = 0;
String prodTotalS = '';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key?key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.add_chart_outlined),
        title: new Text(varG_nome,
            style: TextStyle(fontSize: 15, color: Colors.white)),
        backgroundColor: Color(0xFF3a8e74),
      ),
      body: corpo(),
    );
  }

  corpo() {
    String validarTamanhoPreco = varG_vlr_produto.toString();
    validarTamanhoPreco = validarTamanhoPreco.split('.').last;
    int sizePrice = validarTamanhoPreco.length;
    if (sizePrice == 1) {
      precoVisual = varG_vlr_produto.toString() + '0';
    } else {
      precoVisual = varG_vlr_produto.toString();
    }
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 15),
          Image.network(
            productImg,
            fit: BoxFit.scaleDown,
            height: 150,
            errorBuilder: (BuildContext? context, Object? exception,
                StackTrace? stackTrace) {
              return const Icon(Icons.no_photography,
                  size: 80, color: Color(0xFF3a8e74));
            },
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Color(0xFF3a8e74),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('PREÇO VAREJO R\$ : ' + precoVisual,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          CredicardWidget(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  preImpressaoEtiquetas() async {
    origemClique = 'impressaoetiqueta';
    pesquisaProdutoDigitado = '';
    var verificacao = await _selectMaxEtiquetaItens();

    if (selectMaxEtiqItensnoDb == null) {
      selectMaxEtiqItensnoDb = 0;
    }
    if (selectMaxEtiqItensnoDb == 0) {
      varGLoteRegistrou = false;
      if (envioEtiquetaPende == 'N') {
       var aguardar =await criarLoteEtiqueta();
       if (varGLoteRegistrou==true){
          _loteEtiquetaPendente();
          var aguardar1 = await consultarUltLote.selectmaxLote(context);
       }
       
      }
    } else {
      envioEtiquetaPende = 'S';
      consultarUltLote.selectmaxLote(context);
    }
     if (varGLoteRegistrou==true){
      var aguardar = await _insertEtiquetaItens();
     }else{
 Fluttertoast.showToast(
        msg: "DB Error Reg Lote tb_Mobetiq",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white,
        textColor: Colors.green,
        fontSize: 16.0);
    setState(() {
      qtdEtiquetasaImp = 1;
    });      
     }
   
  }

  _insertEtiquetaItens() async {
    final objetoToken = SQLETIQUETAITENSDAO();
    numdeEtiqItensCadastrados = await objetoToken.count();
    numdeEtiqItensCadastrados = numdeEtiqItensCadastrados! + 1;
    final notaEtiquetaItem = ETIQUETAITENSDAO(numdeEtiqItensCadastrados,
        varG_plu, varGLOTEcodigoid, qtdEtiquetasaImp, varG_vlr_produto);
    final daoEtiquetaItem = SQLETIQUETAITENSDAO();
    daoEtiquetaItem.save(notaEtiquetaItem);

    Fluttertoast.showToast(
        msg: "Etiqueta Salva",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white,
        textColor: Colors.green,
        fontSize: 16.0);
    setState(() {
      qtdEtiquetasaImp = 1;
    });
  }

  _selectMaxEtiquetaItens() async {

        
  final objetoListaEtiquetas = SQLETIQUETAITENSDAO();
  List<ETIQUETAITENSDAO> todosasEtiquetasSalvas =
      await objetoListaEtiquetas.findAll();

  selectMaxEtiqItensnoDb = todosasEtiquetasSalvas.length;
print('Nº  etiquetas Itens: '+selectMaxEtiqItensnoDb.toString());
  
  }

  _loteEtiquetaPendente() {
    if (envioEtiquetaPende == 'N') {
      return Icon(Icons.print, size: 30, color: Color(0xFF3a8e74));
    } else {
      return Icon(
        Icons.print,
        size: 30,
        color: Colors.red,
      );
    }
  }
}
