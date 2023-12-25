import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flappybird/components/background.dart';
import 'package:flappybird/components/bird.dart';
import 'package:flappybird/components/ground.dart';
import 'package:flappybird/components/pipe_group.dart';
import 'package:flappybird/game/configuration.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame();
  late Bird bird;
  bool isHit = false;
  late TextBoxComponent score;
  Timer interval = Timer(config.pipeInterval, repeat:true);
  @override
  Future<void> onLoad() async{
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      score = buildScore()

    ]);
    interval.onTick =() => add(PipeGroup());
  }
  
  TextBoxComponent buildScore(){
    return TextBoxComponent(
      text: 'Score: 0',
      position: Vector2(size.x / 2 * 1.25, size.y / 2 * 0.2),
      anchor: Anchor.center,
    );
  }

  @override
  void onTap(){
    super.onTap();
    bird.fly();
  }

   @override
  void update(double dt){
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${bird.score}';
  }

}
