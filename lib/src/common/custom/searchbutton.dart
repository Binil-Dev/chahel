import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final TextEditingController controller;
  const SearchButton(
      {super.key, required this.onPressed, required this.controller});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                style: Theme.of(context).textTheme.bodyMedium,
                onFieldSubmitted: (val) {
                  onPressed.call();
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    hintText: 'Search Here',
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                        borderSide: BorderSide.none)),
              ),
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12)))),
                  onPressed: () {
                    onPressed.call();
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            )
          ],
        ));
  }
}
