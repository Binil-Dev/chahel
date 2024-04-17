import 'package:chahel_web_1/src/common/custom/pop_over_edit_delete.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ChapterGridStack extends StatelessWidget {
  const ChapterGridStack(
      {super.key,
      required this.titleText,
      required this.subText,
      required this.editButton,
      required this.deleteButton,
      this.iconColor,
      required this.onTap});
  final String titleText;
  final String subText;
  final VoidCallback editButton;
  final VoidCallback deleteButton;
  final VoidCallback onTap;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned.fill(
              child: Card(
            surfaceTintColor: Colors.white,
            color: Colors.white.withOpacity(.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleText,
                          style: Theme.of(context).textTheme.bodyLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(4),
                        Text(
                          subText,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 72,
                  decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(14),
                          bottomRight: Radius.circular(14))),
                  child: const Center(
                    child: Icon(Icons.play_circle_fill_rounded),
                  ),
                )
              ],
            ),
          )),
          Positioned(
              top: 1,
              right: 1,
              child: PopOverEditDelete(
                editButton: () {
                  editButton.call();
                },
                deleteButton: deleteButton,
                iconColor: iconColor,
              ))
        ],
      ),
    );
  }
}
