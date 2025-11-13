import 'package:flutter/material.dart';

class PriceWithDirham extends StatelessWidget {
  final String price;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double symbolSize;
  final double symbolBaselineOffset;

  const PriceWithDirham({
    super.key,
    required this.price,
    this.fontSize = 16,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w600,
    this.symbolSize = 14,
    this.symbolBaselineOffset = -1.0, 
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Transform.translate(
              offset: Offset(0, symbolBaselineOffset),
              child: Text(
                String.fromCharCode(0xe800),
                style: TextStyle(
                  fontFamily: 'AEDSymbolFont',
                  fontSize: symbolSize,
                  color: color,
                ),
              ),
            ),
            
          ),
          const WidgetSpan(
            child: SizedBox(width: 5),
          ),
          TextSpan(
            text: price,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
