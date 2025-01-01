import 'package:flutter/material.dart';

class GradientSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final List<Color> gradientColors;
  final ValueChanged<double>? onChanged;
  final Color overlayColor;
  final Color inactiveTrackColor;
  final Color thumbColor;
  final double? trackHeight;

  const GradientSlider({
    super.key,
    required this.value,
    this.min = 0.0,
    this.max = 1.0,
    required this.gradientColors,
    this.onChanged,
    required this.overlayColor,
    this.inactiveTrackColor  = Colors.grey,
    this.trackHeight = 4.0,
    this.thumbColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbColor: thumbColor,
        overlayColor: overlayColor,
        inactiveTrackColor: inactiveTrackColor,
        trackHeight: trackHeight,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 18, disabledThumbRadius: 18),
        trackShape: GradientSliderTrackShape(
          gradientColors: gradientColors,
        ),
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        onChanged: onChanged,
      ),
    );
  }
}

 class GradientSliderTrackShape extends SliderTrackShape {
  final List<Color> gradientColors;

  const GradientSliderTrackShape( {
    required this.gradientColors,
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required Offset thumbCenter,
        bool isEnabled = false,
        bool isDiscrete = false,
        Offset? secondaryOffset,
      }) {
    if (!isEnabled) {
      return;
    }

    final canvas = context.canvas;
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Paint unselected track
    final unselectedPaint = Paint()
      ..color = sliderTheme.inactiveTrackColor!
      ..style = PaintingStyle.fill;

    final unselectedRRect = RRect.fromRectAndRadius(
      trackRect,
      Radius.circular(trackRect.height / 2),
    );
    canvas.drawRRect(unselectedRRect, unselectedPaint);

    // Paint selected track with gradient
    final selectedRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        colors: gradientColors,
      ).createShader(selectedRect)
      ..style = PaintingStyle.fill;

    final selectedRRect = RRect.fromRectAndRadius(
      selectedRect,
      Radius.circular(trackRect.height / 2),
    );
    canvas.drawRRect(selectedRRect, gradientPaint);
  }
}