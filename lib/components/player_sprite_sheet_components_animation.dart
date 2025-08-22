import 'package:flame/sprite.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:sprite_07/utils/create_animation_by_limit.dart';

class PlayerSpriteSheetComponentsAnimation extends SpriteAnimationComponent with HasGameReference {
  late double screenWidth;
  late double screenHeight;

  late double centerX;
  late double centerY;

  final double spriteSheetWiidth = 680;
  final  double spriteSheetHeight = 472;

  late SpriteAnimation dinoAnimation;
  
  @override
  void onLoad() async{
    super.onLoad();

    screenWidth = game.size.x;
    screenHeight = game.size.y;

    centerX = (screenWidth/2)-(spriteSheetWiidth/2);
    centerY = (screenHeight/2)-(spriteSheetHeight/2);

    var spriteImages = await Flame.images.load('dino.png');

    final spriteSheet = SpriteSheet(
      image: spriteImages, 
      srcSize: Vector2(spriteSheetWiidth, spriteSheetHeight));

    position = Vector2(centerX,centerY);
    size = Vector2(spriteSheetWiidth, spriteSheetHeight);

    dinoAnimation = spriteSheet.createAnimationByLimit(xInit: 0, yInit: 0, step: 10, sizeX: 2, stepTime: .08);

    animation = dinoAnimation;
  }
}