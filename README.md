<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Flutter Gradient Slider

A customizable gradient slider widget for Flutter that allows you to create beautiful, interactive sliders with gradient tracks and customizable thumbs.

[![pub package](https://img.shields.io/pub/v/flutter_gradient_slider.svg)](https://pub.dev/packages/flutter_gradient_slider)

## Features

- 🎨 Customizable gradient colors for the slider track
- 🎯 Adjustable thumb design and size
- 📏 Support for continuous and discrete values
- 🔄 Bidirectional sliding support
- 🎭 Customizable active and inactive track colors
- 📱 Responsive and smooth interactions
- ⚡ High performance with minimal impact on app size

https://github.com/user-attachments/assets/9f702fd4-c998-4466-9dd9-76952a26f732



## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_gradient_slider: ^0.0.1
```

## Usage

### Gradient Slider

```
GradientSlider(
value: _currentValue,
onChanged: (double value) {
  setState(() {
    _currentValue = value;
  });
},
gradientColors: const [
  Colors.blue,
  Colors.purple,
  Colors.red,
],
)
```

### Range Selector

```
  GradientRangeSelector(
                min: 0.0,
                max: 1.0,
                values: selectedValues,
                gradientColors: const [Colors.red, Colors.blue],
                overlayColor: Colors.white,
                inactiveTrackColor: Colors.grey.withOpacity(0.8),
                trackHeight: 4,
                onChanged: (values) {
                setState(() {
                  selectedValues = values;
                });
                },
              ),
```

## Parameters

### GradientSlider

| Parameter          |          Type          |                                          Description |
| :----------------- | :--------------------: | ---------------------------------------------------: |
| value              |        `double`        |                          Current value of the slider |
| onChanged          | `ValueChanged<double>` |      Callback function when the slider value changes |
| min                |        `double`        |           Minimum value of the slider (default: 0.0) |
| max                |        `double`        |           Maximum value of the slider (default: 1.0) |
| gradientColors     |     `List<Color>`      |          List of colors to create the gradient track |
| trackHeight        |        `double`        |            Height of the slider track (default: 4.0) |
| overlayColor       |        `Color`         | Color of the overlay when interacting with the thumb |
| inactiveTrackColor |        `Color`         |           Color of the inactive portion of the track |

### GradientRangeSelector

| Parameter          |            Type             |                                          Description |
| :----------------- | :-------------------------: | ---------------------------------------------------: |
| value              |        `RangeValues`        |                 Current range values of the selector |
| onChanged          | `ValueChanged<RangeValues>` |       Callback function when the range values change |
| min                |          `double`           |            Minimum value of the range (default: 0.0) |
| max                |          `double`           |            Maximum value of the range (default: 1.0) |
| gradientColors     |        `List<Color>`        |          List of colors to create the gradient track |
| trackHeight        |          `double`           |          Height of the selector track (default: 4.0) |
| overlayColor       |           `Color`           | Color of the overlay when interacting with the thumb |
| inactiveTrackColor |           `Color`           |           Color of the inactive portion of the track |

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
