import 'package:flutter/material.dart';

class NextHoursWeatherContainer extends StatelessWidget {
  const NextHoursWeatherContainer({
    super.key,
    required this.header,
    required this.subheader,
    required this.headerSize,
    required this.subheaderSize,
  });

  final String header;
  final String subheader;
  final double headerSize;
  final double subheaderSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          header,
          style: TextStyle(
            fontSize: headerSize,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          subheader,
          style: TextStyle(
            fontSize: subheaderSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
