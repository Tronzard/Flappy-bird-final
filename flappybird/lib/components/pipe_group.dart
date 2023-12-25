import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappybird/components/pipe.dart';
import 'package:flappybird/game/assets.dart';
import 'package:flappybird/game/configuration.dart';
import 'package:flappybird/game/flappy_bird_game.dart';
import 'package:flappybird/game/pipe_position.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame>{
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async{
    position.x = gameRef.size.x;
    final heightMinusGround = gameRef.size.y - config.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY = spacing + _random.nextDouble() * (heightMinusGround - spacing );
    addAll(
      [
        Pipe(pipePosition: PipePosition.top, height: centerY - spacing /2),
        Pipe(pipePosition: PipePosition.bottom, height: heightMinusGround - (centerY + spacing /2)),
      ]
    );
  }

  @override
  void update(double dt){
    super.update(dt);
    position.x -= config.gameSpeed * dt;

    if (position.x < -10){
      removeFromParent();
      updateScore();
    }

    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }

  }
  
  void updateScore() {
    gameRef.bird.score +=1;
    FlameAudio.play(Assets.point);
  }
}