import 'package:flutter/material.dart';
import 'package:flutter_tape_measure/TapeMeasurePaint.dart';

class TapeMeasureWidget extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final double step;
  final String unit;
  final void Function(double value) onChanged;
  const TapeMeasureWidget(
      {super.key,
      required this.value,
      required this.min,
      required this.max,
      required this.step,
      required this.unit,
      required this.onChanged});

  @override
  State<TapeMeasureWidget> createState() => _TapeMeasureWidgetState();
}

class _TapeMeasureWidgetState extends State<TapeMeasureWidget> {
  double value = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          value = value - details.delta.dx;
          if (value < widget.min) {
            value = widget.min;
          }
          if (value > widget.max) {
            value = widget.max;
          }
          widget.onChanged(value);
        });
      },
      child: CustomPaint(
        //1
        painter: TapeMeasurePaint(
            value, widget.min, widget.max, widget.step, widget.unit),
        child: Container(),
      ),
    );
  }
}
