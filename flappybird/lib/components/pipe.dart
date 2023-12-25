import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappybird/game/assets.dart';
import 'package:flappybird/game/configuration.dart';
import 'package:flappybird/game/flappy_bird_game.dart';
import 'package:flappybird/game/pipe_position.dart';

class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame>{
  Pipe(
    {
      required this.pipePosition,
      required this.height,
    }
  );

  // ignore: empty_constructor_bodies
  @override
  final double height;
  final PipePosition pipePosition;
  @override
  Future<void> onLoad() async{
    final pipe = await Flame.images.load(Assets.pipe);
    final pipeRotated = await Flame.images.load(Assets.pipeRotated);
    size = Vector2(50, height);

    switch (pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(pipeRotated);
        break;
      case PipePosition.bottom:
        position.y = gameRef.size.y - size.y - config.groundHeight;
        sprite = Sprite(pipe);
      default:
    }

    add(RectangleHitbox());
  }
}