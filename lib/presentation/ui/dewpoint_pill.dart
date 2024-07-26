import 'package:flutter/material.dart';

class DewpointPillWidget extends StatefulWidget {
  final double humidity;

  const DewpointPillWidget({super.key, required double? humidity})
      : humidity = humidity ?? 0.0;
  @override
  State<DewpointPillWidget> createState() => _DewpointPillWidgetState();
}

class _DewpointPillWidgetState extends State<DewpointPillWidget> {
  @override
  Widget build(BuildContext context) {
    final clampedProgress = (widget.humidity / 100).clamp(0.0, 1.0);

    return Container(
      height: 48,
      width: 24,
      decoration: BoxDecoration(
        color: Color.fromRGBO(253,226, 147, 1),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomLeft,
              child: FractionallySizedBox(
                heightFactor: clampedProgress,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(252,202, 51, 1),
                      borderRadius: clampedProgress >= 100
                          ? BorderRadius.all(Radius.circular(16))
                          : BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                ),
              ))
        ],
      ),
    );
  }
}
