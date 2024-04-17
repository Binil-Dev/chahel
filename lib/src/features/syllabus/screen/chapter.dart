import 'package:chahel_web_1/src/common/custom/add_grid_stack.dart';
import 'package:chahel_web_1/src/common/custom/appbar.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/chapter_grid_stack.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/pop_triple_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({
    super.key,
  });

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  String? subjectName;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final syllabusProvider =
          Provider.of<SyllabusController>(context, listen: false);
      String subId = syllabusProvider.selectedSubjectId?.id ?? '';
      subjectName = syllabusProvider.selectedSubjectId?.subject ?? '';
      await syllabusProvider.getChapterList(
          onFailure: (value) {
            toastError(context, value);
          },
          subId: subId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PopUpDialogThreeTextField popUp = PopUpDialogThreeTextField.instance;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Consumer2<SyllabusController, NavigationController>(
        builder: (context, syllabusProvider, navProvider, _) {
      return (syllabusProvider.fetchloading == false &&
                syllabusProvider.chaptersList.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black12,
                ),
              )
            :CustomScrollView(
        slivers: [
          CustomAppBar(
              leading: IconButton(
                  onPressed: () {
                    navProvider.setSubPageIndex(2);
                    navProvider.pages[navProvider.pageIndex]
                        [navProvider.subpageIndex];
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              title: '$subjectName'),
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
                            itemCount: syllabusProvider.chaptersList.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 376,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 1.5),
                            itemBuilder: (context, index) {
                              if (index ==
                                  syllabusProvider.chaptersList.length) {
                                return StackAddImage(
                                    borderRadius: 14,
                                    videoSection: true,
                                    stack: false,
                                    addButtonWidth: 56,
                                    addOnTap: () {
                                      popUp.showTripleTextAddDialog(
                                        context: context,
                                        formKeyValue: formKey,
                                        //section number
                                        sectionNumber: true,
                                        hintSectionNumber:
                                            'Enter the number of the chapter',
                                        sectionNumberController:
                                            syllabusProvider
                                                .chapterNumberTextController,
                                        sectionNumberName: 'Chapter number',
                                        //title
                                        nameTitle: 'Chapter',
                                        hintTitle: 'Enter the chapter name',
                                        titleController: syllabusProvider
                                            .chapterTitleTextController,
                                        //about
                                        aboutMaxLines: 3,
                                        aboutTitle: 'About',
                                        aboutController: syllabusProvider
                                            .chapterAboutTextController,
                                        hintAbout:
                                            'Description about the chapter',

                                        buttonText: 'Save',
                                        buttonTap: () async {
                                          if (!formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.validate();
                                            return false;
                                          }

                                          await syllabusProvider.addNewChapter(
                                              onSucess: () {
                                            syllabusProvider
                                                .clearChapterFields();
                                            toastSucess(context,
                                                'Sucessfully added the chapter.');
                                          }, onFailure: (value) {
                                            toastError(context, value);
                                          });
                                          return true;
                                        },
                                        pdfField: false,
                                        cancelTap: () {
                                          syllabusProvider.clearChapterFields();
                                        },
                                        youtubeController:
                                            TextEditingController(),
                                      );
                                    });
                              } else {
                                return ChapterGridStack(
                                  iconColor: Colors.grey[200],
                                  titleText:
                                      '${syllabusProvider.chaptersList[index].sectionNumber ?? 0}- ${syllabusProvider.chaptersList[index].chapter}',
                                  subText: syllabusProvider
                                      .chaptersList[index].about,
                                  editButton: () {
                                    syllabusProvider.setEditDataChapter(
                                        syllabusProvider.chaptersList[index]);
                                    popUp.showTripleTextAddDialog(
                                      context: context,
                                      formKeyValue: formKey,
                                      //section number
                                      sectionNumber: true,
                                      hintSectionNumber:
                                          'Enter the number of the chapter',
                                      sectionNumberController: syllabusProvider
                                          .chapterNumberTextController,
                                      sectionNumberName: 'Chapter number',
                                      //title
                                      nameTitle: 'Chapter',
                                      hintTitle: 'Enter the chapter name',
                                      titleController: syllabusProvider
                                          .chapterTitleTextController,
                                      //about
                                      aboutTitle: 'About',
                                      aboutMaxLines: 3,
                                      aboutController: syllabusProvider
                                          .chapterAboutTextController,
                                      hintAbout:
                                          'Description about the chapter',
                                      buttonText: 'Save',
                                      buttonTap: () async {
                                        if (!formKey.currentState!.validate()) {
                                          formKey.currentState!.validate();
                                          return false;
                                        }

                                        await syllabusProvider.chapterEdit(
                                            index: index,
                                            id: syllabusProvider
                                                    .chaptersList[index].id ??
                                                '',
                                            onSucess: () {
                                              syllabusProvider
                                                  .clearChapterFields();
                                              toastSucess(context,
                                                  'Sucessfully edited the chapter.');
                                            },
                                            onFailure: () {
                                              toastError(context,
                                                  "Couldn't able to edit chapter");
                                            });
                                        return true;
                                      },
                                      pdfField: false,
                                      cancelTap: () {
                                        syllabusProvider.clearChapterFields();
                                      },
                                      youtubeController:
                                          TextEditingController(),
                                    );
                                  },
                                  deleteButton: () {
                                    syllabusProvider.chapterDelete(
                                        index: index,
                                        id: syllabusProvider
                                                .chaptersList[index].id ??
                                            '',
                                        onSucess: () {
                                          toastSucess(context,
                                              'Sucessfully removed chapter.');
                                        },
                                        onFailure: () {
                                          toastError(context,
                                              "Couldn't able to removed chapter, try again.");
                                        },
                                        onboolToast: (value) {
                                          toastError(context, value);
                                        });
                                  },
                                  onTap: () {
                                    syllabusProvider.selectedChapterIdFn(
                                        syllabusProvider.chaptersList[index]);

                                    navProvider.setSubPageIndex(4);
                                    navProvider.pages[navProvider.pageIndex]
                                        [navProvider.subpageIndex];
                                  },
                                );
                              }
                            },
                          ),
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
    }
    );
  }
}
