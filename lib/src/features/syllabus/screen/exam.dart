import 'dart:developer';

import 'package:chahel_web_1/src/common/custom/appbar.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/exam_grid_stack.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/popup_exam_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({
    super.key,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  String? sectionId;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final syllabusProvider =
          Provider.of<SyllabusController>(context, listen: false);
      sectionId = syllabusProvider.selectedSection?.id;
      await syllabusProvider.getExamData(
          onFailure: (value) {
            toastError(context, value);
          },
          sectionId: sectionId ?? '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PopupExamDialog popUp = PopupExamDialog.instance;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Consumer2<SyllabusController, NavigationController>(
        builder: (context, syllabusProvider, navProvider, _) {
      return CustomScrollView(
        slivers: [
          CustomAppBar(
            leading: IconButton(
                onPressed: () {
                  navProvider.setSubPageIndex(4);
                  navProvider.pages[navProvider.pageIndex]
                      [navProvider.subpageIndex];
                  syllabusProvider.examList = null;
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: 'Exam',
          ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16, vertical: 24),
            sliver: SliverFillRemaining(
              fillOverscroll: true,
              child:
                  CustomScrollView(scrollDirection: Axis.horizontal, slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: 1200,
                    child: CustomScrollView(slivers: [
                      SliverGrid.builder(
                        itemCount:
                            (syllabusProvider.examList?.examData.length ?? 0) +
                                1,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 392,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1),
                        itemBuilder: (context, index) {
                          log('${syllabusProvider.examList?.examData.length}');
                          if (syllabusProvider.examList?.examData.length ==
                                  null ||
                              index ==
                                  syllabusProvider.examList?.examData.length) {
                            return Row(
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 160,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      popUp.showDialogExam(
                                        context: context,
                                        questionController: syllabusProvider
                                            .questionTextController,
                                        optionOneController: syllabusProvider
                                            .optionOneTextController,
                                        optionTwoController: syllabusProvider
                                            .optionTwoTextController,
                                        optionThreeController: syllabusProvider
                                            .optionThreeTextController,
                                        optionFourController: syllabusProvider
                                            .optionFourTextController,
                                        formKeyValue: formKey,
                                        buttonTap: () async {
                                          if (!formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.validate();
                                            return false;
                                          }
                                          log('EXAMMMMMMMMMMM');
                                          syllabusProvider.examData =
                                              syllabusProvider
                                                      .examList?.examData ??
                                                  [];

                                          syllabusProvider.totalExamModelField(
                                              sectionId ?? '');
                                          log('Section ID   ${sectionId}');

                                          await syllabusProvider.addExamsData(
                                              sectionId: sectionId ?? '',
                                              onSucess: () {
                                                toastSucess(context,
                                                    'Exam data is sucessfully saved');
                                              },
                                              onFailure: (value) {
                                                toastError(context, value);
                                              });
                                          return true;
                                        },
                                        cancelButton: () {
                                          syllabusProvider.removeAllExamField();
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        backgroundColor: Colors.lightBlue,
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
                              ],
                            );
                          } else {
                            return ExamGrid(
                              editButton: () {
                                syllabusProvider.setEditExamData(
                                    syllabusProvider.examList!.examData[index]);
                                popUp.showDialogExam(
                                  context: context,
                                  questionController:
                                      syllabusProvider.questionTextController,
                                  optionOneController:
                                      syllabusProvider.optionOneTextController,
                                  optionTwoController:
                                      syllabusProvider.optionTwoTextController,
                                  optionThreeController: syllabusProvider
                                      .optionThreeTextController,
                                  optionFourController:
                                      syllabusProvider.optionFourTextController,
                                  formKeyValue: formKey,
                                  buttonTap: () async {
                                    if (!formKey.currentState!.validate()) {
                                      formKey.currentState!.validate();
                                      return false;
                                    }

                                    syllabusProvider.editExam(
                                        index: index,
                                        sectionId: sectionId ?? '',
                                        fieldId: 'examData',
                                        key: syllabusProvider
                                            .examList!.examData[index].id,
                                        onSucess: () {
                                          syllabusProvider.removeAllExamField();
                                          toastSucess(context,
                                              "Sucessfully edited exam document");
                                        },
                                        onFailure: () {
                                          toastError(context,
                                              "Couldn't able to edit exam.");
                                        });
                                    return true;
                                  },
                                  cancelButton: () {
                                    syllabusProvider.removeAllExamField();
                                  },
                                );
                              },
                              deleteButton: () {
                                syllabusProvider.deleteExamsData(
                                    index: index,
                                    sectionId: sectionId ?? '',
                                    fieldId: 'examData',
                                    key: syllabusProvider
                                        .examList!.examData[index].id,
                                    onSucess: () {
                                      toastSucess(context,
                                          "Sucessfully deleted exam field.");
                                    },
                                    onFailure: () {
                                      toastError(context,
                                          "Couldn't able to delete exam field.");
                                    });
                              },
                              question: syllabusProvider
                                  .examList!.examData[index].question,
                              options: syllabusProvider
                                  .examList!.examData[index].options,
                              answer: syllabusProvider
                                  .examList!.examData[index].answer,
                            );
                          }
                        },
                      ),
                    ]),
                  ),
                ),
              ]),
            ),
          )
        ],
      );
    });
  }
}
