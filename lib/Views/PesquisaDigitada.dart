import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/Objetos/Objeto_EstoqueLote.dart';
import 'package:faucomplus/Objetos/Objeto_EstoqueSerie.dart';
import 'package:faucomplus/objetos/Objeto_Produto.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:faucomplus/utils/Requisicoes.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:faucomplus/utils/dbDao.dart';
import 'LancamentoPerdas.dart';
import 'Principal.dart';

String linkfoto=''; 
String prodigi=''; 

class PesquisarProduto extends StatefulWidget {
  PesquisarProduto({Key ? key}) : super(key: key);

  @override
  _PesquisarProdutoState createState() => _PesquisarProdutoState();
}
  
class _PesquisarProdutoState extends State<PesquisarProduto> {
  @override
/*
Future<bool> _onbackPressed()async {
     return Navigator.pushReplacementNamed(context, 'Principal');
  }
*/
  Future<bool> _onbackPressed() async{
    return (await  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Deseja Voltar?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Não',
                style: TextStyle(color: Colors.green, fontSize: 20)),
          ),
          FlatButton(
            onPressed: () => Navigator.pushReplacementNamed(context, 'Principal'),
            child:
                Text('Sim', style: TextStyle(color: Colors.red, fontSize: 20)),
          ),
        ],
      ),
    )) ?? false;
  }

  Widget build(BuildContext context) {
    return 
    WillPopScope(
      onWillPop: _onbackPressed,
      child: 
      Scaffold(
      
      appBar: AppBar(
        title: Text('Pesquisa de Produto',style: TextStyle(fontSize: 19),),
        backgroundColor: Color(0xFF3a8e74),
      ),
      backgroundColor: Colors.white60,
      body: 
      SafeArea(
        
            child: Column(
              
              children: <Widget>[
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Container(
                   padding: EdgeInsets.only(left: 5, right: 5), 
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10.0),
                     color: Colors.white,
                   ),
                   height: 50.0,
                    child:  
                      new TextField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black, fontFamily: 'Titanone',),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(Icons.keyboard, size: 30,color: Color(0xFF3a8e74),),
                          hintText: '  DIGITE A DESCRIÇÃO AQUI',
                          hintStyle: TextStyle(color: Colors.black),
                          ),
                        onChanged: (prodigi)async{
                          setState(() {
                            pesquisaProdutoDigitado = prodigi;                       
                          });
                        } 
                        
                      ),
                  ),
                ),
              
                Expanded(child: _body())
            ],
          )  

        ),


    ),
    );
    
  }



_body() { 
 
    Future <List<PRODUTOPORDESCRICAO>?> productFuture = pesQuisardeprodutoDigitado.consultarporNome(); 
    return FutureBuilder(
    future: productFuture,
    builder: (context, snapshot){
      
      if(snapshot.hasError){
          return Center(
            child: Text("Não foi possível recarregar"),
          );
      } 

      if(!snapshot.hasData){
        return Center(
         child: Text('Digite o nome do produto acima'),
        );
      }

      List<PRODUTOPORDESCRICAO> produtos = snapshot.data as List<PRODUTOPORDESCRICAO>;
      
      return _productList(produtos);

      
    },
  );
  }



Container _productList(List<PRODUTOPORDESCRICAO> prodts){
  

  return Container(
    padding: EdgeInsets.all(8),
      child:
        ListView.builder(
          itemCount: prodts.length,
          itemBuilder:(context,index){
          
            PRODUTOPORDESCRICAO nvprodt = prodts[index];
             String validarTamanhoPreco= nvprodt.vlr_produto.toString();
             String precoVisualPesquisa='';
              validarTamanhoPreco = validarTamanhoPreco.split('.').last;
              int sizePrice = validarTamanhoPreco.length;
              if(sizePrice == 1) {
                precoVisualPesquisa = nvprodt.vlr_produto.toString()+'0';
              }else{
                precoVisualPesquisa = nvprodt.vlr_produto.toString();
              }
            
              return ListTile(
                title:  Text('${nvprodt.nome}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                subtitle: Text('Seção: ${nvprodt.categoria}',style: TextStyle(fontSize: 15, color: Colors.white)),
                trailing:Container(
                  child: Column(
                    children: [
                      Text('R\$${precoVisualPesquisa}',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                      SizedBox(height: 3,),
                      Text('Estoque ${nvprodt.qtd_estoque_atual}',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11, color: Colors.black)),
                    ],
                  ),
                ),
                
                onTap: ()async{

                  print(nvprodt.codigo_barra);

                  codbarraRecebido = nvprodt.codigo_barra;
                  qtdEtiquetasaImp = 1;      
                  produtoPorCodbarra = false;
                  PRODUTOPORCODBARRAS pesquisarProd  = await pesQuisardeproduto.consultarporCodBarras();

                  if(produtoPorCodbarra){
  
                  if (origemClique=='impressaoetiqueta'){

                    if (varG_plu!=0){
                      _insertEtiquetaItens();   
                    }
                     
                  setState(() {
                    pesquisaProdutoDigitado ='';
                    prodigi ='';
                  });
    
                  }else
                  if(origemClique=='sugestaopreco'){
                    precoSugerido_Str ='';
                    Navigator.pushNamed(context, 'PrecoSugest');      
                  }else
                  if(origemClique=='consultaitem'){   
                    Navigator.pushNamed(context, 'DetalheProduto');  
                  }else
                    if(origemClique=='lancamentodeperdas'){
                      produtoLocal = varG_nome;  

                      if(varGControleqtdDeposito==1){
                        LOTEPORCODIGO  novolote   = await loteporcodigo.consultarloteporcodigo();
                        SERIEPORCODIGO novoserie  = await serieporcodigo.consultarserieporcodigo(); 
                        Navigator.pushNamed(context, 'LancPerdaCContr');                      
                      }else{
                        Navigator.pushNamed(context, 'LancPerdas');  
                      }                   
/*
                      if (EstoquedeOrigem == true) {
                        
                      } else {
                        
                      }
 */
                    }else
                    if(origemClique=='INVENTARIOCCONTROLE'){
                       Navigator.pop(context,true);
                    }
     
                  }  
                },
              );
       
          }
 
        ),
   //   ],
  );

}


}

_insertEtiquetaItens()async{
  final objetoToken = SQLETIQUETAITENSDAO();

  numdeEtiqItensCadastrados = await objetoToken.count();

  numdeEtiqItensCadastrados = numdeEtiqItensCadastrados!+1;


  final notaEtiquetaItem = ETIQUETAITENSDAO(numdeEtiqItensCadastrados, varG_plu, varGLOTEcodigoid, qtdEtiquetasaImp, varG_vlr_produto);
  final daoEtiquetaItem = SQLETIQUETAITENSDAO();
  daoEtiquetaItem.save(notaEtiquetaItem);
  
  Fluttertoast.showToast(
    msg: 'Adicionado ao Lote',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0
  );

}