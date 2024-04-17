import 'package:chahel_web_1/src/common/custom/appbar.dart';
import 'package:chahel_web_1/src/common/custom/textstar.dart';
import 'package:chahel_web_1/src/common/custom/validator.dart';
import 'package:chahel_web_1/src/common/others/notification.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/notification/controller/notification_controller.dart';
import 'package:chahel_web_1/src/utils/constants/colors/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final notificationProvider = Provider.of<NotificationController>(context);
    return CustomScrollView(
      slivers: [
        const CustomAppBar(
          title: 'Notification',
        ),
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Gap(64),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(80),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextStarField(
                              text: 'image',
                            ),
                            const Gap(92),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 42,
                                  width: 200,
                                  child: OutlinedButton(
                                      onPressed: () {
                                        notificationProvider.getImage(
                                            onSucess: (value) {},
                                            onFailure: (value) {});
                                      },
                                      style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      child: (notificationProvider.imageBytes ==
                                              null)
                                          ? Text(
                                              'Choose photo',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            )
                                          : Text(
                                              'Choose another photo',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            )),
                                ),
                                const Gap(20),
                                (notificationProvider.imageBytes == null)
                                    ? SizedBox(
                                        height: 124,
                                        width: 200,
                                        child: DottedBorder(
                                            borderType: BorderType.RRect,
                                            color: BColors.grey,
                                            strokeWidth: 1,
                                            dashPattern: const [6, 3],
                                            radius: const Radius.circular(8),
                                            child: const Center(
                                                child: Icon(
                                              Icons.add_photo_alternate,
                                              size: 30,
                                              color: BColors.grey,
                                            ))),
                                      )
                                    : SizedBox(
                                        height: 124,
                                        width: 200,
                                        child: DottedBorder(
                                            color: Colors.grey,
                                            borderType: BorderType.RRect,
                                            strokeWidth: 1,
                                            dashPattern: const [6, 3],
                                            radius: const Radius.circular(8),
                                            child: Image.memory(
                                              notificationProvider.imageBytes!,
                                              fit: BoxFit.fill,
                                            )),
                                      )
                              ],
                            )
                          ],
                        ),
                        const Gap(32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextStarField(text: 'Caption'),
                            const Gap(80),
                            SizedBox(
                              width: 475,
                              child: TextFormField(
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.labelLarge,
                                  controller:
                                      notificationProvider.titleTextController,
                                  validator: BValidator.validate,
                                  decoration: InputDecoration(
                                      labelText: 'Create a title',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)))),
                            )
                          ],
                        ),
                        const Gap(60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextStarField(text: 'Description'),
                            const Gap(56),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 808,
                                    child: TextFormField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        maxLines: 5,
                                        controller: notificationProvider
                                            .contentTextController,
                                        validator: BValidator.validate,
                                        decoration: InputDecoration(
                                          alignLabelWithHint: true,
                                          labelText:
                                              'Description about notification(Maximum 50 words for better experience)',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        )),
                                  ),
                                  const Gap(24),
                                  SizedBox(
                                    height: 40,
                                    width: 184,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (!formKey.currentState!.validate()) {
                                          formKey.currentState!.validate();
                                          return;
                                        }

                                        notificationProvider.fetchloading =
                                            false;

                                        if (notificationProvider.imageBytes !=
                                            null) {
                                          await notificationProvider
                                              .saveMainImage();
                                        }
                                        await sendFcmMessage(
                                          body: notificationProvider
                                              .contentTextController.text,
                                          image: notificationProvider.imageUrl,
                                          title: notificationProvider
                                              .titleTextController.text,
                                        );
                                        await notificationProvider
                                            .addNotification(onSucess: (value) {
                                          notificationProvider
                                              .clearAllNotificationFields();
                                          toastSucess(context, value);
                                        }, onFailure: () {
                                          toastError(context,
                                              "couldn't able to save notification");
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              BColors.buttonDarkColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      child: notificationProvider.fetchloading
                                          ? Text('Send',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors.white))
                                          : const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 4,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                    ),
                                  )
                                ])
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
