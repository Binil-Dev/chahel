import 'package:flutter/material.dart';

class TextStarField extends StatelessWidget {
  const TextStarField({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text('*',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.red))
      ],
    );
  }
}
