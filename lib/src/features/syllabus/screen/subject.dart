import 'package:chahel_web_1/src/common/custom/add_grid_stack.dart';
import 'package:chahel_web_1/src/common/custom/appbar.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/grid_image_stack.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/model/subject_model.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/pop_single_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({
    super.key,
  });

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final syllabusProvider =
          Provider.of<SyllabusController>(context, listen: false);
      String medId = syllabusProvider.selectedMediumId?.id ?? '';
      await syllabusProvider.getSubjectList(
        onFailure: (value) {
          toastError(context, value);
        },
        medId: medId,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PopUpSingleTextDialog popUp = PopUpSingleTextDialog.instance;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Consumer2<SyllabusController, NavigationController>(
        builder: (context, syllabusProvider, navProvider, _) {
      return(syllabusProvider.fetchloading == false &&
                syllabusProvider.subjectList.isEmpty)
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
                  navProvider.setSubPageIndex(1);
                  navProvider.pages[navProvider.pageIndex]
                      [navProvider.subpageIndex];
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: 'Subjects',
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
                              itemCount: syllabusProvider.subjectList.length + 1,
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 336,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 16 / 9),
                              itemBuilder: (context, index) {
                                if (index == syllabusProvider.subjectList.length) {
                                  return StackAddImage(
                                    borderRadius: 12,
                                    stack: true,
                                    stackWidth: 168,
                                    addButtonWidth: 64,
                                    addOnTap: () {
                                      popUp.showSingleTextAddDialog(
                                        addButtonImageWidth: 320,
                                        context: context,
                                        dataType: 'Photo size',
                                        dataTypeSize: '328 x 164',
                                        nameTitle: 'Syllabus Name',
                                        labelTitle: 'Enter the name',
                                        titleController: syllabusProvider.subjectController,
                                        buttonText: 'Save',
                                        formKeyValue: formKey,
                                        addTap: () {
                                          syllabusProvider.getImage(
                                              onSucess: (value) {},
                                              onFailure: (value) {
                                                toastError(context,
                                                    "Couldn't able to get an image.");
                                              });
                                        },
                                        buttonTap: () async {
                                          if (syllabusProvider.imageBytes == null) {
                                            toastError(context, 'Add an image.');
                                            return false;
                                          }
                                          if (!formKey.currentState!.validate()) {
                                            formKey.currentState!.validate();
                                            return false;
                                          }
                                          await syllabusProvider.saveMainImage(
                                              imageBytes: syllabusProvider.imageBytes!,
                                              onSucess: (value) {},
                                              onFailure: (value) {
                                                toastError(context, value);
                                              });
                          
                                          await syllabusProvider.addNewSubject(onSucess: () {
                                            syllabusProvider.clearSubjectFields();
                                            toastSucess(context, 'Saved medium sucessfully.');
                                          }, onFailure: (value) {
                                            toastError(context, value);
                                          });
                                          return true;
                                        },
                                        cancelButton: () {
                                          syllabusProvider.clearSubjectFields();
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  return StackGridImage(
                                    stackWidth: 168,
                                    // stackAlign: 58,
                                    boxColor: const Color(0xFFE7F3FF),
                                    text: syllabusProvider.subjectList[index]!.subject,
                                    backgroundImage: NetworkImage(
                                        syllabusProvider.subjectList[index]?.image ?? ""),
                                    stack: true,
                                    iconColor: Colors.grey[400],
                                    onTap: () {
                                      //passing to chapter from subject
                                      syllabusProvider.selectSubjectIdFn(
                                          syllabusProvider.subjectList[index]!);
                          
                                      navProvider.setSubPageIndex(3);
                                      navProvider.pages[navProvider.pageIndex]
                                          [navProvider.subpageIndex];
                                    },
                                    editButton: () {
                                      syllabusProvider.setEditDataSubject(
                                          syllabusProvider.subjectList[index] ??
                                              SubjectModel(image: '', subject: ''));
                          
                                      popUp.showSingleTextAddDialog(
                                        addButtonImageWidth: 320,
                                        context: context,
                                        dataType: 'Photo size',
                                        dataTypeSize: '328 x 164',
                                        nameTitle: 'Syllabus Name',
                                        labelTitle: 'Enter the name',
                                        titleController: syllabusProvider.subjectController,
                                        buttonText: 'Save',
                                        formKeyValue: formKey,
                                        addTap: () {
                                          syllabusProvider.getImage(
                                              onSucess: (value) {},
                                              onFailure: (value) {
                                                toastError(context, value);
                                              });
                                        },
                                        buttonTap: () async {
                                          if (syllabusProvider.imageBytes == null &&
                                              syllabusProvider.imageUrl == null) {
                                            toastError(context, 'Add an image.');
                                            return false;
                                          }
                                          if (!formKey.currentState!.validate()) {
                                            formKey.currentState!.validate();
                                            return false;
                                          }
                                          if (syllabusProvider.imageUrl == null) {
                                            await syllabusProvider.saveMainImage(
                                                imageBytes: syllabusProvider.imageBytes!,
                                                onSucess: (value) {},
                                                onFailure: (value) {
                                                  toastError(context, value);
                                                });
                                          }
                          
                                          await syllabusProvider.editSubject(
                                              index: index,
                                              id: syllabusProvider.subjectList[index]?.id ??
                                                  '',
                                              onSucess: () {
                                                syllabusProvider.clearSubjectFields();
                                                toastSucess(context,
                                                    'Sucessfully edited the chapter.');
                                              },
                                              onFailure: () {
                                                toastError(context,
                                                    "Couldn't able to edit subject.");
                                              });
                                          return true;
                                        },
                                        cancelButton: () {
                                          syllabusProvider.clearSubjectFields();
                                        },
                                      );
                                    },
                                    deleteButton: () {
                                      syllabusProvider.subjectDelete(
                                        index: index,
                                        id: syllabusProvider.subjectList[index]?.id,
                                        onSucess: () {
                                          syllabusProvider.clearSubjectFields();
                                          toastSucess(
                                              context, 'Sucessfully removed subject.');
                                        },
                                        onFailure: () {
                                          toastError(context,
                                              "Couldn't able to removed subject, try again.");
                                        },
                                        onboolToast: (value) {
                                          toastError(context, value);
                                        },
                                      );
                                    },
                                    editanddelete: true,
                                  );
                                }
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
