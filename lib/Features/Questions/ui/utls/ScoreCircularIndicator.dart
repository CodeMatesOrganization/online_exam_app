import 'package:flutter/material.dart';
import 'package:online_exam/core/theme/app_colors.dart';

class ScoreCircularIndicator extends StatelessWidget {
  final double correctPercent;
  final double wrongPercent;

  const ScoreCircularIndicator({
    super.key,
    required this.correctPercent,
    required this.wrongPercent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 1200),
        builder: (context, value, _) {
          return CustomPaint(
            painter: ScorePainter(
              correctValue: correctPercent * value,
              wrongValue: wrongPercent * value,
            ),
            child: Center(
              child: Text(
                "${(correctPercent * 100).round()}%",
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ScorePainter extends CustomPainter {
  final double correctValue;
  final double wrongValue;

  ScorePainter({
    required this.correctValue,
    required this.wrongValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 12.0;

    final radius = (size.width / 2) - strokeWidth;
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCircle(center: center, radius: radius);

    const double smallGap = 0.4;
    const double bigGap = 0.4;

    final double totalAvailableSweep =
        (2 * 3.1415926535) - smallGap - bigGap;

    // --- Paints ---
    final correctPaint = Paint()
      ..color = AppColors.blue
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final wrongPaint = Paint()
      ..color = AppColors.red
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final gapPaint = Paint()
      ..color = Colors.transparent
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final correctSweep = correctValue * totalAvailableSweep;
    final wrongSweep = wrongValue * totalAvailableSweep;

    const startAngle = -3.1415926535 / 2;

    canvas.drawArc(
      rect,
      startAngle,
      correctSweep,
      false,
      correctPaint,
    );

    final gap1Start = startAngle + correctSweep;
    canvas.drawArc(rect, gap1Start, smallGap, false, gapPaint);

    final wrongStart = gap1Start + smallGap;
    canvas.drawArc(
      rect,
      wrongStart,
      wrongSweep,
      false,
      wrongPaint,
    );

    final gap2Start = wrongStart + wrongSweep;
    canvas.drawArc(rect, gap2Start, bigGap, false, gapPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
