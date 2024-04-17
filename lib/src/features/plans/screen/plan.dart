import 'package:chahel_web_1/src/common/custom/pop_over_edit_delete.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/plans/controller/plan_controller.dart';
import 'package:chahel_web_1/src/features/plans/model/plan_model.dart';
import 'package:chahel_web_1/src/features/plans/screen/widgets/plan_add_pop.dart';
import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({
    super.key,
  });

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final PopUpPlanAddDialog _popUp = PopUpPlanAddDialog.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? stdId;
  String? medId;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final planProvider = Provider.of<PlanController>(context, listen: false);
      medId = planProvider.selectedMedium?.id ?? '';
      stdId = planProvider.selectedStandard?.id ?? '';
      await Provider.of<PlanController>(context, listen: false).getPlanList(
          onFailure: (value) {
            toastError(context, value);
          },
          stdId: stdId ?? '',
          medId: medId ?? '');
      // log(widget.);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<NavigationController, PlanController>(
        builder: (context, navProvider, planProvider, _) {
      return Scaffold(
          backgroundColor: Colors.white60,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navProvider.setSubPageIndex(1);
                navProvider.pages[navProvider.pageIndex]
                    [navProvider.subpageIndex];
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            toolbarHeight: 90,
            elevation: 10,
            backgroundColor: Colors.white60,
            surfaceTintColor: Colors.white60,
            clipBehavior: Clip.antiAlias,
            shadowColor: Colors.white.withOpacity(.3),
            title: Text(
              'Plan',
              style: Theme.of(context).textTheme.headlineSmall!,
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 800,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: (planProvider.planList.length < 2)
                      ? planProvider.planList.length + 1
                      : planProvider.planList.length,
                  itemBuilder: (context, index) {
                    if (index == planProvider.planList.length) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 60,
                              width: 184,
                              child: ElevatedButton(
                                onPressed: () {
                                  planProvider.setDataPlan();
                                  _popUp.showPlanAddDialog(
                                      context: context,
                                      classController:
                                          planProvider.standardController,
                                      mediumController:
                                          planProvider.mediumController,
                                      cashController:
                                          planProvider.cashController,
                                      buttonTap: () async {
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          _formKey.currentState!.validate();
                                          return false;
                                        }
                                        await planProvider.addNewPlan(
                                            onSucess: () {
                                          planProvider.clearPlanFields();
                                          toastSucess(context,
                                              'Saved plan sucessfully');
                                        }, onFailure: (value) {
                                          toastError(context, value);
                                        });
                                        return true;
                                      },
                                      cancelButton: () {
                                        planProvider.clearPlanFields();
                                      },
                                      formKeyValue: _formKey);
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 3,
                                    backgroundColor: const Color(0xFF11334E),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                child: Text('Add New',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white)),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox(
                        width: 800,
                        child: Stack(
                          children: [
                            Card(
                              surfaceTintColor: Colors.white,
                              color: const Color.fromARGB(255, 183, 210, 233),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 32, bottom: 32, left: 32, right: 40),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Standard',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        SizedBox(
                                          height: 56,
                                          width: 336,
                                          child: PhysicalModel(
                                            clipBehavior: Clip.antiAlias,
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            elevation: 4,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  planProvider.planList[index]
                                                          ?.standard ??
                                                      '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Medium',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        SizedBox(
                                          height: 56,
                                          width: 336,
                                          child: PhysicalModel(
                                            clipBehavior: Clip.antiAlias,
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            elevation: 4,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  planProvider.planList[index]
                                                          ?.medium ??
                                                      '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Current plan period',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        SizedBox(
                                          height: 56,
                                          width: 336,
                                          child: PhysicalModel(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            elevation: 4,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  planProvider
                                                      .planDurationConvert(
                                                    planProvider.planList[index]
                                                            ?.planDuration ??
                                                        0,
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Total amount of the plan',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        SizedBox(
                                          height: 56,
                                          width: 336,
                                          child: PhysicalModel(
                                            clipBehavior: Clip.antiAlias,
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            elevation: 4,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  "INR ${planProvider.planList[index]?.totalAmount.toString() ?? ''}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                top: 9,
                                right: 9,
                                child: PopOverEditDelete(
                                  editButton: () {
                                    planProvider.setEditDataPlan(
                                        planProvider.planList[index] ??
                                            PlanModel());
                                    _popUp.showPlanAddDialog(
                                        context: context,
                                        classController:
                                            planProvider.standardController,
                                        mediumController:
                                            planProvider.mediumController,
                                        cashController:
                                            planProvider.cashController,
                                        buttonTap: () async {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.validate();
                                            return false;
                                          }
                                          await planProvider.planUpdate(
                                              index: index,
                                              id: planProvider
                                                      .planList[index]?.id ??
                                                  '',
                                              onSucess: () {
                                                planProvider.clearPlanFields();
                                                toastSucess(context,
                                                    'Updated plan sucessfully');
                                              },
                                              onFailure: () {
                                                toastError(context,
                                                    'Plan is not updated');
                                              });
                                          return true;
                                        },
                                        cancelButton: () {
                                          planProvider.clearPlanFields();
                                        },
                                        formKeyValue: _formKey);
                                  },
                                  deleteButton: () {
                                    planProvider.planDelete(
                                        index: index,
                                        id: planProvider.planList[index]?.id ??
                                            '',
                                        onSucess: () {
                                          planProvider.clearPlanFields();
                                          toastSucess(context,
                                              ' Plan removed sucessfully');
                                        },
                                        onFailure: () {
                                          toastError(
                                              context, 'Plan is not removed');
                                        });
                                  },
                                  iconColor: Colors.grey[900],
                                ))
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ));
    });
  }
}
