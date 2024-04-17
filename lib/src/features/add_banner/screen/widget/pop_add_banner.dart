import 'package:chahel_web_1/src/features/add_banner/controller/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PopUpAddbanner {
  PopUpAddbanner._();
  static final PopUpAddbanner _instance = PopUpAddbanner._();
  static PopUpAddbanner get instance => _instance;
  void showAddNewBannerDialog({
    required BuildContext context,
    String? dataTypeSize,
    required String buttonText,
    required Future<bool> Function() buttonTap,
    required VoidCallback addTap,
  }) {
    showDialog(
        context: context,
        builder: (
          context,
        ) {
          return Consumer<BannerController>(
            builder: (context, value, _) => AlertDialog(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              title: Container(
                width: MediaQuery.of(context).size.width / 4.2,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        (value.imageBytes == null && value.imageUrl == null)
                            ? Center(
                                child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                                child: Container(
                                  height: 172,
                                  width: 298,
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
                                ),
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
                                        width: 298,
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
                                        width: 298,
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
                            Text(
                                (value.imageBytes != null)
                                    ? 'Tap on image to select another image'
                                    : 'Add banner',
                                style: Theme.of(context).textTheme.labelLarge),
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
                        SizedBox(
                          height: 40,
                          width: 268,
                          child: ElevatedButton(
                            onPressed: () async {
                            final res =  await buttonTap.call();
                              if (res) {
                                  Navigator.pop(context);
                                }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: value.fetchloading
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
                    Positioned(
                        top: -9,
                        right: -9,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              value.clearImage();
                            },
                            icon: const Icon(Icons.cancel_outlined)))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
