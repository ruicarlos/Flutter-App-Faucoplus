import 'dart:convert'as convert;
import 'package:faucomplus/Objetos/Objeto_EstoqueLote.dart';
import 'package:faucomplus/Objetos/Objeto_EstoqueSerie.dart';
import 'package:faucomplus/Objetos/Objeto_MotivoAlterPreco.dart';
import 'package:faucomplus/objetos/Objeto_MotivoPerda.dart';
import 'package:http/http.dart' as http;
import 'package:faucomplus/objetos/Objeto_Produto.dart';

import 'contantes.dart';


var  jsontoMapProduto,jsontoMapProdutoDigitado,jsontoMapMotivoPerdas,jsontoMapEstoqueLote, jsontoMapEstoqueSerie, 
jsontoMapLotePerda,jsonMapLoteSugestao, jsonMapMotivoAlte, jsonMapParametros, jsonMapTokenEntrada, jsonMapBalanco;



class pesQuisardeproduto{
  
  static int      get varloc_id_Loja              => 0;	
  static String   get varloc_departamento         => '';
  static String   get varloc_categoria            => '';		
  static String   get varloc_subcategoria         => '';      
  static String   get varloc_marca                => '';
  static String   get varloc_unidade              => ''; 
  static double   get varloc_volume               => 0;
  static String   get varloc_codigo_barra         => ''; 
  static String   get varloc_nome                 => '';
  static String   get varloc_dt_cadastro          => '';
  static String   get varloc_dt_ultima_alteracao  => '';
  static double   get varloc_vlr_produto          => 0.0; 
  static double   get varloc_vlr_promocao         => 0.0;
  static double   get varloc_qtd_estoque_atual    => 0.0;
  static double   get varloc_qtd_estoque_minimo   => 0.0;
  static String   get varloc_descricao            => '';
  static String   get varloc_ativo                => ''; 
  static int      get varloc_plu                  => 0; 
  static double   get varloc_vlr_compra           => 0.0;
  static String   get varloc_validade_proxima     => '';
  static double   get varloc_vlr_atacado          => 0.0;
  static double   get varloc_qtd_atacado          => 0.0;
  static String   get varloc_image_url            => '';
  static int      get varloc_lote                 => 0;
  static int      get varloc_numserie             => 0;

static Future <PRODUTOPORCODBARRAS> consultarporCodBarras() async {
      
      var url =apiHost+apiProdutoporcodbarras+codbarraRecebido!;
  
      Map<String,String> headers = {
        "Content-Type": "application/json",
        "CharacterEncoding":"UTF-8"
      };

      Map params = {
        'codigo_barra'      : varloc_codigo_barra,
      };
  
      String s =convert.json.encode(params);
      final produtoretornado = PRODUTOPORCODBARRAS(varloc_codigo_barra);

 var response = await http.get(Uri.parse(url));
 jsontoMapProduto = response.body;

if (response.body !=''){
  var parsedJson = convert.json.decode(jsontoMapProduto);

  varG_departamento         = parsedJson['departamento'];
  varG_categoria            = parsedJson['categoria'];		
  varG_subcategoria         = parsedJson['subcategoria'];     
  varG_marca                = parsedJson['marca'];
  varG_unidade              = parsedJson['unidade']; 
  varG_volume               = parsedJson['volume']; 
  varG_codigo_barra         = parsedJson['codigo_barra'];  
  varG_nome                 = parsedJson['nome']; 
  varG_dt_cadastro          = parsedJson['dt_cadastro']; 
  varG_dt_ultima_alteracao  = parsedJson['dt_ultima_alteracao']; 
  varG_vlr_produto          = parsedJson['vlr_produto'];  
  varG_vlr_promocao         = parsedJson['vlr_promocao'];  
  varG_qtd_estoque_atual    = parsedJson['qtd_estoque_atual']; 
  varG_qtd_estoque_minimo   = parsedJson['qtd_estoque_minimo']; 
  varG_descricao            = parsedJson['descricao']; 
  varG_ativo                = parsedJson['ativo'];  
  varG_plu                  = parsedJson['plu'];  
  varG_vlr_compra           = parsedJson['vlr_compra'];  
  varG_validade_proxima     = parsedJson['validade_proxima']; 
  varG_vlr_atacado          = parsedJson['vlr_atacado']; 
  varG_qtd_atacado          = parsedJson['qtd_atacado']; 
  varG_image_url            = parsedJson['image_url']; 
  varGcontrolelote          = parsedJson['controlelote']; 
  varGcontrolenumSerie      = parsedJson['controlanumeroserie']; 


  produtoretornado.id_Loja                =varG_id_Loja;                 
  produtoretornado.departamento           =varG_departamento;   
  produtoretornado.categoria              =varG_categoria;  
  produtoretornado.subcategoria           =varG_subcategoria;  
  produtoretornado.marca                  =varG_marca;  
  produtoretornado.unidade                =varG_unidade; 
  produtoretornado.volume                 =varG_volume.toDouble();  
  produtoretornado.codigo_barra           =varG_codigo_barra;  
  produtoretornado.nome                   =varG_nome;
  produtoretornado.dt_cadastro            =varG_dt_cadastro;
  produtoretornado.dt_ultima_alteracao    =varG_dt_ultima_alteracao;
  produtoretornado.vlr_produto            =varG_vlr_produto.toDouble();
  produtoretornado.vlr_promocao           =varG_vlr_promocao.toDouble();
  produtoretornado.qtd_estoque_atual      =varG_qtd_estoque_atual.toDouble();
  produtoretornado.qtd_estoque_minimo     =varG_qtd_estoque_minimo.toDouble();
  produtoretornado.descricao              =varG_descricao;
  produtoretornado.ativo                  =varG_ativo;
  produtoretornado.plu                    =varG_plu;
  produtoretornado.vlr_compra             =varG_vlr_compra.toDouble();
  produtoretornado.validade_proxima       =varG_validade_proxima;
  produtoretornado.vlr_atacado            =varG_vlr_atacado.toDouble();
  produtoretornado.qtd_atacado            =varG_qtd_atacado.toDouble();
  produtoretornado.image_url              =varG_image_url;

if (varG_validade_proxima=='N'){
  varG_validade_proxima = 'Não';
}else{
  varG_validade_proxima = 'Sim'; 
}
  produtoPorCodbarra = true;


}else{
  produtoPorCodbarra =  false;
  
}
  return produtoretornado;  
}
}

