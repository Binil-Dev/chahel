import 'package:chahel_web_1/src/common/custom/add_grid_stack.dart';
import 'package:chahel_web_1/src/common/custom/appbar.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/go_live_button.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/grid_image_stack.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/zoom_live_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/pop_single_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({super.key});

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final syllabusProvider =
          Provider.of<SyllabusController>(context, listen: false);
      final liveProvider =
          Provider.of<ZoomLiveController>(context, listen: false);
      await syllabusProvider.getStandardsList(onFailure: (value) {
        toastError(context, value);
      });

      await liveProvider.getLiveDetails(
          onSucess: (value) {},
          onFailure: (value) {
            toastError(context, value);
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    PopUpSingleTextDialog popUp = PopUpSingleTextDialog.instance;

    return Consumer2<SyllabusController, NavigationController>(
        builder: (context, syllabusProvider, navProvider, _) {
      return(syllabusProvider.fetchloading == false &&
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
            trailing: [
              SizedBox(
                height: 40,
                child: GoLiveButton(),
              ),
              Gap(32)
            ],
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
                              itemCount:
                                  syllabusProvider.standardsList.length + 1,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 182,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: 1 / 1),
                              itemBuilder: (context, index) {
                                if (index ==
                                    syllabusProvider.standardsList.length) {
                                  return StackAddImage(
                                    borderRadius: 16,
                                    stack: true,
                                    //stackAlign: 60,
                                    stackWidth: 116,
                                    addButtonWidth: 64,
                                    addOnTap: () {
                                      popUp.showSingleTextAddDialog(
                                        addButtonImageWidth: 180,
                                        context: context,
                                        dataType: 'Photo size',
                                        dataTypeSize: '98 x 98',
                                        nameTitle: 'Syllabus Name',
                                        labelTitle: 'Enter the name',
                                        titleController: syllabusProvider
                                            .standardTextController,
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

                                          await syllabusProvider
                                              .addNewStandards(onSucess: () {
                                            syllabusProvider
                                                .clearStandardFields();
                                            toastSucess(context,
                                                'Saved standard sucessfully.');
                                          }, onFailure: (value) {
                                            toastError(context, value);
                                          });
                                          return true;
                                        },
                                        cancelButton: () {
                                          syllabusProvider
                                              .clearStandardFields();
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  return StackGridImage(
                                    borderRadius: 16,
                                    stackWidth: 120,

                                    boxColor: const Color(0xFFE7F3FF),
                                    text: syllabusProvider
                                        .standardsList[index].standard,
                                    backgroundImage: NetworkImage(
                                        syllabusProvider
                                            .standardsList[index].image),
                                    stack: true,
                                    iconColor: Colors.grey[100],
                                    //tap to next page
                                    onTap: () {
                                      syllabusProvider.selectStandardIdFn(
                                          syllabusProvider
                                              .standardsList[index]);

                                      navProvider.setSubPageIndex(1);

                                      navProvider.pages[navProvider.pageIndex]
                                          [navProvider.subpageIndex];
                                    },

                                    //EDIT SECTION
                                    editButton: () {
                                      syllabusProvider.setEditDataStandards(
                                          syllabusProvider
                                                  .standardsList[index] 
                                             );
                                      popUp.showSingleTextAddDialog(
                                        addButtonImageWidth: 184,
                                        context: context,
                                        dataType: 'Photo size',
                                        dataTypeSize: '98 x 98',
                                        nameTitle: 'Standard Name',
                                        labelTitle: 'Enter the name',
                                        titleController: syllabusProvider
                                            .standardTextController,
                                        buttonText: 'Save',
                                        formKeyValue: formKey,
                                        addTap: () {
                                          //get image
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

                                          await syllabusProvider.editStandards(
                                              index: index,
                                              id: syllabusProvider
                                                  .standardsList[index].id,
                                              onSucess: () {
                                                syllabusProvider
                                                    .clearStandardFields();
                                                toastSucess(context,
                                                    'Sucessfully edited the standard.');
                                              },
                                              onFailure: () {
                                                toastError(context,
                                                    "Couldn't able to edit standard.");
                                              });

                                          return true;
                                        },
                                        cancelButton: () {
                                          syllabusProvider
                                              .clearStandardFields();
                                        },
                                      );
                                    },
                                    deleteButton: () {
                                      syllabusProvider.deleteStandards(
                                          index: index,
                                          onSucess: () {
                                            toastSucess(context,
                                                'Sucessfully removed standard.');
                                          },
                                          onFailure: () {
                                            toastError(context,
                                                "Couldn't able to remove standard, try again.");
                                          },
                                          id: syllabusProvider
                                              .standardsList[index].id,
                                          onboolToast: (value) {
                                            toastError(context, value);
                                          });
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
