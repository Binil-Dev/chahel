import 'package:chahel_web_1/src/common/custom/appbar.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/pop_triple_text.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/section_grid_stack.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionScreen extends StatefulWidget {
  const SectionScreen({
    super.key,
  });

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  String? chapterName;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final syllabusProvider =
          Provider.of<SyllabusController>(context, listen: false);
      String chapterId = syllabusProvider.selectedChaptersId?.id ?? '';
      chapterName = syllabusProvider.selectedChaptersId?.chapter ?? '';
      Provider.of<SyllabusController>(context, listen: false).getSectionList(
          onFailure: (value) {
            toastError(context, value);
          },
          chapterId: chapterId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    PopUpDialogThreeTextField popUp = PopUpDialogThreeTextField.instance;

    return Consumer2<SyllabusController, NavigationController>(
        builder: (context, syllabusProvider, navProvider, _) {
      return (syllabusProvider.fetchloading == false &&
                syllabusProvider.sectionlist.isEmpty)
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
                  navProvider.setSubPageIndex(3);
                  navProvider.pages[navProvider.pageIndex]
                      [navProvider.subpageIndex];
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: chapterName ?? '',
            // trailing: const [
            //   SizedBox(height: 40, width: 280, child: SearchButton()),
            //   Gap(32),
            // ],
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
                            itemCount: syllabusProvider.sectionlist.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 320,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: .6),
                            itemBuilder: (context, index) {
                              if (index ==
                                  syllabusProvider.sectionlist.length) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 160,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          popUp.showTripleTextAddDialog(
                                            context: context,
                                            imageBox: true,
                                            addImageTap: () {
                                              syllabusProvider.getImage(
                                                  onSucess: (value) {
                                                syllabusProvider.imageUrl =
                                                    null;
                                              }, onFailure: (value) {
                                                toastError(context,
                                                    "Couldn't able to get image");
                                              });
                                            },
                                            //section number
                                            sectionNumber: true,
                                            hintSectionNumber:
                                                'Enter the number of the section',
                                            sectionNumberController:
                                                syllabusProvider
                                                    .sectionNumberTextController,
                                            sectionNumberName: 'section number',
                                            //title
                                            dataType: 'Photo size',
                                            dataTypeSize: '328 x 164',
                                            nameTitle: 'Section name',
                                            hintTitle: 'Enter section title',
                                            hintYoutube: 'Enter a youtube url',
                                            titleController: syllabusProvider
                                                .sectionTitleTextController,
                                            aboutTitle: 'About',
                                            aboutController: syllabusProvider
                                                .sectionAboutTextController,
                                            hintAbout:
                                                'Enter about the section',
                                            buttonText: 'Save',
                                            youtubeUrl: true,
                                            youtubeController: syllabusProvider
                                                .sectionYoutubeURLTextController,
                                            pdfField: true,
                                            aboutMaxLines: 3,
                                            formKeyValue: formKey,
                                            pdfTap: () async {
                                              await syllabusProvider.getPdfFile(
                                                  onSucess: () {},
                                                  onFailure: () {
                                                    toastError(context,
                                                        'Could not able to get the PDF.');
                                                  });

                                              await syllabusProvider.getPdfUrl(
                                                  pdfFile:
                                                      syllabusProvider.pdfFile,
                                                  onSucess: () {
                                                    toastSucess(context,
                                                        'PDF is added.');
                                                  },
                                                  onFailure: () {
                                                    toastError(context,
                                                        'PDF file is not saved.');
                                                  });
                                              // syllabusProvider.pdfFile = null;
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
                                                formKey.currentState!
                                                    .validate();
                                                return false;
                                              }
                                              if (syllabusProvider.pdfUrl ==
                                                  null) {
                                                toastError(
                                                    context, 'Add a PDF file.');
                                                return false;
                                              }

                                              await syllabusProvider
                                                  .saveMainImage(
                                                      imageBytes:
                                                          syllabusProvider
                                                              .imageBytes,
                                                      onSucess: (value) {},
                                                      onFailure: (value) {
                                                        toastError(
                                                            context, value);
                                                      });

                                              await syllabusProvider
                                                  .addNewSection(onSucess: () {
                                                toastSucess(context,
                                                    'Section is saved sucessfully.');
                                                syllabusProvider
                                                    .clearSectionFields();
                                              }, onFailure: (value) {
                                                toastError(context, value);
                                              });

                                              return true;
                                            },
                                            cancelTap: () {
                                              syllabusProvider
                                                  .clearSectionFields();
                                            },
                                            pdfCancelButton: () {
                                              syllabusProvider.cancelPdf(
                                                  pdfUrl:
                                                      syllabusProvider.pdfUrl!,
                                                  onSucess: () {
                                                    syllabusProvider
                                                        .pdfRemove();
                                                    toastSucess(context,
                                                        'PDF is removed.');
                                                  },
                                                  onFailure: () {
                                                    toastError(context,
                                                        "PDF can't removed.");
                                                  });
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
                                return SectionGrid(
                                  titleText:
                                      '${syllabusProvider.sectionlist[index].sectionNumber ?? 0}- ${syllabusProvider.sectionlist[index].sectionName}',
                                  subText: syllabusProvider
                                          .sectionlist[index].description ??
                                      'Description',
                                  examButtonText: 'Set Exam',
                                  examButtonTap: () {
                                    syllabusProvider.selectSectionIdFn(
                                        syllabusProvider.sectionlist[index]);

                                    navProvider.setSubPageIndex(5);
                                    navProvider.pages[navProvider.pageIndex]
                                        [navProvider.subpageIndex];
                                  },
                                  pdfButtonText: 'Download PDF',
                                  pdfButtonTap: () {
                                    //PDF needed to be added
                                    syllabusProvider.downloadPDF(
                                        url: syllabusProvider
                                                .sectionlist[index].pdfUrl ??
                                            '',
                                        fileName: syllabusProvider
                                                .sectionlist[index]
                                                .sectionName ??
                                            'Section');
                                  },
                                  termButtonText: 'Terms & Conditions',
                                  termButtonTap: () {
                                    syllabusProvider.selectSectionIdTerms(
                                        syllabusProvider.sectionlist[index]);

                                    navProvider.setSubPageIndex(6);
                                    navProvider.pages[navProvider.pageIndex]
                                        [navProvider.subpageIndex];
                                  },
                                  editButton: () {
                                    syllabusProvider.setEditDataSection(
                                        syllabusProvider.sectionlist[index]);

                                    popUp.showTripleTextAddDialog(
                                      context: context,
                                      imageBox: true,
                                      addImageTap: () {
                                        syllabusProvider.getImage(
                                            onSucess: (value) {
                                          syllabusProvider.imageUrl = null;
                                        }, onFailure: (value) {
                                          toastError(context,
                                              "Couldn't able to get image");
                                        });
                                      },
                                      dataType: 'Photo size',
                                      dataTypeSize: '328 x 164',
                                      //section number
                                      sectionNumber: true,
                                      hintSectionNumber:
                                          'Enter the number of the section',
                                      sectionNumberController: syllabusProvider
                                          .sectionNumberTextController,
                                      sectionNumberName: 'Section number',
                                      //title
                                      nameTitle: 'Section name',
                                      hintTitle: 'Enter section title',
                                      titleController: syllabusProvider
                                          .sectionTitleTextController,
                                      aboutTitle: 'About',
                                      aboutController: syllabusProvider
                                          .sectionAboutTextController,
                                      hintAbout: 'Enter about the section',
                                      buttonText: 'Save',
                                      youtubeUrl: true,
                                      youtubeController: syllabusProvider
                                          .sectionYoutubeURLTextController,
                                      pdfField: true,
                                      aboutMaxLines: 3,
                                      formKeyValue: formKey,
                                      pdfTap: () async {
                                        await syllabusProvider.getPdfFile(
                                            onSucess: () {},
                                            onFailure: () {
                                              toastError(context,
                                                  'Could not able to get the PDF.');
                                            });

                                        await syllabusProvider.getPdfUrl(
                                            pdfFile: syllabusProvider.pdfFile,
                                            onSucess: () {
                                              toastSucess(
                                                  context, 'PDF is added.');
                                            },
                                            onFailure: () {
                                              toastError(context,
                                                  'PDF file is not saved.');
                                            });
                                      },
                                      buttonTap: () async {
                                        if (syllabusProvider.imageBytes ==
                                                null &&
                                            syllabusProvider.imageUrl == null) {
                                          toastError(context, 'Add an image.');
                                          return false;
                                        }
                                        if (!formKey.currentState!.validate()) {
                                          formKey.currentState!.validate();
                                          return false;
                                        }
                                        if (syllabusProvider.pdfUrl == null) {
                                          toastError(
                                              context, 'Add a PDF file.');
                                          return false;
                                        }

                                        if (syllabusProvider.imageUrl == null) {
                                          await syllabusProvider.saveMainImage(
                                              imageBytes:
                                                  syllabusProvider.imageBytes!,
                                              onSucess: (value) {},
                                              onFailure: (value) {
                                                toastError(context, value);
                                              });
                                        }

                                        await syllabusProvider.sectionEdit(
                                            index: index,
                                            id: syllabusProvider
                                                    .sectionlist[index].id ??
                                                '',
                                            onSucess: () {
                                              toastSucess(context,
                                                  'Sucessfully edited the section.');
                                              syllabusProvider
                                                  .clearSectionFields();
                                            },
                                            onFailure: () {
                                              toastError(context,
                                                  "Couldn't able to edit section.");
                                            });

                                        return true;
                                      },
                                      cancelTap: () {
                                        syllabusProvider.clearSectionFields();
                                      },
                                      pdfCancelButton: () {
                                        syllabusProvider.cancelPdf(
                                            pdfUrl: syllabusProvider.pdfUrl!,
                                            onSucess: () {
                                              syllabusProvider.pdfRemove();
                                              toastSucess(
                                                  context, 'PDF is removed.');
                                            },
                                            onFailure: () {
                                              toastError(context,
                                                  "PDF can't removed.");
                                            });
                                      },
                                    );
                                  },
                                  deleteButton: () {
                                    syllabusProvider.sectionDelete(
                                        index: index,
                                        id: syllabusProvider
                                                .sectionlist[index].id ??
                                            '',
                                        pdfUrl: syllabusProvider
                                                .sectionlist[index].pdfUrl ??
                                            '',
                                        onSucess: () {
                                          toastSucess(context,
                                              'Sucessfully removed section.');
                                        },
                                        onFailure: () {
                                          toastError(context,
                                              "Couldn't able to removed section, try again.");
                                        },
                                        onboolToast: (value) {
                                          toastError(context, value);
                                        });
                                  },
                                  //image as thumbnail
                                  image: NetworkImage(syllabusProvider
                                          .sectionlist[index].image ??
                                      ''),
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
    });
  }
}
