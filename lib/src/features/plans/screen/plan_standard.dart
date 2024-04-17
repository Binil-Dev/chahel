import 'dart:developer';

import 'package:chahel_web_1/src/common/custom/appbar.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/grid_image_stack.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlansStandardScreen extends StatefulWidget {
  const PlansStandardScreen({super.key});

  @override
  State<PlansStandardScreen> createState() => _PlansStandardScreenState();
}

class _PlansStandardScreenState extends State<PlansStandardScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final syllabusProvider =
          Provider.of<SyllabusController>(context, listen: false);

      await syllabusProvider.getStandardsList(onFailure: (value) {
        toastError(context, value);
      });
      log(syllabusProvider.standardsList.length.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SyllabusController, NavigationController>(
        builder: (context, syllabusProvider, navProvider, _) {
      return (syllabusProvider.fetchloading == false &&
                syllabusProvider.standardsList.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black12,
                ),
              )
            : CustomScrollView(
        slivers: [
          const CustomAppBar(
            title: 'Standards',
          ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16, vertical: 24),
            sliver: SliverFillRemaining(
              fillOverscroll: true,
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverToBoxAdapter(
                    
                    child: SizedBox(
                      width: 1200,
                      child: CustomScrollView(
                        slivers: [
                          SliverGrid.builder(
                              itemCount: syllabusProvider.standardsList.length,
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 182,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1 / 1),
                              itemBuilder: (context, index) {
                                return StackGridImage(
                                  borderRadius: 16,
                                  stackWidth: 120,
                                  //stackAlign: 60,
                                  boxColor: const Color(0xFFE7F3FF),
                                  text: syllabusProvider.standardsList[index].standard,
                                  backgroundImage: NetworkImage(
                                      syllabusProvider.standardsList[index].image),
                                  stack: true,
                                  iconColor: Colors.grey[100],
                                  onTap: () {
                                    syllabusProvider.selectStandardIdFn(
                                        syllabusProvider.standardsList[index]);
                          
                                    navProvider.setSubPageIndex(1);
                                    navProvider.pages[navProvider.pageIndex]
                                        [navProvider.subpageIndex];
                                  },
                          
                                  //EDIT SECTION
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
