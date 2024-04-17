import 'package:chahel_web_1/src/common/custom/add_grid_stack.dart';
import 'package:chahel_web_1/src/common/custom/appbar.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/grid_image_stack.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/add_banner/controller/banner_controller.dart';
import 'package:chahel_web_1/src/features/add_banner/screen/widget/pop_add_banner.dart';
import 'package:chahel_web_1/src/utils/constants/colors/colors.dart';
import 'package:chahel_web_1/src/utils/constants/text/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BannerController>(context, listen: false).getBanner(
          onFailure: (value) {
        toastError(context, value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannerController>(context);
    PopUpAddbanner popUp = PopUpAddbanner.instance;

    return (bannerProvider.fetchloading == false &&
            bannerProvider.bannerList.isEmpty)
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.black12,
            ),
          )
        : CustomScrollView(
            slivers: [
              const CustomAppBar(
                title: 'Add banner',
              ),
              SliverPadding(
                padding: const EdgeInsetsDirectional.all(12),
                sliver: SliverGrid.builder(
                    itemCount: (bannerProvider.bannerList.length) + 1,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 328,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 24,
                            childAspectRatio: 16 / 9),
                    itemBuilder: (context, index) {
                      if (index == bannerProvider.bannerList.length) {
                        return StackAddImage(
                          stack: false,
                          stackWidth: 150,
                          addButtonWidth: 64,
                          addOnTap: () {
                            popUp.showAddNewBannerDialog(
                              context: context,
                              buttonText: BText.save,
                              addTap: () {
                                bannerProvider.getImage(
                                    onSucess: (value) {},
                                    onFailure: (value) {
                                      toastError(context, value);
                                    });
                              },
                              buttonTap: () async {
                                if (bannerProvider.imageBytes == null) {
                                  toastError(context, 'Select a banner');
                                  return false;
                                } else {
                                  await bannerProvider.saveMainImage(
                                      imagepath: bannerProvider.imageBytes!,
                                      onSucess: (value) {},
                                      onFailure: (value) {
                                        toastError(context, value);
                                      });
                                  await bannerProvider.addNewBanner(
                                      onSucess: () {
                                    toastSucess(
                                        context, 'Image saved sucessfully');
                                    bannerProvider.clearImage();
                                  }, onFailure: (value) {
                                    toastError(context, value);
                                  });
                                  bannerProvider.clearImage();
                                }
                                return true;
                              },
                            );
                          },
                        );
                      } else {
                        //color is only for just showing
                        return StackGridImage(
                          text: '',
                          backgroundImage: NetworkImage(
                              bannerProvider.bannerList[index].image),
                          stack: false,
                          iconColor: BColors.lightGrey,
                          onTap: () {},
                          editButton: () {
                            bannerProvider.setEditBanner(
                                bannerProvider.bannerList[index]);
                            popUp.showAddNewBannerDialog(
                              context: context,
                              buttonText: BText.save,
                              addTap: () {
                                bannerProvider.getImage(
                                    onSucess: (value) {},
                                    onFailure: (value) {
                                      toastError(context, value);
                                    });
                              },
                              buttonTap: () async {
                                if (bannerProvider.imageBytes == null &&
                                    bannerProvider.imageUrl == null) {
                                  toastError(context, 'Select a banner');
                                  return false;
                                } else {
                                  if (bannerProvider.imageUrl == null) {
                                    await bannerProvider.saveMainImage(
                                        imagepath: bannerProvider.imageBytes!,
                                        onSucess: (value) {},
                                        onFailure: (value) {
                                          toastError(context, value);
                                        });
                                  }
                                  await bannerProvider.editBanner(
                                      id: bannerProvider.bannerList[index].id,
                                      onSucess: () {
                                        toastSucess(context,
                                            'Banner updated sucessfully.');
                                        bannerProvider.clearImage();
                                      },
                                      onFailure: () {
                                        toastError(context,
                                            "Couldn't able to edit the banner.");
                                      },
                                      index: index);
                                  bannerProvider.clearImage();
                                  return true;
                                }
                              },
                            );
                          },
                          deleteButton: () async {
                            await bannerProvider.deleteBanner(
                                index: index,
                                id: bannerProvider.bannerList[index].id,
                                onSucess: () {
                                  toastSucess(
                                      context, 'Image removed sucessfully.');
                                },
                                onFailure: () {
                                  toastError(context,
                                      "Couldn't able to remove the banner.");
                                });
                          },
                          editanddelete: true,
                        );
                      }
                    }),
              )
            ],
          );
  }
}
