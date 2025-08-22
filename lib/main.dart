import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'components/player_sprite_sheet_component_animation_full.dart';
class MyGame extends FlameGame{
  @override
  void onLoad (){
    add(PlayerSpriteSheetComponentAnimationFull());
  }
  
}



@override
void main() async{
  runApp(GameWidget(game: MyGame()));
}

