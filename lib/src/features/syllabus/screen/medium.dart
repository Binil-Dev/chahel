import 'package:chahel_web_1/src/common/custom/add_grid_stack.dart';
import 'package:chahel_web_1/src/common/custom/appbar.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/grid_image_stack.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/pop_single_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediumScreen extends StatefulWidget {
  const MediumScreen({
    super.key,
  });

  @override
  State<MediumScreen> createState() => _MediumScreenState();
}

class _MediumScreenState extends State<MediumScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final syllabusProvider =
          Provider.of<SyllabusController>(context, listen: false);
      String stdId = syllabusProvider.selectedStandardId?.id ?? '';
      await syllabusProvider.getMediumList(
          onFailure: (value) {
            toastError(context, value);
          },
          stdId: stdId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PopUpSingleTextDialog popUp = PopUpSingleTextDialog.instance;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Consumer2<SyllabusController, NavigationController>(
        builder: (context, syllabusProvider, navProvider, _) {
      return (syllabusProvider.fetchloading == false &&
                syllabusProvider.mediumsList.isEmpty)
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
                  navProvider.setSubPageIndex(0);
                  navProvider.pages[navProvider.pageIndex]
                      [navProvider.subpageIndex];
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: 'Medium',
          ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16, vertical: 24),
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
                                  syllabusProvider.mediumsList.length + 1,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 328,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 16 / 9),
                              itemBuilder: (context, index) {
                                if (index ==
                                    syllabusProvider.mediumsList.length) {
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
                                        titleController:
                                            syllabusProvider.mediumController,
                                        buttonText: 'Save',
                                        formKeyValue: formKey,
                                        addTap: () {
                                          syllabusProvider.getImage(
                                              onSucess: (value) {},
                                              onFailure: (value) {
                                                toastError(context,
                                                    "Couldn't able to an get image.");
                                              });
                                        },
                                        buttonTap: () async {
                                          if (syllabusProvider.imageBytes ==
                                              null) {
                                            toastError(
                                                context, 'Add an image.');
                                            return false;
                                          }
                                          if (!formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.validate();
                                            return false;
                                          }

                                          await syllabusProvider.saveMainImage(
                                              imageBytes:
                                                  syllabusProvider.imageBytes!,
                                              onSucess: (value) {},
                                              onFailure: (value) {
                                                toastError(context, value);
                                              });

                                          await syllabusProvider.addNewMedium(
                                              onSucess: () {
                                            syllabusProvider
                                                .clearMediumFields();
                                            toastSucess(context,
                                                'Saved medium sucessfully.');
                                          }, onFailure: (value) {
                                            toastError(context, value);
                                          });
                                          return true;
                                        },
                                        cancelButton: () {
                                          syllabusProvider.clearMediumFields();
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  return StackGridImage(
                                    borderRadius: 12,
                                    stackWidth: 168,
                                    // stackAlign: 58,
                                    boxColor: const Color(0xFFE7F3FF),
                                    text: syllabusProvider
                                        .mediumsList[index].medium,
                                    backgroundImage: NetworkImage(
                                        syllabusProvider
                                            .mediumsList[index].image),
                                    stack: true,
                                    iconColor: Colors.grey[100],
                                    onTap: () {
                                      //here the selected medium details is passed to the subject page
                                      syllabusProvider.selectMediumIdFn(
                                          syllabusProvider.mediumsList[index]);

                                      navProvider.setSubPageIndex(2);

                                      navProvider.pages[navProvider.pageIndex]
                                          [navProvider.subpageIndex];
                                    },
                                    editButton: () {
                                      syllabusProvider.setEditDataMedium(
                                          syllabusProvider.mediumsList[index] 
                                              );

                                      popUp.showSingleTextAddDialog(
                                        addButtonImageWidth: 320,
                                        context: context,
                                        dataType: 'Photo size',
                                        dataTypeSize: '328 x 164',
                                        nameTitle: 'Syllabus Name',
                                        labelTitle: 'Enter the name',
                                        titleController:
                                            syllabusProvider.mediumController,
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
                                          if (syllabusProvider.imageBytes ==
                                                  null &&
                                              syllabusProvider.imageUrl ==
                                                  null) {
                                            toastError(
                                                context, 'Add an image.');
                                            return false;
                                          }
                                          if (!formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.validate();
                                            return false;
                                          }

                                          if (syllabusProvider.imageUrl ==
                                              null) {
                                            await syllabusProvider
                                                .saveMainImage(
                                                    imageBytes: syllabusProvider
                                                        .imageBytes!,
                                                    onSucess: (value) {},
                                                    onFailure: (value) {
                                                      toastError(
                                                          context, value);
                                                    });
                                          }

                                          await syllabusProvider.editMedium(
                                              index: index,
                                              id: syllabusProvider
                                                  .mediumsList[index].id,
                                              onSucess: () {
                                                syllabusProvider
                                                    .clearMediumFields();
                                                toastSucess(context,
                                                    'Sucessfully edited the medium.');
                                              },
                                              onFailure: () {
                                                toastError(context,
                                                    "Couldn't able to save medium.");
                                              });
                                          return true;
                                        },
                                        cancelButton: () {
                                          syllabusProvider.clearMediumFields();
                                        },
                                      );
                                    },
                                    deleteButton: () {
                                      syllabusProvider.mediumDelete(
                                        index: index,
                                        id: syllabusProvider
                                            .mediumsList[index].id,
                                        onSucess: () {
                                          syllabusProvider.clearMediumFields();
                                          toastSucess(context,
                                              'Sucessfully removed medium.');
                                        },
                                        onFailure: () {
                                          toastError(context,
                                              "Couldn't able to remove medium,try again.");
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
