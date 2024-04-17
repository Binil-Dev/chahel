import 'package:chahel_web_1/src/common/custom/appbar.dart';
import 'package:chahel_web_1/src/common/custom/textstar.dart';
import 'package:chahel_web_1/src/common/custom/validator.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/payment_gateway/controller/payment_controller.dart';
import 'package:chahel_web_1/src/utils/constants/colors/colors.dart';
import 'package:chahel_web_1/src/utils/constants/text/text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PaymentController>(context, listen: false).getPaymentDetails(
        onSucess: (value) {},
        onFailure: (value) {
          toastError(context, value);
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentController>(builder: (context, paymentProvider, _) {
      return paymentProvider.fetchfullScreen
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black12,
              ),
            )
          : CustomScrollView(
              slivers: [
                const CustomAppBar(
                  title: BText.paymentTitle,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(12),
                  sliver: SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Gap(24),
                          Form(
                            key: paymentProvider.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(32),
                                Row(
                                  children: [
                                    const Gap(16),
                                    Text(
                                      BText.paymentHeading,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                                const Gap(60),
                                SizedBox(
                                  width: 640,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      const TextStarField(
                                          text: BText.paymentKey1),
                                      SizedBox(
                                        width: 380,
                                        child: TextFormField(
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                          textInputAction: TextInputAction.next,
                                          controller:
                                              paymentProvider.controllerSaltKey,
                                          validator: BValidator.validate,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 15,
                                                    top: 18,
                                                    bottom: 18),
                                            labelText: BText.paymentKey1TF,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Gap(32),
                                SizedBox(
                                  width: 640,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Gap(6),
                                      const TextStarField(
                                          text: BText.paymentKey2),
                                      SizedBox(
                                        width: 380,
                                        child: TextFormField(
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                          textInputAction: TextInputAction.next,
                                          controller: paymentProvider
                                              .controllerSaltIndex,
                                          validator: BValidator.validate,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 15,
                                                    top: 18,
                                                    bottom: 18),
                                            labelText: BText.paymentKey2TF,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Gap(32),
                                SizedBox(
                                  width: 640,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Gap(32),
                                      const TextStarField(
                                          text: BText.paymentKey3),
                                      SizedBox(
                                        width: 380,
                                        child: TextFormField(
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                          textInputAction: TextInputAction.next,
                                          controller: paymentProvider
                                              .controllerMerchantKey,
                                          validator: BValidator.validate,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 15,
                                                    top: 18,
                                                    bottom: 18),
                                            labelText: BText.paymentKey3TF,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Gap(32),
                                SizedBox(
                                  width: 640,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 180,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  BColors.buttonDarkColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8))),
                                          onPressed: () {
                                            if (!paymentProvider
                                                .formKey.currentState!
                                                .validate()) {
                                              paymentProvider
                                                  .formKey.currentState!
                                                  .validate();
                                              return;
                                            }

                                            paymentProvider.addPaymentDetails(
                                                onSucess: (value) {
                                              toastSucess(context, value);
                                            }, onFailure: (value) {
                                              toastError(context, value);
                                            });
                                          },
                                          child: (paymentProvider.fetchloading)
                                              ? Text(
                                                  BText.save,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge!
                                                      .copyWith(
                                                          color: BColors
                                                              .textWhite),
                                                )
                                              : const Center(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 4,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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
    });
  }
}
