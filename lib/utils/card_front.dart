import 'package:flutter/material.dart';
import 'card_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'contantes.dart';

class CardFront extends StatelessWidget {
  CardFront({required this.dateFocus, required this.nameFocus, required this.numberFocus, required this.finished});

  final dateFormatter = MaskTextInputFormatter(
    mask: '!#/@-&#',
    filter: {'#': RegExp('[0-9]'), '!' : RegExp('[0-1]'), '@' : RegExp('[2]'), '-' : RegExp('[0]'), '&' : RegExp('[2-3-4]')}
  );

  final VoidCallback finished;

  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Color(0xFF3a8e74),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15) ),
        elevation: 16,
        child: Container(
          padding: const EdgeInsets.all(20),
           child: Row(
             children: <Widget>[
               
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    CardTextField(
                      title: 'ESTOQUE ATUAL',
                      hint: varG_qtd_estoque_atual.toString(),
                      bold: true,
                      focusNode: numberFocus,

                   ),
                    SizedBox(height: 2,),

                    CardTextField(
                      title: 'MARCA',
                      hint: varG_marca,
                      bold: true,
                      focusNode: numberFocus,
                   ),
                    SizedBox(height: 2,),

                   CardTextField(
                      title: 'DEPARTAMENTO',
                      hint: varG_departamento,
                      bold: true,
                      focusNode: numberFocus,

                   ),
                    SizedBox(height: 2,),

                  CardTextField(
                      title: 'CATEGORIA',
                      hint: varG_categoria,
                      bold: true,
                      focusNode: numberFocus,
                   ),
                    SizedBox(height: 2,),

                  CardTextField(
                      title: 'SUBCATEGORIA',
                      hint: varG_subcategoria,
                      bold: true,
                      focusNode: numberFocus,
                   ), 
                    SizedBox(height: 2,),

                  ],
                ),
                
              ),
             ],
           ),
           
         ),
      ),
    );
  }
}