class pesQuisardeprodutoDigitado{
  
  static int      get varloc_id_Loja              => 0;	
  static String   get varloc_departamento         => '';
  static String   get varloc_categoria            => '';		
  static String   get varloc_subcategoria         => '';      
  static String   get varloc_marca                => '';
  static String   get varloc_unidade              => ''; 
  static double   get varloc_volume               => 0;
  static String   get varloc_codigo_barra         => ''; 
  static String   get varloc_nome                 => '';
  static String   get varloc_dt_cadastro          => '';
  static String   get varloc_dt_ultima_alteracao  => '';
  static double   get varloc_vlr_produto          => 0.0; 
  static double   get varloc_vlr_promocao         => 0.0;
  static double   get varloc_qtd_estoque_atual    => 0.0;
  static double   get varloc_qtd_estoque_minimo   => 0.0;
  static String   get varloc_descricao            => '';
  static String   get varloc_ativo                => ''; 
  static int      get varloc_plu                  => 0; 
  static double   get varloc_vlr_compra           => 0.0;
  static String   get varloc_validade_proxima     => '';
  static double   get varloc_vlr_atacado          => 0.0;
  static double   get varloc_qtd_atacado          => 0.0;
  static String   get varloc_image_url            => '';
static Future <List<PRODUTOPORDESCRICAO>?> consultarporNome() async {
      
      if (pesquisaProdutoDigitado!=''){
        var url =apiHost+apiListaProdutopornomeeIdloja+pesquisaProdutoDigitado+'/'+codigoIdLoja.toString();

      
  
      Map<String,String> headers = {
        "Content-Type": "application/json",
        "CharacterEncoding":"UTF-8"
      };

      Map params = {
        'nome'      : varloc_nome,
      };
  
      String s =convert.json.encode(params);
      final produtoretornado = PRODUTOPORDESCRICAO(varloc_nome);

 var response = await http.get(Uri.parse(url));
 jsontoMapProdutoDigitado = response.body;


if (response.body !=''){

    List mapResponse = convert.json.decode(jsontoMapProdutoDigitado);

    final lstProdutos = <PRODUTOPORDESCRICAO>[];

    for (Map map in mapResponse){
      PRODUTOPORDESCRICAO p = PRODUTOPORDESCRICAO.fromJson(map);
      lstProdutos.add(p);
    }

    return lstProdutos;
 
 
}
  }
  }
}

class motivosPerdasClass{
 
  static int      get varcodigomotivo            => 0;	
  static String   get vardescricaomotivo         => '';

  static Future <List<MOTIVOPERDA>?> consultarmotivo() async {

        var url =apiHost+apiMotivoPerdaTodos;
 
        Map<String,String> headers = {
          "Content-Type": "application/json",
          "CharacterEncoding":"UTF-8"
        };

        Map params = {
          'descricaomotivo'      : vardescricaomotivo,
        };  
  
        String s =convert.json.encode(params);
        final motivosretornado = MOTIVOPERDA(vardescricaomotivo);

        var response = await http.get(Uri.parse(url));
        jsontoMapMotivoPerdas = response.body;
    
        if (response.body !=''){

          List mapResponse = convert.json.decode(jsontoMapMotivoPerdas);
          final listageMotivo = <MOTIVOPERDA>[];

          for (Map map in mapResponse){
            MOTIVOPERDA p = MOTIVOPERDA.fromJson(map);
            listageMotivo.add(p);
          }

          return listageMotivo;
        }
    
  }
}


