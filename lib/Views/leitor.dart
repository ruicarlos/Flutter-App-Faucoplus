import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:faucomplus/Objetos/Objeto_EstoqueLote.dart';
import 'package:faucomplus/Objetos/Objeto_EstoqueSerie.dart';
import 'package:faucomplus/objetos/Objeto_Produto.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/Requisicoes.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/utils/dbDao.dart';
import 'LancamentoPerdas.dart';
import 'Principal.dart';

String valorCodigoBarras='';

class LercodigodeBarras {
  Future<void> escanearCodigodeBarras(context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancelar', true, ScanMode.BARCODE);
    valorCodigoBarras = barcodeScanRes;

    if (valorCodigoBarras == '-1') {
      Fluttertoast.showToast(
          msg: 'Tente Novamente',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    codbarraRecebido = valorCodigoBarras;
    qtdEtiquetasaImp = 1;
    produtoPorCodbarra = false;
    PRODUTOPORCODBARRAS pesquisarProd =
        await pesQuisardeproduto.consultarporCodBarras();

    if (produtoPorCodbarra) {
      if (origemClique == 'impressaoetiqueta') {
        if (varG_plu!=0){
          _insertEtiquetaItens();
        }
        
      } else if (origemClique == 'sugestaopreco') {
        precoSugerido_Str ='';
        Navigator.pushNamed(context, 'PrecoSugest');
      } else if (origemClique == 'consultaitem') {
        Navigator.pushNamed(context, 'DetalheProduto');
      } else if (origemClique == 'lancamentodeperdas') {
        produtoLocal = varG_nome;

        if(varGControleqtdDeposito==1){
          LOTEPORCODIGO  novolote   = await loteporcodigo.consultarloteporcodigo();
          SERIEPORCODIGO novoserie  = await serieporcodigo.consultarserieporcodigo(); 
          Navigator.pushNamed(context, 'LancPerdaCContr');                      
        }else{
          Navigator.pushNamed(context, 'LancPerdas');  
        }  
      }else 
      if (origemClique == 'ENTRADAMERCADORIA') {
        Navigator.pushNamed(context, 'EntMerc');
      } else if (origemClique == 'INVENTARIOCCONTROLE') {
        Fluttertoast.showToast(
            msg: varG_nome,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if(origemClique == 'INVENTARIO'){
                Fluttertoast.showToast(
            msg: varG_nome,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);

      }
    }
  }
}

_insertEtiquetaItens() async {
  final objetoToken = SQLETIQUETAITENSDAO();

  numdeEtiqItensCadastrados = await objetoToken.count();
  numdeEtiqItensCadastrados = numdeEtiqItensCadastrados! + 1;

  final notaEtiquetaItem = ETIQUETAITENSDAO(numdeEtiqItensCadastrados, varG_plu,
      varGLOTEcodigoid, qtdEtiquetasaImp, varG_vlr_produto);
  final daoEtiquetaItem = SQLETIQUETAITENSDAO();
  daoEtiquetaItem.save(notaEtiquetaItem);
  Fluttertoast.showToast(
      msg: 'Etiqueta Adiciona ao Lote',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);
}
