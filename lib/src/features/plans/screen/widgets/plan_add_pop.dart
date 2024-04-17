import 'package:chahel_web_1/src/common/custom/validator.dart';
import 'package:chahel_web_1/src/features/plans/controller/plan_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PopUpPlanAddDialog {
  PopUpPlanAddDialog._();
  static final PopUpPlanAddDialog _instance = PopUpPlanAddDialog._();
  static PopUpPlanAddDialog get instance => _instance;

  void showPlanAddDialog({
    required BuildContext context,
    required TextEditingController classController,
    required TextEditingController mediumController,
    required TextEditingController cashController,
    required Future<bool> Function() buttonTap,
    required VoidCallback cancelButton,
    required Key formKeyValue,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return Consumer<PlanController>(builder: (context, value, _) {
            return AlertDialog(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: Container(
                width: MediaQuery.of(context).size.width / 4.2,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKeyValue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(16),
                            Text('Class',
                                style: Theme.of(context).textTheme.bodyLarge),
                            const Gap(4),
                            SizedBox(
                              width: 336,
                              child: PhysicalModel(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                elevation: 4,
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.labelLarge,
                                  readOnly: true,
                                  maxLines: 2,
                                  minLines: 1,
                                  validator: BValidator.validate,
                                  controller: classController,
                                  decoration: InputDecoration(
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            const Gap(16),
                            Text('Medium',
                                style: Theme.of(context).textTheme.bodyLarge),
                            const Gap(4),
                            SizedBox(
                              width: 336,
                              child: PhysicalModel(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                elevation: 4,
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.labelLarge,
                                  readOnly: true,
                                  maxLines: 2,
                                  minLines: 1,
                                  validator: BValidator.validate,
                                  controller: mediumController,
                                  decoration: InputDecoration(
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            const Gap(16),
                            Text('Plan period',
                                style: Theme.of(context).textTheme.bodyLarge),
                            const Gap(4),
                            SizedBox(
                              width: 336,
                              child: PhysicalModel(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                elevation: 4,
                                child: DropdownButtonFormField(
                                  
                                    validator: BValidator.validate,
                                    value: value.dropPlanText,
                                    alignment: Alignment.center,
                                    borderRadius: BorderRadius.circular(16),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: BorderSide.none)),
                                    hint: Text(
                                      '-- Select period --',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    items:
                                        value.planMonthMap.values.map((option) {
                                      return DropdownMenuItem(
                                          alignment: Alignment.centerLeft,
                                          value: option,
                                          child: Text(option,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge));
                                    }).toList(),
                                    onChanged: (option) {
                                      value.dropPlanText = option!;
                                    }),
                              ),
                            ),
                            const Gap(16),
                            Text('Total amount',
                                style: Theme.of(context).textTheme.bodyLarge),
                            const Gap(4),
                            SizedBox(
                              width: 336,
                              child: PhysicalModel(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                elevation: 4,
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.labelLarge,
                                  maxLines: 2,
                                  minLines: 1,
                                  validator: BValidator.validate,
                                  controller: cashController,
                                  decoration: InputDecoration(
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      hintText: 'Enter the total amount',
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            const Gap(24),
                            Center(
                                child: SizedBox(
                              height: 40,
                              width: 268,
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
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                child: (value.plan == null)
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
                            )
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
              ),
            );
          });
        });
  }
}