import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:sprite_07/utils/create_animation_by_limit.dart';

class PlayerSpriteSheetComponentAnimationFull extends SpriteAnimationComponent
    with HasGameReference, KeyboardHandler, TapCallbacks {
  // Menambahkan TapDetector

  late double screenWidth;
  late double screenHeight;

  late double centerX;
  late double centerY;

  final double spriteSheetWidth = 680;
  final double spriteSheetHeight = 472;

  late SpriteAnimation deadAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation walkAnimation;

  bool isMovingLeft = false;
  bool isMovingRight = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final spriteImage = await Flame.images.load('dinofull.png');
    final spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: Vector2(spriteSheetWidth, spriteSheetHeight),
    );

    screenWidth = game.size.x;
    screenHeight = game.size.y;

    size = Vector2(spriteSheetWidth, spriteSheetHeight);

    centerX = (screenWidth / 2) - (spriteSheetWidth / 2);
    centerY = (screenHeight / 2) - (spriteSheetHeight / 2);

    position = Vector2(centerX, centerY);

    deadAnimation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 0,
      step: 8,
      sizeX: 5,
      stepTime: .08,
    );
    idleAnimation = spriteSheet.createAnimationByLimit(
      xInit: 1,
      yInit: 2,
      step: 10,
      sizeX: 5,
      stepTime: .08,
    );
    jumpAnimation = spriteSheet.createAnimationByLimit(
      xInit: 3,
      yInit: 0,
      step: 12,
      sizeX: 5,
      stepTime: .08,
    );
    runAnimation = spriteSheet.createAnimationByLimit(
      xInit: 5,
      yInit: 0,
      step: 8,
      sizeX: 5,
      stepTime: .08,
    );
    walkAnimation = spriteSheet.createAnimationByLimit(
      xInit: 6,
      yInit: 2,
      step: 10,
      sizeX: 5,
      stepTime: .08,
    );

    animation = idleAnimation; 
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isMovingLeft) {
      scale.x = -1;
      animation = runAnimation;
      position.x -= 100 * dt; 
    } else if (isMovingRight) {
      scale.x = 1;
      animation = runAnimation;
      position.x += 100 * dt; 
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      isMovingLeft = true;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      isMovingRight = true;
    } else {
      isMovingLeft = false;
      isMovingRight = false;
    }
    return false;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    if (animation == idleAnimation) {
      animation = runAnimation;
    } else if (animation == runAnimation) {
      animation = deadAnimation;
    } else if (animation == deadAnimation) {
      animation = idleAnimation;
    } else {
      animation = idleAnimation;
    }
  }
}