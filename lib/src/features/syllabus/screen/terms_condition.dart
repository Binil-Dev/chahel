import 'package:chahel_web_1/src/common/custom/validator.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class TermsNConditionScreen extends StatefulWidget {
  const TermsNConditionScreen({
    super.key,
  });

  @override
  State<TermsNConditionScreen> createState() => _TermsNConditionScreenState();
}

class _TermsNConditionScreenState extends State<TermsNConditionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   final syllabusProvider =
    //       Provider.of<SyllabusController>(context, listen: false);
    //   sectionId = syllabusProvider.selectedSection?.id;
    //   await syllabusProvider.getTermsNCondition(
    //       onFailure: (value) {
    //         toastError(context, value);
    //       },
    //       sectionId: sectionId ?? '');
    //   // log(widget.);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SyllabusController, NavigationController>(
        builder: (context, syllabusProvider, navProvider, _) {
      syllabusProvider.setGetTermsData(syllabusProvider.selectedSectionTerms!);
      return Scaffold(
          backgroundColor: Colors.white60,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navProvider.setSubPageIndex(4);
                navProvider.pages[navProvider.pageIndex]
                    [navProvider.subpageIndex];
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            toolbarHeight: 90,
            elevation: 2,
            backgroundColor: Colors.grey[100],
            surfaceTintColor: Colors.white,
            clipBehavior: Clip.antiAlias,
            shadowColor: Colors.black,
            title: Text(
              'Terms & Conditions',
              style: Theme.of(context).textTheme.headlineSmall!,
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16, vertical: 24),
              child: Consumer<SyllabusController>(builder: (context, value, _) {
                return SizedBox(
                  width: 720,
                  child: Stack(
                    children: [
                      Form(
                        key: _formKey,
                        child: Card(
                          surfaceTintColor: Colors.white,
                          color: const Color.fromARGB(255, 198, 204, 210),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 32, bottom: 32, left: 32, right: 40),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Topics',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      width: 336,
                                      child: PhysicalModel(
                                        clipBehavior: Clip.antiAlias,
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        elevation: 4,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            controller:
                                                value.topicTextController,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            readOnly: value.readOnly,
                                            maxLines: 3,
                                            minLines: 1,
                                            validator: BValidator.validate,
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Enter the topics in the section',
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                border:
                                                    const OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total mark',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      width: 336,
                                      child: PhysicalModel(
                                        clipBehavior: Clip.antiAlias,
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        elevation: 4,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            readOnly: value.readOnly,
                                            controller:
                                                value.totalMarkTextController,
                                            maxLines: 2,
                                            minLines: 1,
                                            validator: BValidator.validate,
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Enter the total mark',
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                border:
                                                    const OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total minutes',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      width: 336,
                                      child: PhysicalModel(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        elevation: 4,
                                        child: DropdownButtonFormField(
                                            validator: BValidator.validate,
                                            value: value.dropTimeText,
                                            alignment: Alignment.center,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide:
                                                        BorderSide.none)),
                                            hint: Text(
                                              '-- Select total time --',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                            items: value.totalTime.values
                                                .map((option) {
                                              return DropdownMenuItem(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  value: option,
                                                  child: Text(option,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge));
                                            }).toList(),
                                            onChanged: (option) {
                                              value.dropTimeText = option!;
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total questions',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      width: 336,
                                      child: PhysicalModel(
                                        clipBehavior: Clip.antiAlias,
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        elevation: 4,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            readOnly: value.readOnly,
                                            controller: value
                                                .totalquestionTextController,
                                            maxLines: 2,
                                            minLines: 1,
                                            validator: BValidator.validate,
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Enter the nummber of questions',
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                border:
                                                    const OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Minimum score to pass',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      width: 336,
                                      child: PhysicalModel(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        elevation: 4,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                            readOnly: value.readOnly,
                                            controller:
                                                value.averageMarkTextController,
                                            maxLines: 2,
                                            minLines: 1,
                                            validator: BValidator.validate,
                                            decoration: InputDecoration(
                                                hintText:
                                                    'Enter the minimum mark to pass',
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                                border:
                                                    const OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(24),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    height: 40,
                                    width: 336,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.validate();
                                            return;
                                          }
                                          if (value.dropTimeText ==
                                              '--select a time--') {
                                            toastError(context,
                                                'Select a valid time.');
                                            return;
                                          }
                                          value.updateTermsNCondition(
                                              onSucess: () {
                                            toastSucess(context,
                                                'Saved terms and condition sucessfully');
                                          }, onFailure: (value) {
                                            toastError(context, value);
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.lightBlue,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        child: (value.fetchloading)
                                            ? Text('Save',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                        color: Colors.white))
                                            : const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(6.0),
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 3,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ));
    });
  }
}
