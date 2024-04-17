import 'package:chahel_web_1/src/common/custom/validator.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/zoom_live_controller.dart';
import 'package:chahel_web_1/src/utils/constants/colors/colors.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class ListZoomItems extends StatelessWidget {
  const ListZoomItems(
      {super.key,
      required this.deleteButton,
      required this.labelZoom,
      required this.cancelTap});
  final String labelZoom;
  final Future<bool> Function() deleteButton;
  final VoidCallback cancelTap;
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomLiveController>(builder: (context, liveController, _) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 4),
              child: Form(
                key: liveController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(24),
                    Text('Live  link:',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const Gap(8),
                    Row(
                      //  mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 400,
                          child: PhysicalModel(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                            elevation: 4,
                            child: TextFormField(
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: BColors.buttonLightColor),
                              minLines: 2,
                              maxLines: 2,
                              validator: BValidator.validate,
                              controller: liveController.controllerLiveUrl,
                              decoration: InputDecoration(
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  hintText: labelZoom,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: 72,
                            width: 120,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: BColors.green,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8)))),
                                onPressed: () async {
                                  final res = await deleteButton.call();
                                  if (res) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  'Save',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(color: BColors.textWhite),
                                )))
                      ],
                    ),
                    const Gap(16),
                    Center(
                      child: LiteRollingSwitch(
                        value: liveController.isliveNow ?? false,
                        width: 120,
                        textOn: 'GoLive',
                        textOff: 'Inactive',
                        colorOn: Colors.red[900]!,
                        colorOff: Colors.grey[700]!,
                        iconOn: Icons.live_tv_outlined,
                        iconOff: Icons.tv_off_rounded,
                        animationDuration: const Duration(milliseconds: 300),
                        onChanged: (bool state) {
                          liveController.isliveNow = state;
                        },
                        onDoubleTap: () {},
                        onSwipe: () {},
                        onTap: () {},
                      ),
                    ),
                    const Gap(16),
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
  }
}
