import 'package:chahel_web_1/src/common/custom/pop_over_edit_delete.dart';
import 'package:chahel_web_1/src/utils/constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExamGrid extends StatelessWidget {
  const ExamGrid({
    required this.editButton,
    required this.deleteButton,
    this.iconColor,
    super.key,
    required this.question,
    required this.options,
    required this.answer,
  });
  final VoidCallback editButton;
  final VoidCallback deleteButton;
  final Color? iconColor;
  final String question;
  final List<String> options;
  final int answer;

  @override
  Widget build(BuildContext context) {
    List<String> list = ['A', 'B', 'C', 'D'];
    return Stack(
      children: [
        Card(
          surfaceTintColor: Colors.white,
          color: BColors.lightGrey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Question',
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(6),
              Text(
                question,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(6),
              Text(
                'Ans options(selected is the correct answer)',
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Gap(6),
              Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(),
                            color: (index == answer)
                                ? Colors.lightBlue
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2.0,
                                blurRadius: 7.0,
                                offset: const Offset(0,
                                    2.0), // Adjust for desired shadow position
                              )
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 240,
                                child: Row(
                                  children: [
                                    Text(
                                      '${list[index]}.)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Gap(4),
                                    Expanded(
                                      child: Text(
                                        maxLines: 3,
                                        options[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              (index == answer)
                                  ? const Icon(
                                      Icons.check_circle_outline_outlined)
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Gap(8),
                  )
                ],
              )
            ]),
          ),
        ),
        Positioned(
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
      ],
    );
  }
}
