import 'package:flutter/material.dart';
import 'package:faucomplus/utils/contantes.dart';
import 'card_text_field.dart';

class CardBack extends StatelessWidget {

  const CardBack({required this.cvvFocus});

  final FocusNode cvvFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Color(0xFF3a8e74),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(16) ),
        elevation: 16,
        child: Container(
          padding: const EdgeInsets.all(20),
           child: Column(
             children: <Widget>[
              CardTextField(
                      title: 'PREÇO PROMOCIONAL',
                      hint: varG_vlr_promocao.toString(),
                      bold: true,
                   ),
                    SizedBox(height: 2,),

                    CardTextField(
                      title: 'ULT ALTERAÇÃO',
                      hint: varG_dt_ultima_alteracao,
                      bold: true,
                   ),      
                   SizedBox(height: 2,),
                    
                  CardTextField(
                      title: 'DATA CADASTRO',
                      hint: varG_dt_cadastro,
                      bold: true,
                   ),
                    SizedBox(height: 2,),
                      
                    CardTextField(
                      title: 'VALIDADE PRÓXIMA',
                      hint: varG_validade_proxima,
                      bold: true,
                   ),
                   
                    SizedBox(height: 2,),
                    CardTextField(
                      title: 'COD BARRA',
                      hint: varG_codigo_barra,
                      bold: true,
                   ),


             ],
           ),
           
         ),
      ),
    );
  }
}