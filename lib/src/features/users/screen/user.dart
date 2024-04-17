import 'package:chahel_web_1/src/common/custom/searchbutton.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/users/controller/user_controller.dart';

import 'package:chahel_web_1/src/features/users/screen/widgets/pop_up_plan_user.dart';
import 'package:chahel_web_1/src/features/users/screen/widgets/user_list.dart';
import 'package:chahel_web_1/src/features/users/screen/widgets/user_popup.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final ScrollController _scrollcontroller = ScrollController();

  final searchController = TextEditingController();
  @override
  void initState() {
    final userprovider = Provider.of<UserController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await userprovider.fetchAllUsers(search: searchController.text);
      await userprovider.getStandardsList(
        onFailure: (value) {
          toastError(context, value);
        },
      );
    });

    _scrollcontroller.addListener(() {
      if (_scrollcontroller.position.atEdge &&
          _scrollcontroller.position.pixels != 0 &&
          userprovider.fetchloading == true) {
        userprovider.fetchAllUsers(
          search: searchController.text,
        );
        //fetch
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PopViewAccount popUp = PopViewAccount.instance;

    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 3,
        backgroundColor: Colors.grey[100],
        surfaceTintColor: Colors.white,
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.black,
        title: Text(
          'Users',
          style: Theme.of(context).textTheme.headlineSmall!,
        ),
      ),
      body: Consumer<UserController>(
        builder: (context, state, child) => CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 100,
              elevation: 2,
              forceElevated: true,
              pinned: true,
              shadowColor: Colors.grey[400],
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white70,
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 12, left: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Gap(24),
                      SizedBox(
                        height: 48,
                        width: 172,
                        child: ElevatedButton(
                          onPressed: () {
                            state.changeTabINdex(
                                index: 0, searchText: searchController.text);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (state.tabIndex == 0)
                                  ? const Color(0xFF11334E)
                                  : Colors.white.withOpacity(.9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          child: Text('All users',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: (state.tabIndex == 0)
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                        ),
                      ),
                      const Gap(24),
                      SizedBox(
                        height: 48,
                        width: 172,
                        child: ElevatedButton(
                          onPressed: () {
                            state.changeTabINdex(
                                index: 1, searchText: searchController.text);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (state.tabIndex == 1)
                                  ? const Color(0xFF11334E)
                                  : Colors.white.withOpacity(.9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          child: Text('Subscribed',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: (state.tabIndex == 1)
                                          ? Colors.white
                                          : Colors.black)),
                        ),
                      ),
                      const Gap(24),
                      SizedBox(
                        height: 48,
                        width: 172,
                        child: ElevatedButton(
                          onPressed: () {
                            state.changeTabINdex(
                                index: 2, searchText: searchController.text);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: (state.tabIndex == 2)
                                  ? const Color(0xFF11334E)
                                  : Colors.white.withOpacity(.9),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14))),
                          child: Text('Unsubscribed',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: (state.tabIndex == 2)
                                          ? Colors.white
                                          : Colors.black)),
                        ),
                      ),
                      const Gap(200),
                      SizedBox(
                          height: 40,
                          width: 280,
                          child: SearchButton(
                            controller: searchController,
                            onPressed: () {
                              state.searchUsers(searchController.text.trim());
                            },
                          )),
                      const Gap(8),
                    ],
                  ),
                ),
              ),
            ),
            if (state.fetchloading == false && state.allUser.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black26,
                  ),
                ),
              )
            else if (state.allUser.isEmpty)
              const SliverFillRemaining(
                child: Center(child: Text('No Users Found!')),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.only(left: 16),
                sliver: SliverFillRemaining(
                  fillOverscroll: true,
                  child: CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: 1128,
                            child: CustomScrollView(
                                controller: _scrollcontroller,
                                slivers: [
                                  SliverList.builder(
                                      itemCount: state.allUser.length,
                                      itemBuilder: (context, index) {
                                        return UserListDetails(
                                          userId: state.allUser[index].id ?? '',
                                          onPlanTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return PopPlanUserScreen(
                                                  cancelButton: () {
                                                    state.clearPlanDetails();
                                                  },
                                                  buttonTap: () async {
                                                    bool exist = state
                                                        .allUser[index]
                                                        .purchaseDetails!
                                                        .any((element) =>
                                                            element.stdId ==
                                                                state
                                                                    .dropStandardId &&
                                                            element.medId ==
                                                                state
                                                                    .dropMediumId);

                                                    if (exist) {
                                                      toastError(context,
                                                          "That plan already exist in user account, try another plan.");
                                                      state.clearPlanDetails();
                                                      return false;
                                                    }
                                                    await state.updateUserPlan(
                                                        id: state
                                                            .allUser[index].id,
                                                        onSucess: () async {
                                                          toastSucess(context,
                                                              'Sucessfully updated user plan');
                                                          await state.fetchAllUsers(
                                                              search:
                                                                  searchController
                                                                      .text);
                                                        },
                                                        onFailure: () {
                                                          toastError(context,
                                                              "Couldn't able to update the plan");
                                                        });

                                                    return true;
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          isUserActive: state.allUser[index]
                                                  .isUserActive ??
                                              false,
                                          name: state.allUser[index].name ??
                                              'User name',
                                          planStatus: state
                                                  .allUser[index]
                                                  .purchaseDetails
                                                  ?.isNotEmpty ??
                                              true,
                                          phoneNumber: state
                                                  .allUser[index].phoneNumber ??
                                              'Phone Number',
                                          id: (index + 1).toString(),
                                          imageUrl: state.allUser[index].image,
                                          viewAccountOnTap: () {
                                            popUp.showUserDetailsDialog(
                                              context: context,
                                              name: state.allUser[index].name ??
                                                  'User name',
                                              age: state.allUser[index].age ??
                                                  'no age',
                                              dob: state.allUser[index].dob ??
                                                  '0/0/0000',
                                              email:
                                                  state.allUser[index].email ??
                                                      'user@gmail.com',
                                              school: state.allUser[index]
                                                      .schoolName ??
                                                  'school name is not updated',
                                              guardian: state.allUser[index]
                                                      .guardianName ??
                                                  'gaurdian name is not updated',
                                              planDetails: state
                                                      .allUser[index]
                                                      .purchaseDetails
                                                      ?.length ??
                                                  0,
                                              planStatus: state
                                                      .allUser[index]
                                                      .purchaseDetails
                                                      ?.isNotEmpty ??
                                                  true,
                                              planDetialsList: state
                                                      .allUser[index]
                                                      .purchaseDetails ??
                                                  [],
                                              imageUrl:
                                                  state.allUser[index].image,
                                            );
                                          },
                                        );
                                      }),
                                ]),
                          ),
                        ),
                      ]),
                ),
              ),
            const SliverToBoxAdapter(
              child: Gap(40),
            ),
            SliverToBoxAdapter(
                child: (state.fetchloading == false && state.allUser.isNotEmpty)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black12,
                        ),
                      )
                    : null),
          ],
        ),
      ),
    );
  }
}
