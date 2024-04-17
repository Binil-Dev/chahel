import 'package:chahel_web_1/src/common/custom/pop_over_edit_delete.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SectionGrid extends StatelessWidget {
  const SectionGrid({
    super.key,
    required this.titleText,
    required this.subText,
    required this.pdfButtonText,
    required this.examButtonText,
    required this.examButtonTap,
    required this.pdfButtonTap,
    required this.termButtonText,
    required this.termButtonTap,
    required this.editButton,
    required this.deleteButton,
    this.iconColor,
    required this.image,
  });
  final String titleText;
  final String subText;
  final String examButtonText;
  final void Function() examButtonTap;
  final String pdfButtonText;
  final void Function() pdfButtonTap;
  final String termButtonText;
  final void Function() termButtonTap;
  final VoidCallback editButton;
  final VoidCallback deleteButton;
  final Color? iconColor;
  final ImageProvider image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Positioned.fill(
          child: Card(
            surfaceTintColor: Colors.white,
            color: Colors.white.withOpacity(.9),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            titleText,
                            style: Theme.of(context).textTheme.bodyLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          subText,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Gap(12),
                  Container(
                    height: 144,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(image: image, fit: BoxFit.fill)),
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_fill_rounded,
                        size: 50,
                      ),
                    ),
                  ),
                  const Gap(12),
                  SizedBox(
                    height: 36,
                    width: 268,
                    child: ElevatedButton(
                      onPressed: () {
                        examButtonTap.call();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Text(examButtonText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                  const Gap(8),
                  SizedBox(
                    height: 36,
                    width: 268,
                    child: ElevatedButton(
                      onPressed: () {
                        termButtonTap.call();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Text(termButtonText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                  const Gap(8),
                  SizedBox(
                    height: 36,
                    width: 268,
                    child: ElevatedButton(
                      onPressed: () {
                        pdfButtonTap.call();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: Text(pdfButtonText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
    );
  }
}

//////////
