import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'card_back.dart';
import 'package:faucomplus/utils/card_front.dart';


class CredicardWidget extends StatelessWidget{

  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  
  final FocusNode numberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();

@override
Widget build(BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        FlipCard(
          key: cardKey,
          direction : FlipDirection.HORIZONTAL,
          flipOnTouch: false,
          speed: 700,
          front: CardFront(
            numberFocus: numberFocus,
            dateFocus: dateFocus,
            nameFocus: nameFocus,
            finished: (){
             cardKey.currentState!.toggleCard(); 
             cvvFocus.requestFocus();
            },

          ),

          back: CardBack(
            cvvFocus: cvvFocus,
          ),

      ),
      FlatButton(
        onPressed: (){
          cardKey.currentState!.toggleCard();
        }, 
        child: const Text('Mais Informações')
      ),

      ],


    ),
  );
}

}
