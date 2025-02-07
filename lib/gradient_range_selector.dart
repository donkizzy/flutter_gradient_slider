/// A custom range slider widget with a gradient track.
///
/// The [GradientRangeSelector] widget allows users to select a range of values
/// within a specified minimum and maximum range. The track of the slider is
/// painted with a gradient, and the thumb and overlay colors can be customized.
///
/// The widget requires the following parameters:
/// - [min]: The minimum value of the range.
/// - [max]: The maximum value of the range.
/// - [values]: The current range of selected values.
/// - [gradientColors]: The colors used to create the gradient on the track.
/// - [overlayColor]: The color of the overlay when the thumb is pressed.
/// - [inactiveTrackColor]: The color of the inactive portion of the track.
/// - [trackHeight]: The height of the track (optional, defaults to 4.0).
/// - [thumbColor]: The color of the thumb (optional, defaults to black).
/// - [onChanged]: A callback function that is called when the range of values changes (optional).
///
/// Example usage:
/// ```dart
/// GradientRangeSelector(
///   min: 0.0,
///   max: 100.0,
///   values: RangeValues(20.0, 80.0),
///   gradientColors: [Colors.red, Colors.blue],
///   overlayColor: Colors.blue.withOpacity(0.2),
///   inactiveTrackColor: Colors.grey,
///   onChanged: (RangeValues newValues) {
///     // Handle value changes
///   },
/// )
/// ```
///
/// The [GradientRangeSliderTrackShape] class is a custom track shape that paints
/// the track with a gradient. It requires the [gradientColors] parameter to
/// define the colors of the gradient.
library;
import 'package:flutter/material.dart';

class GradientRangeSelector extends StatefulWidget {
  final double min;
  final double max;
  final RangeValues values;
  final List<Color> gradientColors;
  final ValueChanged<RangeValues>? onChanged;
  final Color overlayColor;
  final Color inactiveTrackColor;
  final double? trackHeight;
  final Color thumbColor;

  const GradientRangeSelector({
    super.key,
    required this.min,
    required this.max,
    required this.values,
    required this.gradientColors,
    this.onChanged,
    required this.overlayColor,
    required this.inactiveTrackColor,
    this.trackHeight = 4.0,
    this.thumbColor = Colors.black,
  });

  @override
  State<GradientRangeSelector> createState() => _GradientRangeSelectorState();
}

class _GradientRangeSelectorState extends State<GradientRangeSelector> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbColor: widget.thumbColor,
        overlayColor: widget.overlayColor,
        inactiveTrackColor: widget.inactiveTrackColor,
        trackHeight: widget.trackHeight,
        rangeThumbShape: const RoundRangeSliderThumbShape(
            enabledThumbRadius: 18, disabledThumbRadius: 18, elevation: 0.0),
        rangeTrackShape: GradientRangeSliderTrackShape(
          gradientColors: widget.gradientColors,
        ),
      ),
      child: RangeSlider(
        min: widget.min,
        max: widget.max,
        values: widget.values,
        onChanged: widget.onChanged,
      ),
    );
  }
}

class GradientRangeSliderTrackShape extends RangeSliderTrackShape {
  final List<Color> gradientColors;

  const GradientRangeSliderTrackShape({
    required this.gradientColors,
  });

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset startThumbCenter,
    required Offset endThumbCenter,
    required TextDirection textDirection,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final canvas = context.canvas;

    // Paint inactive track
    final inactivePaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    const horizontalAdjustment = 6.0;
    final trackLeft = offset.dx + horizontalAdjustment;
    final trackTop = offset.dy + (parentBox.size.height - 2.0) / 2;
    final trackRight =
        trackLeft + parentBox.size.width - 2 * horizontalAdjustment;
    final trackBottom = trackTop + 2.0;

    // Draw inactive track
    canvas.drawLine(
      Offset(trackLeft, trackTop),
      Offset(trackRight, trackTop),
      inactivePaint,
    );

    // Paint active track with gradient
    if (startThumbCenter.dx < endThumbCenter.dx) {
      final activeRect = Rect.fromPoints(
        Offset(startThumbCenter.dx, trackTop),
        Offset(endThumbCenter.dx, trackBottom),
      );

      final activeGradient = LinearGradient(
        colors: gradientColors,
      ).createShader(activeRect);

      final activePaint = Paint()
        ..shader = activeGradient
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0;

      canvas.drawLine(
        Offset(startThumbCenter.dx, trackTop),
        Offset(endThumbCenter.dx, trackTop),
        activePaint,
      );
    }
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 4.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
