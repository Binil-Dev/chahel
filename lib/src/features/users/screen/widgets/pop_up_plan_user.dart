import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/plans/model/plan_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/medium_model.dart';
import 'package:chahel_web_1/src/features/syllabus/model/standard_model.dart';
import 'package:chahel_web_1/src/features/users/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PopPlanUserScreen extends StatefulWidget {
  const PopPlanUserScreen(
      {super.key, required this.cancelButton, required this.buttonTap});
  final VoidCallback cancelButton;
  final Future<bool> Function() buttonTap;
  @override
  State<PopPlanUserScreen> createState() => _PopPlanUserScreenState();
}

class _PopPlanUserScreenState extends State<PopPlanUserScreen> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      title: Container(
        width: MediaQuery.of(context).size.width / 4.5,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Consumer<UserController>(builder: (context, userProvider, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(16),
                    Text('Standard',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const Gap(4),
                    SizedBox(
                      width: 336,
                      child: PhysicalModel(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        elevation: 4,
                        child: DropdownButtonFormField(
                            alignment: Alignment.center,
                            borderRadius: BorderRadius.circular(16),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none)),
                            hint: Text(
                              '-- Select standard --',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            value: userProvider.dropStandardId,
                            items: userProvider.standardsList!
                                .map<DropdownMenuItem<String>>(
                                    (StandardsModel? option) {
                              return DropdownMenuItem(
                                  alignment: Alignment.centerLeft,
                                  value: option?.id ?? '',
                                  child: Text(
                                      option?.standard ??
                                          'No standard selected',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge));
                            }).toList(),
                            onChanged: (option) async {
                              //userProvider.planList.clear();
                              //userProvider.plan = null;

                              if (option == null) return;
                              userProvider.dropStandardId = option;
                              await userProvider.getMediumList(
                                  onFailure: (value) {
                                    toastError(context, value);
                                  },
                                  stdId: userProvider.dropStandardId!);
                            }),
                      ),
                    ),
                    const Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Medium',
                            style: Theme.of(context).textTheme.bodyLarge),
                        const Gap(4),
                        SizedBox(
                          width: 336,
                          child: PhysicalModel(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            elevation: 4,
                            child: DropdownButtonFormField(
                                value: userProvider.dropMediumId,
                                alignment: Alignment.center,
                                borderRadius: BorderRadius.circular(16),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide.none)),
                                hint: Text(
                                  '-- Select Medium --',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                items: userProvider.mediumsList!
                                    .map((MediumModel? option) {
                                  return DropdownMenuItem(
                                      alignment: Alignment.centerLeft,
                                      value: option?.id,
                                      child: Text(
                                          option?.medium ??
                                              '-No medium available-',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge));
                                }).toList(),
                                onChanged: (option) async {
                                  userProvider.dropMediumId = null;

                                  if (option == null) return;
                                  userProvider.dropMediumId = option;
                                  await userProvider.getPlanList(
                                      onFailure: (value) {
                                        toastError(context, value);
                                      },
                                      stdId: userProvider.dropStandardId ?? '',
                                      medId: userProvider.dropMediumId ?? '');
                                }),
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    (userProvider.planList.isNotEmpty)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                      value: userProvider.plan,
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
                                      items: userProvider.planList
                                          .map((PlanModel? option) {
                                        String? planMonth =
                                            userProvider.planDurationConvert(
                                                option?.planDuration ?? 3);
                                        return DropdownMenuItem(
                                            alignment: Alignment.centerLeft,
                                            value: option,
                                            child: Text(planMonth,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge));
                                      }).toList(),
                                      onChanged: (option) {
                                        if (option == null) return;
                                        userProvider.planPriceController.text =
                                            '₹ ${option.totalAmount.toString()}';
                                        userProvider.plan = option;
                                      }),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const Gap(16),
                    (userProvider.planList.isNotEmpty)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Plan price',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              const Gap(4),
                              SizedBox(
                                width: 370,
                                child: PhysicalModel(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  elevation: 4,
                                  child: TextFormField(
                                    controller:
                                        userProvider.planPriceController,
                                    readOnly: true,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        hintText: 'Price of plan is shown here',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const Gap(24),
                    Center(
                        child: SizedBox(
                      height: 40,
                      width: 268,
                      child: ElevatedButton(
                        onPressed: () async {
                          final res = await widget.buttonTap.call();
                          if (res) {
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: (userProvider.plan == null)
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
                    )),
                  ],
                );
              }),
            ),
            Positioned(
                top: -9,
                right: -9,
                child: IconButton(
                    onPressed: () {
                      widget.cancelButton.call();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel_outlined)))
          ],
        ),
      ),
    );
  }
}
