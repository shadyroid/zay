import 'package:flutter/material.dart';

/// Light clothing-outline watermark used behind the success content.
class OrderSuccessPatternBackground extends StatelessWidget {
  const OrderSuccessPatternBackground({super.key});

  static const _patternColor = Color(0xFFF0F0F0);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: _ClothingPatternPainter(),
      ),
    );
  }
}

class _ClothingPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const stepX = 88.0;
    const stepY = 96.0;

    for (var row = -1; row < size.height / stepY + 2; row++) {
      for (var col = -1; col < size.width / stepX + 2; col++) {
        final offset = Offset(
          col * stepX + (row.isOdd ? stepX * 0.45 : 0),
          row * stepY,
        );
        final index = (row + col).abs() % 4;
        _drawGarment(canvas, offset, index);
      }
    }
  }

  void _drawGarment(Canvas canvas, Offset origin, int type) {
    final paint = Paint()
      ..color = OrderSuccessPatternBackground._patternColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    switch (type) {
      case 0:
        _drawTShirt(canvas, origin, paint);
      case 1:
        _drawPants(canvas, origin, paint);
      case 2:
        _drawPolo(canvas, origin, paint);
      default:
        _drawLongSleeve(canvas, origin, paint);
    }
  }

  void _drawTShirt(Canvas canvas, Offset o, Paint paint) {
    final path = Path()
      ..moveTo(o.dx + 18, o.dy + 8)
      ..lineTo(o.dx + 28, o.dy + 18)
      ..lineTo(o.dx + 52, o.dy + 18)
      ..lineTo(o.dx + 62, o.dy + 8)
      ..lineTo(o.dx + 62, o.dy + 52)
      ..lineTo(o.dx + 18, o.dy + 52)
      ..close()
      ..moveTo(o.dx + 18, o.dy + 18)
      ..lineTo(o.dx + 8, o.dy + 28)
      ..lineTo(o.dx + 8, o.dy + 42)
      ..lineTo(o.dx + 18, o.dy + 42)
      ..moveTo(o.dx + 62, o.dy + 18)
      ..lineTo(o.dx + 72, o.dy + 28)
      ..lineTo(o.dx + 72, o.dy + 42)
      ..lineTo(o.dx + 62, o.dy + 42);
    canvas.drawPath(path, paint);
  }

  void _drawPants(Canvas canvas, Offset o, Paint paint) {
    final path = Path()
      ..moveTo(o.dx + 22, o.dy + 10)
      ..lineTo(o.dx + 58, o.dy + 10)
      ..lineTo(o.dx + 54, o.dy + 28)
      ..lineTo(o.dx + 48, o.dy + 58)
      ..lineTo(o.dx + 38, o.dy + 58)
      ..lineTo(o.dx + 40, o.dy + 30)
      ..lineTo(o.dx + 32, o.dy + 58)
      ..lineTo(o.dx + 22, o.dy + 58)
      ..lineTo(o.dx + 26, o.dy + 28)
      ..close();
    canvas.drawPath(path, paint);
  }

  void _drawPolo(Canvas canvas, Offset o, Paint paint) {
    final path = Path()
      ..moveTo(o.dx + 20, o.dy + 12)
      ..lineTo(o.dx + 40, o.dy + 12)
      ..lineTo(o.dx + 40, o.dy + 20)
      ..lineTo(o.dx + 60, o.dy + 20)
      ..lineTo(o.dx + 60, o.dy + 54)
      ..lineTo(o.dx + 20, o.dy + 54)
      ..close()
      ..moveTo(o.dx + 20, o.dy + 20)
      ..lineTo(o.dx + 12, o.dy + 30)
      ..lineTo(o.dx + 12, o.dy + 40)
      ..lineTo(o.dx + 20, o.dy + 40);
    canvas.drawPath(path, paint);
  }

  void _drawLongSleeve(Canvas canvas, Offset o, Paint paint) {
    final path = Path()
      ..moveTo(o.dx + 24, o.dy + 10)
      ..lineTo(o.dx + 56, o.dy + 10)
      ..lineTo(o.dx + 56, o.dy + 56)
      ..lineTo(o.dx + 24, o.dy + 56)
      ..close()
      ..moveTo(o.dx + 24, o.dy + 18)
      ..lineTo(o.dx + 10, o.dy + 30)
      ..lineTo(o.dx + 10, o.dy + 48)
      ..lineTo(o.dx + 24, o.dy + 48)
      ..moveTo(o.dx + 56, o.dy + 18)
      ..lineTo(o.dx + 70, o.dy + 30)
      ..lineTo(o.dx + 70, o.dy + 48)
      ..lineTo(o.dx + 56, o.dy + 48);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
