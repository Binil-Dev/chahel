import 'dart:developer';

import 'package:chahel_web_1/src/common/custom/appbar.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/grid_image_stack.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/plans/controller/plan_controller.dart';
import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlanMediumScreen extends StatefulWidget {
  const PlanMediumScreen({
    super.key,
  });

  @override
  State<PlanMediumScreen> createState() => _PlanMediumScreenState();
}

class _PlanMediumScreenState extends State<PlanMediumScreen> {
  String? stdId;
  String? standard;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final syllabusProvider =
          Provider.of<SyllabusController>(context, listen: false);
      stdId = syllabusProvider.selectedStandardId?.id ?? '';
      log(syllabusProvider.selectedStandardId!.id.toString());
      standard = syllabusProvider.selectedStandardId?.standard ?? '';
      await syllabusProvider.getMediumList(
          onFailure: (value) {
            toastError(context, value);
          },
          stdId: stdId ?? '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<SyllabusController, NavigationController, PlanController>(
        builder: (context, syllabusProvider, navProvider, planProvider, _) {
      return (syllabusProvider.fetchloading == false &&
              syllabusProvider.mediumsList.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black12,
              ),
            )
          : CustomScrollView(
              slivers: [
                CustomAppBar(
                  leading: IconButton(
                      onPressed: () {
                        navProvider.setSubPageIndex(0);
                        navProvider.pages[navProvider.pageIndex]
                            [navProvider.subpageIndex];
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  title: 'Medium',
                ),
                SliverPadding(
                  padding: const EdgeInsetsDirectional.all(24),
                  sliver: SliverFillRemaining(
                    child: CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: 1200,
                            child: CustomScrollView(
                              slivers: [
                                SliverGrid.builder(
                                    itemCount:
                                        syllabusProvider.mediumsList.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 336,
                                            crossAxisSpacing: 16,
                                            mainAxisSpacing: 16,
                                            childAspectRatio: 16 / 9),
                                    itemBuilder: (context, index) {
                                      return StackGridImage(
                                        borderRadius: 12,
                                        stackWidth: 160,
                                        //stackAlign: 58,
                                        boxColor: const Color(0xFFE7F3FF),
                                        text: syllabusProvider
                                            .mediumsList[index].medium,
                                        backgroundImage: NetworkImage(
                                            syllabusProvider
                                                .mediumsList[index].image),
                                        stack: true,
                                        iconColor: Colors.grey[100],
                                        onTap: () {
                                          log(syllabusProvider
                                              .selectedStandardId!.id!);

                                          planProvider.selectedMedStdId(
                                              syllabusProvider
                                                  .mediumsList[index],
                                              syllabusProvider
                                                  .selectedStandardId!);
                                          navProvider.setSubPageIndex(2);
                                          navProvider
                                                  .pages[navProvider.pageIndex]
                                              [navProvider.subpageIndex];
                                        },
                                        editButton: () {},
                                        deleteButton: () {},
                                        editanddelete: false,
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
    });
  }
}
