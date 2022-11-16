import 'dart:async';
import 'package:faucomplus/utils/db_helper.dart';
import 'package:faucomplus/utils/Classes_Dao_Sql.dart';
import 'package:sqflite/sqflite.dart';

class SQLTOKENPHONEDAO {

  Future<Database?> get db => DatabaseHelper.getInstance().db;

  Future<int?> save(TOKENPHONEDAO meuToken) async {
    var dbClient = await db;
    var id = await dbClient?.insert("tokenphone", meuToken.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    print('salvou id: $id');
    return id;
  }

  Future<List<TOKENPHONEDAO>> findAll() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select * from tokenphone');
    final tokenCadastrados = list.map<TOKENPHONEDAO>((json) => TOKENPHONEDAO.fromJson(json)).toList();
    return tokenCadastrados;
  }

  Future<TOKENPHONEDAO> findById(int? id) async {
    var dbClient = await db;
    final list =  await dbClient!.rawQuery('select * from tokenphone where id = ?', [id]);

    if (list.length > 0) {
      return new TOKENPHONEDAO.fromJson(list.first);
    }
    return TOKENPHONEDAO.fromJson(list.first);
  }

  Future<bool> exists(TOKENPHONEDAO meuToken) async {
    TOKENPHONEDAO tk = await findById(meuToken.id);
    var exists = tk != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from tokenphone');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(String token) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from tokenphone where id = ?', [token]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from tokenphone');
  }
}
 
class SQLCONFIGPHONEDAO {

  Future<Database?> get db => DatabaseHelper.getInstance().db;

  Future<int> save(CONFIGPHONEDAO minhaConfig) async {
    var dbClient = await db;
    var id = await dbClient!.insert("config", minhaConfig.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    print('salvou id: $id');
    return id;
  }

  Future<List<CONFIGPHONEDAO>> findAll() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select * from config');
    final configCadastrados = list.map<CONFIGPHONEDAO>((json) => CONFIGPHONEDAO.fromJson(json)).toList();
    return configCadastrados;
  }

  Future<CONFIGPHONEDAO> findById(int id) async {
    var dbClient = await db;
    final list =  await dbClient!.rawQuery('select * from config where id = ?', [id]);

    if (list.length > 0) {
      return new CONFIGPHONEDAO.fromJson(list.first);
    }
    return CONFIGPHONEDAO.fromJson(list.first);
  }

  Future<bool> exists(CONFIGPHONEDAO minhaconfig) async {
    CONFIGPHONEDAO config = await findById(minhaconfig.id as int);
    var exists = config != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from config');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(String config) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from config where id = ?', [config]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from config');
  }
}

class SQLETIQUETAITENSDAO {

  Future<Database?> get db => DatabaseHelper.getInstance().db;

  Future<int> save(ETIQUETAITENSDAO minhaEtiqueta) async {
    var dbClient = await db;
    var id = await dbClient!.insert("etiquetasitens", minhaEtiqueta.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('salvou id: $id');
    return id;
  }

  Future<List<ETIQUETAITENSDAO>> findAll() async {
    final dbClient = await db;

    final list = await dbClient!.rawQuery('select * from etiquetasitens');

    final etiquetaItensCadastrado = list.map<ETIQUETAITENSDAO>((json) => ETIQUETAITENSDAO.fromJson(json)).toList();

    return etiquetaItensCadastrado;
  }

  Future<ETIQUETAITENSDAO> findById(int id) async {
    var dbClient = await db;
    final list = await dbClient!.rawQuery('select * from etiquetasitens where id = ?', [id]);

    if (list.length > 0) {
      return new ETIQUETAITENSDAO.fromJson(list.first);
    }

    return ETIQUETAITENSDAO.fromJson(list.first);
  }

  Future<bool> exists(ETIQUETAITENSDAO minhaEtiqueta) async {
    ETIQUETAITENSDAO et = await findById(minhaEtiqueta.id as int);
    var exists = et != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from etiquetasitens');
    return Sqflite.firstIntValue(list);
  }


  Future<int?> max() async{
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select max(id) from etiquetasitens');
    return Sqflite.firstIntValue(list);   
  }

  Future<int> delete(String etiq) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from etiquetasitens where id = ?', [etiq]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from etiquetasitens');
  }
}
 
