import 'package:flutter/material.dart';

class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const DottedBorderContainer({super.key, required this.child, this.borderRadius = 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
          style: BorderStyle.none, // Set to none so that only the custom paint draws the border
        ),
      ),
      child: CustomPaint(
        painter: DottedBorderPainter(),
        child: child,
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    double dashWidth = 5.0;
    double dashSpace = 5.0;

    double startX = 0.0;
    double endX = size.width;
    double startY = 0.0;
    double endY = size.height;

    // Draw top border
    while (startX < endX) {
      canvas.drawLine(Offset(startX, startY), Offset(startX + dashWidth, startY), paint);
      startX += dashWidth + dashSpace;
    }

    // Draw bottom border
    startX = 0.0;
    while (startX < endX) {
      canvas.drawLine(Offset(startX, endY), Offset(startX + dashWidth, endY), paint);
      startX += dashWidth + dashSpace;
    }

    // Draw left border
    while (startY < endY) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }

    // Draw right border
    startY = 0.0;
    while (startY < endY) {
      canvas.drawLine(Offset(endX, startY), Offset(endX, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}