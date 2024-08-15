// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// void main() {
//   runApp(ColorPickerApp());
// }

// class ColorPickerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ColorPickerPage(),
//     );
//   }
// }

// class ColorPickerPage extends StatefulWidget {
//   @override
//   _ColorPickerPageState createState() => _ColorPickerPageState();
// }

// class _ColorPickerPageState extends State<ColorPickerPage> {
//   Color selectedColor = Colors.red;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Color Picker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               width: 200,
//               height: 200,
//               color: selectedColor,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _showColorPickerDialog(context);
//               },
//               child: Text('Open Color Picker'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showColorPickerDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Pick a color'),
//           content: SingleChildScrollView(
//             child: MaterialPicker(
//               pickerColor: selectedColor,
//               onColorChanged: (color) {
//                 setState(() {
//                   selectedColor = color;
//                 });
//               },
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class MaterialPicker extends StatelessWidget {
//   final Color pickerColor;
//   final ValueChanged<Color> onColorChanged;

//   MaterialPicker({required this.pickerColor, required this.onColorChanged});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialColorPicker(
//       selectedColor: pickerColor,
//       onColorChange: onColorChanged,
//     );
//   }
// }

// class MaterialColorPicker extends StatefulWidget {
//   final Color selectedColor;
//   final ValueChanged<Color> onColorChange;

//   MaterialColorPicker(
//       {required this.selectedColor, required this.onColorChange});

//   @override
//   _MaterialColorPickerState createState() => _MaterialColorPickerState();
// }

// class _MaterialColorPickerState extends State<MaterialColorPicker> {
//   late Color _currentColor;

//   @override
//   void initState() {
//     super.initState();
//     _currentColor = widget.selectedColor;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         SingleChildScrollView(
//           child: ColorPicker(
//             pickerColor: _currentColor,
//             onColorChanged: (color) {
//               setState(() {
//                 _currentColor = color;
//               });
//             },
//             colorPickerWidth: 300.0,
//             pickerAreaHeightPercent: 0.7,
//             enableAlpha: false,
//             displayThumbColor: true,
//             showLabel: false,
//           ),
//         ),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             widget.onColorChange(_currentColor);
//             Navigator.of(context).pop();
//           },
//           child: Text('Select'),
//         ),
//       ],
//     );
//   }
// }
