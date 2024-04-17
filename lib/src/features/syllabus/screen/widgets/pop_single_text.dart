import 'package:chahel_web_1/src/common/custom/validator.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:chahel_web_1/src/utils/constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PopUpSingleTextDialog {
  PopUpSingleTextDialog._();
  static final PopUpSingleTextDialog _instance = PopUpSingleTextDialog._();
  static PopUpSingleTextDialog get instance => _instance;

  void showSingleTextAddDialog({
    required double addButtonImageWidth,
    required BuildContext context,
    required String dataType,
    String? dataTypeSize,
    required String nameTitle,
    required String labelTitle,
    required TextEditingController titleController,
    required String buttonText,
    required Future<bool> Function() buttonTap,
    required VoidCallback addTap,
    required VoidCallback cancelButton,
    required Key formKeyValue,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return Consumer<SyllabusController>(builder: (context, value, _) {
            return AlertDialog(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: Container(
                width: MediaQuery.of(context).size.width / 4.2,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          (value.imageBytes == null && value.imageUrl == null)
                              ? Center(
                                  child: Container(
                                  height: 172,
                                  width: addButtonImageWidth,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.black87),
                                  child: IconButton(
                                      onPressed: addTap,
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: Colors.white,
                                        size: 72,
                                      )),
                                ))
                              : (value.imageBytes != null)
                                  ? GestureDetector(
                                      onTap: addTap,
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 16),
                                        child: Container(
                                          height: 172,
                                          width: addButtonImageWidth,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                  image: MemoryImage(
                                                      value.imageBytes!))),
                                        ),
                                      )),
                                    )
                                  : GestureDetector(
                                      onTap: addTap,
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 16),
                                        child: Container(
                                          height: 172,
                                          width: addButtonImageWidth,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      value.imageUrl!))),
                                        ),
                                      )),
                                    ),
                          const Gap(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(dataType,
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                              const Gap(8),
                              (dataTypeSize == null)
                                  ? const Text('')
                                  : Text(dataTypeSize,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium),
                            ],
                          ),
                          const Gap(16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nameTitle,
                                  style: Theme.of(context).textTheme.bodyLarge),
                              const Gap(4),
                              SizedBox(
                                width: 336,
                                child: PhysicalModel(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  elevation: 4,
                                  child: Form(
                                    key: formKeyValue,
                                    child: TextFormField(
                                      maxLines: 2,
                                      minLines: 1,
                                      validator: BValidator.validate,
                                      controller: titleController,
                                      decoration: InputDecoration(
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          hintText: labelTitle,
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide.none)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
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
                                  backgroundColor: BColors.buttonLightColor,
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
                                        padding: EdgeInsets.all(4.0),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 4,
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
                    Positioned(
                        top: -9,
                        right: -9,
                        child: IconButton(
                            onPressed: () {
                              cancelButton.call();
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.cancel_outlined)))
                  ],
                ),
              ),
            );
          });
        });
  }
}
