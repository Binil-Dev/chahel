import 'package:chahel_web_1/src/common/custom/validator.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:chahel_web_1/src/utils/constants/colors/colors.dart';
import 'package:chahel_web_1/src/utils/constants/image/image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PopUpDialogThreeTextField {
  PopUpDialogThreeTextField._();
  static final PopUpDialogThreeTextField _instance =
      PopUpDialogThreeTextField._();
  static PopUpDialogThreeTextField get instance => _instance;

  void showTripleTextAddDialog(
      {required BuildContext context,
      String? dataType,
      bool? imageBox,
      String? dataTypeSize,
      //section or chapter number
      String? hintSectionNumber,
      String? sectionNumberName,
      required bool? sectionNumber,
      required TextEditingController sectionNumberController,
      //title
      required String nameTitle,
      required String hintTitle,
      required TextEditingController titleController,
      //about
      required String aboutTitle,
      required TextEditingController aboutController,
      required String hintAbout,
      String? hintYoutube,
      required String buttonText,
      required Future<bool> Function() buttonTap,
      required VoidCallback cancelTap,
      VoidCallback? pdfTap,
      VoidCallback? addImageTap,
      bool? youtubeUrl,
      required TextEditingController youtubeController,
      required bool pdfField,
      required int aboutMaxLines,
      required Key formKeyValue,
      VoidCallback? pdfCancelButton}) {
    showDialog(
        context: context,
        builder: (context) {
          return Consumer<SyllabusController>(builder: (context, value, _) {
            return AlertDialog(
              scrollable: true,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: Stack(
                children: [
                  SizedBox(
                    width: 360,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          (imageBox == true)
                              ? Column(
                                  children: [
                                    (value.imageBytes == null &&
                                            value.imageUrl == null)
                                        ? Container(
                                            height: 172,
                                            width: 320,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: Colors.black87),
                                            child: IconButton(
                                                onPressed: addImageTap,
                                                icon: const Icon(
                                                  Icons.add_circle_outline,
                                                  color: Colors.white,
                                                  size: 72,
                                                )),
                                          )
                                        : (value.imageBytes != null)
                                            ? GestureDetector(
                                                onTap: addImageTap,
                                                child: Center(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 16),
                                                  child: Container(
                                                    height: 172,
                                                    width: 320,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        image: DecorationImage(
                                                            image: MemoryImage(value
                                                                .imageBytes!))),
                                                  ),
                                                )),
                                              )
                                            : GestureDetector(
                                                onTap: addImageTap,
                                                child: Center(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 16),
                                                  child: Container(
                                                    height: 172,
                                                    width: 320,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                value
                                                                    .imageUrl!))),
                                                  ),
                                                )),
                                              ),
                                    const Gap(8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(dataType ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge),
                                        const Gap(8),
                                        (dataTypeSize == null)
                                            ? const Text('')
                                            : Text(dataTypeSize,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          const Gap(16),
                          Form(
                              key: formKeyValue,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(nameTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                    const Gap(4),
                                    SizedBox(
                                      width: 320,
                                      child: PhysicalModel(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        elevation: 4,
                                        child: TextFormField(
                                          maxLines: 2,
                                          minLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                          validator: BValidator.validate,
                                          controller: titleController,
                                          decoration: InputDecoration(
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                              hintText: hintTitle,
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none)),
                                        ),
                                      ),
                                    ),
                                    const Gap(8),
                                    Text(aboutTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                    const Gap(4),
                                    SizedBox(
                                        width: 320,
                                        child: PhysicalModel(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          elevation: 4,
                                          child: TextFormField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            validator: BValidator.validate,
                                            controller: aboutController,
                                            maxLines: aboutMaxLines,
                                            decoration: InputDecoration(
                                                hintText: hintAbout,
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                                alignLabelWithHint: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide.none,
                                                )),
                                          ),
                                        )),
                                    const Gap(8),
                                    (youtubeUrl == true)
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Youtube URL',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge),
                                              const Gap(4),
                                              SizedBox(
                                                width: 320,
                                                child: PhysicalModel(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  elevation: 4,
                                                  child: TextFormField(
                                                    minLines: 1,
                                                    maxLines: 3,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge!
                                                        .copyWith(
                                                            color: BColors
                                                                .buttonLightColor),
                                                    validator:
                                                        BValidator.validate,
                                                    controller:
                                                        youtubeController,
                                                    decoration: InputDecoration(
                                                        hintText: hintYoutube,
                                                        hintStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelMedium,
                                                        border:
                                                            const OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    (sectionNumber == true)
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Gap(8),
                                              Text(sectionNumberName ?? '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge),
                                              const Gap(4),
                                              SizedBox(
                                                width: 320,
                                                child: PhysicalModel(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  elevation: 4,
                                                  child: TextFormField(
                                                    minLines: 1,
                                                    maxLines: 3,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                    validator:
                                                        BValidator.validate,
                                                    controller:
                                                        sectionNumberController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            hintSectionNumber,
                                                        hintStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .labelMedium,
                                                        border:
                                                            const OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox()
                                  ])),
                          const Gap(16),
                          (value.pdfUrl != null && pdfField == true)
                              ? Container(
                                  height: 80,
                                  width: 88,
                                  color: BColors.lightGrey,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                          child: Image.asset(BImage.imagePDF)),
                                      Positioned(
                                          top: -9,
                                          right: -9,
                                          child: IconButton(
                                              onPressed: pdfCancelButton,
                                              icon: const Icon(
                                                Icons.cancel,
                                                size: 24,
                                                color: Colors.red,
                                              ))),
                                    ],
                                  ),
                                )
                              : (value.pdfFile == null && pdfField == true)
                                  ? SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Flexible(
                                            child: Divider(
                                              thickness: 1,
                                              indent: 60,
                                              endIndent: 5,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text('PDF will be uploaded here',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall),
                                          const Flexible(
                                            child: Divider(
                                              thickness: 1,
                                              indent: 5,
                                              endIndent: 60,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : (value.pdfFile != null)
                                      ? const Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                          const Gap(20),
                          (pdfField == true)
                              ? SizedBox(
                                  height: 40,
                                  width: 268,
                                  child: OutlinedButton(
                                    onPressed: pdfTap,
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    child: Text('Upload PDF',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                  ),
                                )
                              : const SizedBox(),
                          const Gap(10),
                          SizedBox(
                            height: 40,
                            width: 268,
                            child: ElevatedButton(
                              onPressed: () async {
                                final res = await buttonTap.call();
                                if (res) {
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: (value.fetchloading)
                                  ? Text(buttonText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: Colors.white))
                                  : const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          const Gap(8),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: -9,
                      right: -9,
                      child: IconButton(
                          onPressed: () {
                            cancelTap.call();
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel_outlined)))
                ],
              ),
            );
          });
        });
  }
}
