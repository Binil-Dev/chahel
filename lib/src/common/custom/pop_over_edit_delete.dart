import 'package:chahel_web_1/src/utils/constants/text/text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:popover/popover.dart';

//list of edit and delete of popover
class ListItems extends StatelessWidget {
  const ListItems(
      {super.key, required this.editButton, required this.deleteButton});
  final void Function() editButton;
  final void Function() deleteButton;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          InkWell(
            onTap: () {
              editButton.call();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: Text(BText.edit,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white))),
              ),
            ),
          ),
          const Gap(8),
          InkWell(
            onTap: () async {
              ///delete confirm alert box
              await showDialog(
                context: context,
                builder: (context) {
                  return SizedBox(
                    width: 260,
                    height: 300,
                    child: AlertDialog(
                      title: Text('Confirm to delete',
                          style: Theme.of(context).textTheme.bodyLarge),
                      content: Text('Are you sure you want to delete?',
                          style: Theme.of(context).textTheme.labelLarge),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No')),
                        ElevatedButton(
                          onPressed: () {
                            deleteButton.call();

                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: Text('Yes',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white)),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(16)),
                child: Center(
                    child: Text(BText.delete,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//pop three dot button for edit and delete
class PopOverEditDelete extends StatelessWidget {
  const PopOverEditDelete(
      {super.key,
      required this.editButton,
      required this.deleteButton,
      this.iconColor});
  final void Function() editButton;
  final void Function() deleteButton;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showPopover(
              context: context,
              bodyBuilder: (context) => ListItems(
                    editButton: () {
                      Navigator.pop(context);
                      editButton.call();
                    },
                    deleteButton: () {
                      Navigator.pop(context);
                      deleteButton.call();
                    },
                  ),
              direction: PopoverDirection.bottom,
              radius: 16,
              width: 216,
              height: 184,
              arrowHeight: 15,
              arrowWidth: 30,
              backgroundColor: const Color(0xFF11334E));
        },
        icon: Icon(
          Icons.more_vert,
          color: iconColor,
        ));
  }
}
