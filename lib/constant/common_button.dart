import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final dynamic child;
  final VoidCallback onTap;
  const CommonButton({super.key, this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )
          ),
          onPressed: onTap,
          child: child,
      ));
  }
}
