import 'package:chahel_web_1/src/utils/constants/colors/colors.dart';
import 'package:chahel_web_1/src/utils/constants/text/text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StackAddImage extends StatelessWidget {
  const StackAddImage({
    super.key,
    required this.stack,
    this.stackWidth,
    required this.addButtonWidth,
    required this.addOnTap,
    this.borderRadius,
    this.videoSection,
  });
  final bool stack;
  final bool? videoSection;
  final double? stackWidth;
  final double addButtonWidth;
  final VoidCallback addOnTap;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: addOnTap,
      child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        (borderRadius == null) ? 8 : borderRadius!),
                    color: Colors.black87),
              ),
            ),
            videoSection == true
                ? Positioned.fill(
                    left: 216,
                    child: Container(
                      width: 80,
                      decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(14),
                              bottomRight: Radius.circular(14))),
                      child: const Center(
                        child: Icon(Icons.play_circle_fill_rounded),
                      ),
                    ),
                  )
                : const SizedBox(),
            (stack == true)
                ? Positioned(
              
                    right: 0,
                    child: Container(
                      height: 48,
                      width: stackWidth,
                      decoration: BoxDecoration(
                          color: Colors.grey[500],
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                    ))
                : const Positioned(child: SizedBox()),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline_rounded,
                    color: BColors.lightGrey,
                    size: addButtonWidth,
                  ),
                  const Gap(6),
                  Text(
                    BText.add,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: BColors.lightGrey,
                        ),
                  )
                ],
              ),
            )
          ]),
    );
  }
}
