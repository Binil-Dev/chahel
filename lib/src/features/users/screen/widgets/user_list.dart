import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/users/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

class UserListDetails extends StatelessWidget {
  const UserListDetails({
    required this.name,
    required this.planStatus,
    required this.phoneNumber,
    required this.id,
    required this.viewAccountOnTap,
    required this.imageUrl,
    required this.onPlanTap,
    required this.isUserActive,
    required this.userId,
    super.key,
  });
  final String userId;
  final String name;
  final bool planStatus;
  final String phoneNumber;
  final String id;
  final VoidCallback viewAccountOnTap;
  final String? imageUrl;
  final VoidCallback onPlanTap;
  final bool isUserActive;

  //final ImageProvider profilePicture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Consumer<UserController>(builder: (context, userProvider, _) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                const BoxShadow(
                    color: Color(0x0000001A),
                    spreadRadius: 3.0,
                    blurRadius: 7.0,
                    offset: Offset(0, 1.975)),
                BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 0.0,
                    blurRadius: 7.0,
                    offset: const Offset(0, -1.975))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    (imageUrl != null)
                        ? CircleAvatar(
                            radius: 48,
                            backgroundImage: NetworkImage(imageUrl ?? ''),
                          )
                        : const CircleAvatar(
                            radius: 48,
                            backgroundImage:
                                AssetImage('assets/images/no-photos.png'),
                          ),
                    const Gap(8),
                    Text(
                      'User No: $id',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const Gap(88),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Name',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Gap(78),
                        Text(
                          ':',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Gap(16),
                        Text(
                          name,
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        Text(
                          'Plan Status',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Gap(41),
                        Text(
                          ':',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Gap(16),
                        Text(
                          (planStatus) ? 'Active' : 'Inactive',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: (planStatus == true)
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    const Gap(8),
                    Row(
                      children: [
                        Text(
                          'Phone Number',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Gap(16),
                        Text(
                          ':',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Gap(16),
                        Text(
                          phoneNumber,
                          style: Theme.of(context).textTheme.labelLarge,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )
                  ],
                ),
                const Gap(132),
                SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: onPlanTap,
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text('Select plan',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black54)),
                  ),
                ),
                const Gap(40),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: viewAccountOnTap,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF11334E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text('View Account',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white)),
                  ),
                ),
                const Gap(40),
                LiteRollingSwitch(
                  value: isUserActive,
                  width: 120,
                  textOn: 'Block',
                  textOff: 'Active',
                  colorOn: Colors.red[900]!,
                  colorOff: Colors.green[900]!,
                  iconOn: Icons.block_rounded,
                  iconOff: Icons.power_settings_new,
                  animationDuration: const Duration(milliseconds: 300),
                  onChanged: (bool state) {
                    ///here we are updating according to the toogle switch in the firebase
                    userProvider.isUserActive(state);
                    userProvider.updateUserActive(
                        id: userId,
                        onSucess: () {
                          toastSucess(context, 'Sucessfully updated user.');
                        },
                        onFailure: () {
                          toastError(
                              context, 'Something went wrong, try again');
                        });
                  },
                  onDoubleTap: () {},
                  onSwipe: () {},
                  onTap: () {},
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
