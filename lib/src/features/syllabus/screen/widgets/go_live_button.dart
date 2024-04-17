import 'dart:developer';

import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/zoom_live_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/screen/widgets/pop_over_live.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class GoLiveButton extends StatelessWidget {
  const GoLiveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomLiveController>(builder: (context, zoomliveLink, _) {
      return OutlinedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                title: ListZoomItems(
                  deleteButton: () async {
                    if (!zoomliveLink.formKey.currentState!.validate()) {
                      zoomliveLink.formKey.currentState!.validate();
                      return false;
                    }
                    log('Call of the live button');
                    await zoomliveLink.addLiveDetails(onSucess: (value) {
                      toastSucess(context, value);
                    }, onFailure: (value) {
                      toastError(context, value);
                    });
                    return true;
                  },
                  labelZoom: 'Enter live link',
                  cancelTap: () {},
                ),
              );
            },
          );
        },
        style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Row(
          children: [
            Icon(
              Icons.live_tv,
              color: Colors.red[800],
            ),
            const Gap(8),
            Text(
              'Go Live',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    });
  }
}
