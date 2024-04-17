import 'package:chahel_web_1/src/common/custom/validator.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PopupExamDialog {
  PopupExamDialog._();
  static final PopupExamDialog _instance = PopupExamDialog._();
  static PopupExamDialog get instance => _instance;

  void showDialogExam(
      {required BuildContext context,
      required TextEditingController questionController,
      required TextEditingController optionOneController,
      required TextEditingController optionTwoController,
      required TextEditingController optionThreeController,
      required TextEditingController optionFourController,
      required Future<bool> Function() buttonTap,
      required void Function() cancelButton,
      required Key formKeyValue}) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<SyllabusController>(builder: (context, value, _) {
          return AlertDialog(
            alignment: Alignment.center,
            scrollable: true,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            title: Stack(
              children: [
                SizedBox(
                  width: 385,
                  child: Form(
                    key: formKeyValue,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(16),
                        Text('Question',
                            style: Theme.of(context).textTheme.bodyLarge),
                        const Gap(4),
                        SizedBox(
                          width: 370,
                          child: PhysicalModel(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            elevation: 4,
                            child: TextFormField(
                              maxLines: 3,
                              validator: BValidator.validate,
                              controller: questionController,
                              decoration: InputDecoration(
                                  hintStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                  hintText: 'Enter the question',
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                        ),
                        const Gap(6),
                        Text('Option One',
                            style: Theme.of(context).textTheme.labelLarge),
                        const Gap(4),
                        SizedBox(
                          width: 360,
                          child: Row(
                            children: [
                              Text(
                                'A.)',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const Gap(4),
                              Expanded(
                                child: PhysicalModel(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  elevation: 4,
                                  child: TextFormField(
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    minLines: 1,
                                    maxLines: 3,
                                    validator: BValidator.validate,
                                    controller: optionOneController,
                                    decoration: InputDecoration(
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                        hintText: 'Enter the option one',
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(6),
                        Text('Option Two',
                            style: Theme.of(context).textTheme.labelLarge),
                        const Gap(4),
                        SizedBox(
                          width: 360,
                          child: Row(
                            children: [
                              Text(
                                'B.)',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const Gap(4),
                              Expanded(
                                child: PhysicalModel(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  elevation: 4,
                                  child: TextFormField(
                                    validator: BValidator.validate,
                                    controller: optionTwoController,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    minLines: 1,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                        hintText: 'Enter the option two',
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(6),
                        Text('Option three',
                            style: Theme.of(context).textTheme.labelLarge),
                        const Gap(4),
                        SizedBox(
                          width: 360,
                          child: Row(
                            children: [
                              Text(
                                'C.)',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const Gap(4),
                              Expanded(
                                child: PhysicalModel(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  elevation: 4,
                                  child: TextFormField(
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    minLines: 1,
                                    maxLines: 3,
                                    validator: BValidator.validate,
                                    controller: optionThreeController,
                                    decoration: InputDecoration(
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                        hintText: 'Enter the option three',
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(6),
                        Text('Option Four',
                            style: Theme.of(context).textTheme.labelLarge),
                        const Gap(4),
                        SizedBox(
                          width: 360,
                          child: Row(
                            children: [
                              Text(
                                'D.)',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const Gap(4),
                              Expanded(
                                child: PhysicalModel(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  elevation: 4,
                                  child: TextFormField(
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                    minLines: 1,
                                    maxLines: 3,
                                    validator: BValidator.validate,
                                    controller: optionFourController,
                                    decoration: InputDecoration(
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                        hintText: 'Enter the option four',
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(6),
                        Text('Select the correct answer option',
                            style: Theme.of(context).textTheme.labelLarge),
                        const Gap(4),
                        ////Dropdown button starts here
                        SizedBox(
                          width: 370,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 4, bottom: 4),
                            child: PhysicalModel(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              elevation: 4,
                              child: DropdownButtonFormField(
                                  style: Theme.of(context).textTheme.labelLarge,
                                  validator: BValidator.validate,
                                  value: value.droptext,
                                  alignment: Alignment.center,
                                  borderRadius: BorderRadius.circular(16),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          borderSide: BorderSide.none)),
                                  hint: Text(
                                    'Select options',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  items: value.optionNumberList.map((option) {
                                    return DropdownMenuItem(
                                        alignment: Alignment.centerLeft,
                                        value: option,
                                        child: Text(option,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium));
                                  }).toList(),
                                  onChanged: (option) {
                                    value.droptext = option!;
                                  }),
                            ),
                          ),
                        ),
                        const Gap(16),
                        Center(
                          child: SizedBox(
                            height: 40,
                            width: 298,
                            child: ElevatedButton(
                              onPressed: () async {
                                final res = await buttonTap.call();
                                if (res) {
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: (value.exams == null)
                                  ? Text('Save',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.white))
                                  : const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const Gap(8),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: -9,
                    right: -9,
                    child: IconButton(
                        onPressed: () {
                          cancelButton.call();
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.cancel_outlined)))
              ],
            ),
          );
        });
      },
    );
  }
}
