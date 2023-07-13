import 'package:flutter/material.dart';

//2
class TapeMeasurePaint extends CustomPainter {
  double value;
  double min;
  double max;
  double step;
  String unit;
  TapeMeasurePaint(
    this.value,
    this.min,
    this.max,
    this.step,
    this.unit,
  );
  Paint bgfill = Paint()
    ..color = const Color.fromARGB(255, 0, 255, 21)
    ..style = PaintingStyle.fill;
  final Paint fgBorder = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;
  final Paint indicatorBorder = Paint()
    ..color = const Color.fromARGB(255, 235, 4, 4)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.7;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final bgRect = Offset.zero & size;
    canvas.drawRect(bgRect, bgfill);
    canvas.drawRect(bgRect, fgBorder);
    final innerRect = bgRect.deflate(5);
    canvas.drawRect(innerRect, fgBorder);
    canvas.clipRect(innerRect);
    drawMarkers(canvas, innerRect);
    drawValue(canvas, innerRect);
    drawIndicator(canvas, innerRect);
  }

  void drawMarkers(Canvas canvas, Rect innerRect) {
    double range = max - min;
    double stepSize = 5;
    double heightSmall = 10.0;
    double heightMedium = 15.0;
    double heightLarge = 20.0;
    double offsetToIndicator = innerRect.width / 2.0 - (value - min) * stepSize;

    for (double i = min; i <= max; i += step) {
      double x = innerRect.left + (i - min) * stepSize + offsetToIndicator;
      if (i % 10 == 0) {
        double yL = innerRect.top + heightLarge;
        canvas.drawLine(Offset(x, innerRect.top), Offset(x, yL), fgBorder);
        TextSpan span = TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: 10.0,
          ),
          text: '${i.toInt()}',
        );
        TextPainter tp = TextPainter(
            text: span,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr);
        tp.layout();
        tp.paint(canvas, Offset(x - tp.width / 2, yL + 5));
      } else if (i % 5 == 0) {
        canvas.drawLine(Offset(x, innerRect.top),
            Offset(x, innerRect.top + heightMedium), fgBorder);
      } else {
        canvas.drawLine(Offset(x, innerRect.top),
            Offset(x, innerRect.top + heightSmall), fgBorder);
      }
    }
  }

  void drawValue(Canvas canvas, Rect innerRect) {
    final c = innerRect.bottomCenter;
    TextSpan span = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 10.0,
      ),
      text: '${value.toStringAsFixed(1)}$unit',
    );
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(c.dx - tp.width / 2, c.dy - tp.height));
  }

  void drawIndicator(Canvas canvas, Rect innerRect) {
    final c1 = innerRect.topCenter + Offset(0, innerRect.height / 4);
    final c2 = innerRect.bottomCenter + Offset(0, innerRect.height / 4);
    canvas.drawLine(c1, c2, indicatorBorder);
  }
}
