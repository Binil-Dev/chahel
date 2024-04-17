import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:chahel_web_1/src/utils/constants/image/image.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SideMenuScreen extends StatelessWidget {
  const SideMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SideMenuController sideMenu = SideMenuController();
    return Scaffold(
      body: Consumer<NavigationController>(builder: (context, value, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              controller: sideMenu,
              style: SideMenuStyle(
                  itemOuterPadding:
                      const EdgeInsets.only(top: 4, bottom: 4, right: 8),
                  itemBorderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  displayMode: SideMenuDisplayMode.open,
                  hoverColor: Colors.blue[100],
                  selectedHoverColor: Colors.blue[100],
                  selectedColor: Colors.lightBlue[600],
                  selectedTitleTextStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                  decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3.0,
                          blurRadius: 3.0,
                          offset: const Offset(
                              0, 3.0), // Adjust for desired shadow position
                        )
                      ]),
                  backgroundColor: Colors.white60),
              title: Column(
                children: [
                  const Gap(20),
                  ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 160,
                        maxWidth: 160,
                      ),
                      ///////////////////////////////// logo is added here
                      child: SvgPicture.asset(
                        BImage.logo,
                      )),
                  const Gap(30),
                  const Divider(
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                  const Gap(30)
                ],
              ),
              footer: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    child: Text(
                      'Version 1.0.0',
                      style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                    ),
                  ),
                ),
              ),
              items: [
                SideMenuItem(
                  title: 'Users',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                    value.setPageIndex(index);
                  },
                ),
                SideMenuItem(
                  title: 'Syllabus',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                    value.setPageIndex(index);
                  },
                ),
                SideMenuItem(
                  title: 'Plans',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                    value.setPageIndex(index);
                  },
                ),
                SideMenuItem(
                  title: 'Add Banner',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                    value.setPageIndex(index);
                  },
                ),
                SideMenuItem(
                  title: 'Notification',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                    value.setPageIndex(index);
                  },
                ),
                SideMenuItem(
                  title: 'Payment gateway',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                    value.setPageIndex(index);
                  },
                ),
              ],
            ),
            Expanded(child: value.pages[value.pageIndex][value.subpageIndex]),
          ],
        );
      }),
    );
  }
}
