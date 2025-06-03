import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  final Function(int) onNumberTap;
  final Set<int> usedNumbers;

  const NumberPad({
    super.key,
    required this.onNumberTap,
    required this.usedNumbers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(9, (index) {
          final number = index + 1;
          final isUsedUp = usedNumbers.contains(number);

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Opacity(
                opacity: isUsedUp ? 0.0 : 1.0,
                child: IgnorePointer(
                  ignoring: isUsedUp,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => onNumberTap(number),
                    child: Text(number.toString()),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
