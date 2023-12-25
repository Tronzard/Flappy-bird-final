import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappybird/game/assets.dart';
import 'package:flappybird/game/bird_movement.dart';
import 'package:flappybird/game/configuration.dart';
import 'package:flappybird/game/flappy_bird_game.dart';
import 'package:flutter/widgets.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();

  int score = 0;

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.dark);
    final birdUpFlap = await gameRef.loadSprite(Assets.darkUp);
    final birdDownFlap = await gameRef.loadSprite(Assets.darkDown);

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.middle;
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };

    add(CircleHitbox());
  }

  void fly() {
    add(MoveByEffect(Vector2(0.0, config.gravity), EffectController(duration: 0.2, curve: Curves.decelerate),
    onComplete: () => current = BirdMovement.down,));
    current = BirdMovement.up;
    FlameAudio.play(Assets.flying);
  }

  @override
  void onCollisionStart( Set<Vector2> intersectionPoints, PositionComponent other,){
  super.onCollisionStart(intersectionPoints, other);
  gameOver();
 }

 void reset(){
  position = Vector2(50, gameRef.size.y /2 - size.y/2);
  score = 0;
 }

 void gameOver() {
    FlameAudio.play(Assets.collision);
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
    game.isHit = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += config.birdVelocity * dt;
  }
  
 
}
