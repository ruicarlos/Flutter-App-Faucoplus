import 'package:faucomplus/Views/leitor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:faucomplus/Views/Principal.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:date_format/date_format.dart';


String precoVisual = '';
String productImg =
    'https://cestapp.angraz.com.br/1/0' + varG_codigo_barra + '.jpg';
String nEtiquetasStr='';
int qtdint = 0;
double prodTotal = 0;
String prodTotalS = '';
bool promoativa = false;
DateTime? _selectedDate;

class SugestaodePreco extends StatefulWidget {
  SugestaodePreco({Key? key}) : super(key: key);

  @override
  _SugestaodePrecoState createState() => _SugestaodePrecoState();
}

class _SugestaodePrecoState extends State<SugestaodePreco> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    if (varGSugPreBTPromoAtivo == true) {
      precoSugerido_Str ='';
      promoativa = varGSugPreBTPromoAtivo;

      Fluttertoast.showToast(
          msg: 'Promoção Ativa',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.orangeAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      promoativa = varGSugPreBTPromoAtivo;
      dt_fimPromocao = DateTime.now();
      dt_inicioPromocao = DateTime.now().add(Duration(days: 365));
    }
  }

    Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text('Adicionar outro Produto?'),
        actions: <Widget>[
          TextButton(
            onPressed:(){
              Navigator.pushReplacementNamed(context, 'Principal');
            },
            child: Text('Sair', style: TextStyle(color:Color(0xFF3a8e74), fontSize: 20)),
          ),
          TextButton(
            onPressed: (){
              origemClique = 'sugestaopreco';
              if (modo == 'scan') {
                LercodigodeBarras().escanearCodigodeBarras(context);
              } else {
                 Navigator.pushReplacementNamed(context, 'PesquisaDigi');
              }
            },
            child: Text('Sim', style: TextStyle(color:Color(0xFF3a8e74), fontSize: 20)),
          ),
        ],
      ),
    )) ?? false;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: new Icon(Icons.edit),
          title: new Text('SUGESTÃO DE PREÇO',
              style: TextStyle(fontSize: 15, color: Colors.white)),
          backgroundColor: corDegradeeFim,
        ),
        body: corpo(),
      ),
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
                          side: BorderSide(color: Colors.redAccent)),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('PREÇO ATUAL R\$ : ' + precoVisual,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                varG_nome,
                style: TextStyle(
                  fontSize: 18,
                  color: corDegradeeFim,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: Colors.white,
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Informe um Preço', style: kLabelStyle),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: corDegradeeFim,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  height: 50.0,
                  child: TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Titanone',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(Icons.price_change,
                            size: 25, color: Colors.white),
                        hintText: 'Informe um Valor',
                        hintStyle: kHintTextStyle,
                      ),
                      onChanged: (valor) async {
                        setState(() {
                          precoSugerido_Str = valor;
                          precoSugerido = double.parse(precoSugerido_Str!);
                        });
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: () async {
                if (precoSugerido_Str ==''){
                  Fluttertoast.showToast(
                      msg:
                          'Informe um Valor',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.red[700],
                      textColor: Colors.white,
                      fontSize: 16.0);
                }else{
                  envioSugestPende ='S';
                  if (promoativa) {
                  print('Inicio: ' +
                      formatDate(dt_inicioPromocao!, [dd, '/', mm, '/', yyyy]) +
                      ' Fim: ' +
                      formatDate(dt_fimPromocao!, [dd, '/', mm, '/', yyyy]));

                  varGSugDtInicioPromo =
                      formatDate(dt_inicioPromocao!, [dd, '/', mm, '/', yyyy]);
                  varGSugDtFimPromo =
                      formatDate(dt_fimPromocao!, [dd, '/', mm, '/', yyyy]);

                  Fluttertoast.showToast(
                      msg:
                          'Sugestão Enviada',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.orangeAccent[700],
                      textColor: Colors.white,
                      fontSize: 16.0);
                  enviarSugestaoPrecoComPromocao();
                } else {
                  Fluttertoast.showToast(
                      msg:
                          'Sugestão enviada!',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      backgroundColor: Colors.orangeAccent[700],
                      textColor: Colors.white,
                      fontSize: 16.0);
                  enviarSugestaoPreco();
                }

                }

              },
              icon: Icon(Icons.send),
              label: Text('  ENVIAR SUGESTÃO  '),
            ),
          ),
          SizedBox(height: 25),
          Divider(
            height: 1,
          ),
          SwitchListTile(
              title: Text(
                'ATIVAR PROMOÇÃO?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: corDegradeeFim,
                ),
                textAlign: TextAlign.center,
              ),
              activeColor: corDegradeeFim,
              value: promoativa,
              onChanged: (bool value) {
                setState(() {
                  promoativa = value;
                  varGSugPreBTPromoAtivo = promoativa;
                });
              }),
          Divider(
            height: 5,
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child:
                Center(child: Text('Inicio da Promoção', style: kLabelStyle)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: DatePickerWidget(
              initialDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
              firstDate: DateTime.now(),
              dateFormat: "dd-MM-yyyy",
              locale: DatePicker.localeFromString("pt"),
              onChange: (DateTime newDate, _) {
                dt_inicioPromocao = newDate;
              },
              pickerTheme: DateTimePickerTheme(
                dividerColor: Color(0xFF3a8e74),
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Center(child: Text('Fim da Promoção', style: kLabelStyle)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: DatePickerWidget(
              initialDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
              firstDate: DateTime.now().add(Duration(days: 1)),
              dateFormat: "dd-MM-yyyy",
              locale: DatePicker.localeFromString("pt"),
              onChange: (DateTime newDate, _) {
                dt_fimPromocao = newDate;
              },
              pickerTheme: DateTimePickerTheme(
                dividerColor: Color(0xFF3a8e74),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