class motivosAlterprecoClass{
 
  static int      get varcodigomotivo            => 0;	
  static String   get vardescricaomotivo         => '';
  static String   get varinativoMotivo           => '';

  static Future <List<MOTIVOALTERACAOPRECO>?> consultarmotivoAlteracao() async {

        var url =apiHost+apimotivosparaaltepreco;
 
        Map<String,String> headers = {
          "Content-Type": "application/json",
          "CharacterEncoding":"UTF-8"
        };

        Map params = {
          'descricaomotivo'      : vardescricaomotivo,
        };  
  
        String s =convert.json.encode(params);
        final motivosAlteretornado = MOTIVOALTERACAOPRECO(vardescricaomotivo);

        var response = await http.get(Uri.parse(url));
        jsonMapMotivoAlte = response.body;
    
        if (response.body !=''){

          List mapResponse = convert.json.decode(jsonMapMotivoAlte);
          final listageMotivoalteracaopreco = <MOTIVOALTERACAOPRECO>[];

          for (Map map in mapResponse){
            MOTIVOALTERACAOPRECO p = MOTIVOALTERACAOPRECO.fromJson(map);
            listageMotivoalteracaopreco.add(p);
          }

          return listageMotivoalteracaopreco;
        }
    
  }
}


class loteporcodigo{

  static int        get varcodigoloteproduto      => 0;	
  static int        get varcodigoempresa          => 0;
  static double     get vares_codigo              => 0.0;
  static String     get vardescricaoloteproduto   => '';
  static double     get varquantidade             => 0.0;
  static String     get vardatafabricacao         => '';
  static String     get vardatavalidadelote       => '';

  static Future <LOTEPORCODIGO> consultarloteporcodigo() async {

        var url =apiHost+apiLoteporCodigo+varGcontrolelote.toString();
   //     var url =apiHost+apiLoteporCodigo+varGLOTEcodigoid.toString();
 
        Map<String,String> headers = {
          "Content-Type": "application/json",
          "CharacterEncoding":"UTF-8"
        };

        Map params = {
          'codigoempresa '      : varcodigoempresa ,
        };  
  
        String s =convert.json.encode(params);
        final loteretornado = LOTEPORCODIGO(varcodigoempresa);

        var response = await http.get(Uri.parse(url));
        jsontoMapEstoqueLote = response.body;
    

if (response.body !=''){


  var parsedJson = convert.json.decode(jsontoMapEstoqueLote);
  
  varGEstLotecodigoloteproduto          = parsedJson['codigoloteproduto'];
  varGEstLotecodigoempresa              = parsedJson['codigoempresa'];
  varGEstLotees_codigo                  = parsedJson['es_codigo'];
  varGEstLotedescricaoloteproduto       = parsedJson['descricaoloteproduto'];
  varGEstLotequantidade                 = parsedJson['quantidade'];
  varGEstLotedatafabricacao             = parsedJson['datafabricacaolote'];
  varGEstLotedatavalidadelote           = parsedJson['datavalidadelote'];
  
}


    return loteretornado;
 
}
}

class serieporcodigo{

  static int        get varSeriecodigoempresa     => 0;	
  static int        get varcodigoserie            => 0;
  static int        get vares_codigo              => 0;
  static String     get varnumeroserie            => '';

  static Future <SERIEPORCODIGO> consultarserieporcodigo() async {

        var url =apiHost+apiSerieporCodigo+varGcontrolenumSerie.toString();
 
        Map<String,String> headers = {
          "Content-Type": "application/json",
          "CharacterEncoding":"UTF-8"
        };

        Map params = {
          'codigoempresa '      : varSeriecodigoempresa ,
        };  
  
        String s =convert.json.encode(params);
        final serieretornado = SERIEPORCODIGO(varSeriecodigoempresa);

        var response = await http.get(Uri.parse(url));
        jsontoMapEstoqueSerie = response.body;
    

if (response.body !=''){


  var parsedJson = convert.json.decode(jsontoMapEstoqueSerie);

  
 varGEstSeriecodigoempresa          =parsedJson['codigoempresa'];
 varGEstSeriecodigoserie            =parsedJson['codigoserie'];
  varGEstSeriees_codigo             =parsedJson['es_codigo'];
  varGEstSerienumeroserie           =parsedJson['numeroserie'];
  
}


    return serieretornado;
 
}
}



