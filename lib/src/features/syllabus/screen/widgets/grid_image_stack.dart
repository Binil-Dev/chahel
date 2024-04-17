import 'package:chahel_web_1/src/common/custom/pop_over_edit_delete.dart';
import 'package:flutter/material.dart';

class StackGridImage extends StatelessWidget {
  const StackGridImage({
    super.key,
    this.boxColor,
    required this.text,
    required this.backgroundImage,
    required this.stack,
    this.iconColor,
    required this.onTap,

    this.stackWidth,
    this.borderRadius,
    required this.editButton,
    required this.deleteButton,
    required this.editanddelete,
  });
  final Color? boxColor;
  final String text;
  final ImageProvider backgroundImage;
  final bool stack;
  final Color? iconColor;
  final VoidCallback onTap;

  final double? stackWidth;
  final double? borderRadius;
  final VoidCallback editButton;
  final VoidCallback deleteButton;
  final bool editanddelete;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Container(
                width: 328,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        (borderRadius == null) ? 8 : borderRadius!),
                    image: DecorationImage(
                        image: backgroundImage, fit: BoxFit.fill)),
              ),
            ),
            (stack == true)
                ? Positioned(
                    // top: stackAlign,
                    right: 0,
                    child: Container(
                      height: 46,
                      width: stackWidth,
                      decoration: BoxDecoration(
                          color: boxColor ?? Colors.transparent,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Center(
                          child: Text(
                            text,
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ))
                : const Positioned(child: SizedBox()),
            (editanddelete == true)
                ? Positioned(
                    top: 1,
                    right: 1,
                    child: PopOverEditDelete(
                      editButton: () {
                        editButton.call();
                      },
                      deleteButton: () {
                        deleteButton.call();
                      },
                      iconColor: iconColor,
                    ))
                : const SizedBox()
          ]),
    );
  }
}
