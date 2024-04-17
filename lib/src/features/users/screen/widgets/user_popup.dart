import 'dart:developer';

import 'package:chahel_web_1/src/features/plans/model/plan_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PopViewAccount {
  PopViewAccount._();
  static final PopViewAccount _instance = PopViewAccount._();
  static PopViewAccount get instance => _instance;
  void showUserDetailsDialog(
      {required BuildContext context,
      required String name,
      required String age,
      required String dob,
      required String email,
      required String school,
      required String guardian,
      required int planDetails,
      required bool planStatus,
      required List<PlanModel> planDetialsList,
      required String? imageUrl}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            scrollable: true,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            content: Stack(
              children: [
                Container(
                  height: 560,
                  width: 360,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 8,
                      top: 24,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (imageUrl != null)
                              ? CircleAvatar(
                                  radius: 62,
                                  backgroundImage: NetworkImage(imageUrl),
                                )
                              : const CircleAvatar(
                                  radius: 62,
                                  backgroundImage:
                                      AssetImage('assets/images/no-photos.png'),
                                ),
                          const Gap(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //   Gap(28),
                              Text(
                                'Name',
                                style: Theme.of(context).textTheme.bodyLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(8),
                              Text(
                                ':',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Gap(8),
                              Text(
                                name,
                                style: Theme.of(context).textTheme.bodyLarge,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Gap(24),
                              Text(
                                'Age',
                                style: Theme.of(context).textTheme.labelMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(10),
                              Text(
                                ':',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const Gap(12),
                              Text(
                                age,
                                style: Theme.of(context).textTheme.labelMedium,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                          const Gap(8),
                          const Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                color: Colors.grey,
                              )),
                            ],
                          ),
                          const Gap(24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Date of birth',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(25),
                                  Text(
                                    ':',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(24),
                                  Expanded(
                                    child: Text(
                                      dob,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  const Gap(4),
                                ],
                              ),
                              const Gap(8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Email Id',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(56),
                                  Text(
                                    ':',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(24),
                                  Expanded(
                                    child: Text(
                                      email,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                              const Gap(8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Institution',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(41),
                                  Text(
                                    ':',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(24),
                                  Expanded(
                                    child: Text(
                                      school,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  )
                                ],
                              ),
                              const Gap(8),
                              Row(
                                children: [
                                  Text(
                                    'Gaurdian',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(44),
                                  Text(
                                    ':',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(24),
                                  Expanded(
                                    child: Text(
                                      guardian,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                              const Gap(8),
                              Row(
                                children: [
                                  Text(
                                    'Plan status',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(32),
                                  Text(
                                    ':',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(24),
                                  Expanded(
                                    child: Text(
                                      (planStatus) ? 'Active' : 'Inactive',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              const Gap(8),
                              Row(
                                children: [
                                  Text(
                                    'Plan details',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(28),
                                  Text(
                                    ':',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  const Gap(24),
                                  Expanded(
                                    child: Text(
                                      '${planDetails.toString()} plans',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              const Gap(8),
                              PlanListBuilder(
                                planDetialsList: planDetialsList,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.cancel_outlined)))
              ],
            ),
          );
        });
  }
}

//user details list view builder for plan
class PlanListBuilder extends StatelessWidget {
  const PlanListBuilder({
    super.key,
    required this.planDetialsList,
  });
  final List<PlanModel> planDetialsList;
  @override
  Widget build(BuildContext context) {
    log('plan details ${planDetialsList.length}');
    return (planDetialsList.isNotEmpty)
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: planDetialsList.length,
            itemBuilder: (context, index) {
              DateTime dateTime = planDetialsList[index].endDate!.toDate();
              String formattedDate =
                  "${dateTime.day}-${dateTime.month}-${dateTime.year}";
              return Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Plan ${index + 1}',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.blue),
                      ),
                      const Gap(69),
                      Text(
                        ':',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Gap(24),
                      Expanded(
                        child: Text(
                          '${planDetialsList[index].standard}/${planDetialsList[index].medium}',
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Text(
                        'Syllabus',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Gap(49),
                      Text(
                        ':',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Gap(24),
                      Expanded(
                        child: Text(
                          planDetialsList[index].standard ?? '',
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Text(
                        'Medium',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Gap(51),
                      Text(
                        ':',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Gap(24),
                      Expanded(
                        child: Text(
                          planDetialsList[index].medium ?? '',
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Text(
                        'Expiry date',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.red),
                      ),
                      const Gap(31),
                      Text(
                        ':',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Gap(24),
                      Expanded(
                        child: Text(
                          formattedDate,
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                  const Gap(8),
                ],
              );
            })
        : const SizedBox();
  }
}
