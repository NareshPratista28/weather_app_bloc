import 'package:flutter/material.dart';

class WeatherDetailTile extends StatelessWidget {
  final String title;
  final String value;
  final String assetPath;

  const WeatherDetailTile({
    super.key,
    required this.title,
    required this.value,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          scale: 8,
        ),
        SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        )
      ],
    );
  }
}
