import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();
  DatabaseHelper.getInstance();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();

    return _db;
  }

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'faucomplusdev2.db');
   
    var db = await openDatabase(path, version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    
    await db.execute('CREATE TABLE tokenphone(id INTEGER PRIMARY KEY, token TEXT)');
        
        db.execute('CREATE TABLE etiquetasitens(id INTEGER PRIMARY KEY, codigoid INTEGER, quantidade INTEGER' 
        ', escodigo INTEGER, precovenda FLOAT)');

        db.execute('CREATE TABLE alteracaopreco(id INTEGER PRIMARY KEY, codigoid INTEGER, precovenda FLOAT' 
        ', promocao FLOAT)');

        db.execute('CREATE TABLE entradaitens(id INTEGER PRIMARY KEY, tokenmobile TEXT, escodigo INTEGER' 
        ', codigoean TEXT, quantidade FLOAT, quantidadepecas INTEGER)');       

        db.execute('CREATE TABLE perdasitens(id INTEGER PRIMARY KEY, codigoempresa INTEGER, motivo TEXT, codigousuario INTEGER' 
        ', codigoid INTEGER, escodigo INTEGER, quantidade FLOAT, quantidadedeposito FLOAT, lote INTEGER, serie INTEGER)');   

        db.execute('CREATE TABLE perdas(id INTEGER PRIMARY KEY, codigoid INTEGER, codigoempresa INTEGER'
        ', codigomotivo INTEGER, obs TEXT, codigousuario INTEGER, codcaixa INTEGER, datasolitacao TEXT)'); 

        db.execute('CREATE TABLE config(id INTEGER PRIMARY KEY, tipoconexao TEXT, ipservidor TEXT, portaservidor TEXT, codigoidloja INTEGER)'); 

        db.execute('CREATE TABLE alteracaoprecolote(id INTEGER PRIMARY KEY, codigoid INTEGER, codigomotivo INTEGER, codigoempresa INTEGER'
        ', obs TEXT, codigousuario INTEGER, codcaixa INTEGER, datasolitacao TEXT)'); 

        db.execute('CREATE TABLE balanco(id INTEGER PRIMARY KEY, codigobalanco INTEGER, codigoempresa INTEGER, codcaixa INTEGER, escodigo INTEGER, quantidade FLOAT'
        ', quantidadedeposito FLOAT, datasolicitacao TEXT, codigousuario INTEGER)'); 

  }

  Future<FutureOr<void>> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("_onUpgrade: oldVersion: $oldVersion > newVersion: $newVersion");

      await db.execute("DROP TABLE IF EXIST tokenphone ");
      await db.execute("DROP TABLE IF EXIST etiquetasitens ");
      await db.execute("DROP TABLE IF EXIST alteracaopreco ");
      await db.execute("DROP TABLE IF EXIST entradaitens ");
      await db.execute("DROP TABLE IF EXIST perdasitens ");
      await db.execute("DROP TABLE IF EXIST perdas ");
      await db.execute("DROP TABLE IF EXIST config ");
      await db.execute("DROP TABLE IF EXIST alteracaoprecolote ");
      await db.execute("DROP TABLE IF EXIST balanco ");
  }

  Future close() async {
    var dbClient = await db;
    return dbClient!.close();
  }
}