class SQLALTERACAOITENSDAO {

  Future<Database?> get db => DatabaseHelper.getInstance().db;

  Future<int> save(ALTERACAOITENSDAO meuItem) async {
    var dbClient = await db;
    var id = await dbClient!.insert("alteracaopreco", meuItem.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('salvou id: $id');
    return id;
  }

  Future<List<ALTERACAOITENSDAO>> findAll() async {
    final dbClient = await db;

    final list = await dbClient!.rawQuery('select * from alteracaopreco');

    final itemalteradoCadastrado = list.map<ALTERACAOITENSDAO>((json) => ALTERACAOITENSDAO.fromJson(json)).toList();

    return itemalteradoCadastrado;
  }

  Future<ALTERACAOITENSDAO> findById(int id) async {
    var dbClient = await db;
    final list = await dbClient!.rawQuery('select * from alteracaopreco where id = ?', [id]);

    if (list.length > 0) {
      return new ALTERACAOITENSDAO.fromJson(list.first);
    }

    return ALTERACAOITENSDAO.fromJson(list.first);
  }

  Future<bool> exists(ALTERACAOITENSDAO meuItem) async {
    ALTERACAOITENSDAO alt = await findById(meuItem.id as int);
    var exists = alt != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from alteracaopreco');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(String itens) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from alteracaopreco where id = ?', [itens]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from alteracaopreco');
  }
}

class SQLENTRADAITENSDAO {

  Future<Database?> get db => DatabaseHelper.getInstance().db;

  Future<int> save(ENTRADAITENSDAO itenEntrada) async {
    var dbClient = await db;
    var id = await dbClient!.insert("entradaitens", itenEntrada.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('salvou id: $id');
    return id;
  }

  Future<List<ENTRADAITENSDAO>> findAll() async {
    final dbClient = await db;

    final list = await dbClient!.rawQuery('select * from entradaitens');

    final itemdeEntradaCadastrado = list.map<ENTRADAITENSDAO>((json) => ENTRADAITENSDAO.fromJson(json)).toList();

    return itemdeEntradaCadastrado;
  }

  Future<ENTRADAITENSDAO> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient!.rawQuery('select * from entradaitens where id = ?', [id]);

    if (list.length > 0) {
      return new ENTRADAITENSDAO.fromJson(list.first);
    }

    return ENTRADAITENSDAO.fromJson(list.first);
  }

  Future<ENTRADAITENSDAO> findByTokenAndEscodigo(String token, int escodigo) async {
    var dbClient = await db;
    final list =
        await dbClient!.rawQuery('select * from entradaitens where tokenmobile = ? and escodigo = ?', [token,escodigo]);

    if (list.length > 0) {
      return new ENTRADAITENSDAO.fromJson(list.first);
    }

    return ENTRADAITENSDAO.fromJson(list.first);
  } 
  
  Future<bool> exists(ENTRADAITENSDAO meuItem) async {
    ENTRADAITENSDAO entr = await findById(meuItem.id as int);
    var exists = entr != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from entradaitens');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int itens) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from entradaitens where id = ?', [itens]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from entradaitens');
  }
}

class SQLPERDASITENSDAO {

  Future<Database?> get db => DatabaseHelper.getInstance().db;

  Future<int> save(PERDASITENSDAO itemdaPerda) async {
    var dbClient = await db;
    var id = await dbClient!.insert("perdasitens", itemdaPerda.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('salvou id: $id');
    return id;
  }

  Future<List<PERDASITENSDAO>> findAll() async {
    final dbClient = await db;

    final list = await dbClient!.rawQuery('select * from perdasitens');

    final itemdeEntradaCadastrado = list.map<PERDASITENSDAO>((json) => PERDASITENSDAO.fromJson(json)).toList();

    return itemdeEntradaCadastrado;
  }

  Future<PERDASITENSDAO> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient!.rawQuery('select * from perdasitens where id = ?', [id]);

    if (list.length > 0) {
      return new PERDASITENSDAO.fromJson(list.first);
    }

    return PERDASITENSDAO.fromJson(list.first);
  }

Future<int?> max() async{
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select max(id) from perdasitens');
    return Sqflite.firstIntValue(list);   
  }

  Future<bool> exists(PERDASITENSDAO minhaPerda) async {
    PERDASITENSDAO perd = await findById(minhaPerda.id as int);
    var exists = perd != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from perdasitens');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(String itens) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from perdasitens where id = ?', [itens]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from perdasitens');
  }
}

class SQLPERDASDAO {

  Future<Database?> get db => DatabaseHelper.getInstance().db;

  Future<int> save(PERDASDAO itemdaPerda) async {
    var dbClient = await db;
    var id = await dbClient!.insert("perdas", itemdaPerda.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('salvou id: $id');
    return id;
  }

  Future<List<PERDASDAO>> findAll() async {
    final dbClient = await db;

    final list = await dbClient!.rawQuery('select * from perdas');

    final itemdeEntradaCadastrado = list.map<PERDASDAO>((json) => PERDASDAO.fromJson(json)).toList();

    return itemdeEntradaCadastrado;
  }

  Future<int?> max() async{
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select max(id) from perdas');
    return Sqflite.firstIntValue(list);   
  }

  Future<PERDASDAO> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient!.rawQuery('select * from perdas where id = ?', [id]);

    if (list.length > 0) {
      return new PERDASDAO.fromJson(list.first);
    }

    return PERDASDAO.fromJson(list.first);
  }

  Future<bool> exists(PERDASDAO minhaPerda) async {
    PERDASDAO perd = await findById(minhaPerda.id as int);
    var exists = perd != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from perdas');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(String itens) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from perdas where id = ?', [itens]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from perdas');
  }
}

class SQLLOTESUGESTAODAO {

  Future<Database?> get db => DatabaseHelper.getInstance().db;

  Future<int> save(LOTESUGESTAODAO lote) async {
    var dbClient = await db;
    var id = await dbClient!.insert("alteracaoprecolote", lote.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('salvou id: $id');
    return id;
  }

  Future<List<LOTESUGESTAODAO>> findAll() async {
    final dbClient = await db;

    final list = await dbClient!.rawQuery('select * from alteracaoprecolote');

    final loteCadastrado = list.map<LOTESUGESTAODAO>((json) => LOTESUGESTAODAO.fromJson(json)).toList();

    return loteCadastrado;
  }

  Future<int?> max() async{
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select max(id) from alteracaoprecolote');
    return Sqflite.firstIntValue(list);   
  }


  Future<LOTESUGESTAODAO> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient!.rawQuery('select * from alteracaoprecolote where id = ?', [id]);

    if (list.length > 0) {
      return new LOTESUGESTAODAO.fromJson(list.first);
    }

    return LOTESUGESTAODAO.fromJson(list.first);
  }

  Future<bool> exists(LOTESUGESTAODAO minhaloteSugestao) async {
    LOTESUGESTAODAO lot = await findById(minhaloteSugestao.id as int );
    var exists = lot != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from alteracaoprecolote');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(String idlote) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from alteracaoprecolote where id = ?', [idlote]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from alteracaoprecolote');
  }
}

class SQLBALANCOODAO {

  Future<Database?> get db => DatabaseHelper.getInstance().db;

  Future<int> save(BALANCODAO balanco) async {
    var dbClient = await db;
    var id = await dbClient!.insert("balanco", balanco.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('salvou id: $id');
    return id;
  }

  Future<List<BALANCODAO>> findAll() async {
    final dbClient = await db;

    final list = await dbClient!.rawQuery('select * from balanco');

    final balancoCadastrado = list.map<BALANCODAO>((json) => BALANCODAO.fromJson(json)).toList();

    return balancoCadastrado;
  }

  Future<BALANCODAO> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient!.rawQuery('select * from balanco where id = ?', [id]);

    if (list.length > 0) {
      return new BALANCODAO.fromJson(list.first);
    }

    return BALANCODAO.fromJson(list.first);
  }

  Future<bool> exists(BALANCODAO meuBalanco) async {
    BALANCODAO lot = await findById(meuBalanco.id as int);
    var exists = lot != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient!.rawQuery('select count(*) from balanco');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int idBalanco) async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from balanco where id = ?', [idBalanco]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.rawDelete('delete from balanco');
  }
}

