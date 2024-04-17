import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void toastError(BuildContext context, String text) {
  toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.flatColored,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(text),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    icon: const Icon(Icons.dangerous_outlined),
    primaryColor: Colors.white,
    backgroundColor: Colors.red[600],
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: false,
    closeButtonShowType: CloseButtonShowType.none,
    closeOnClick: false,
    pauseOnHover: false,
    dragToClose: false,
    applyBlurEffect: false,
  );
}

void toastSucess(BuildContext context, String text) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flatColored,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(text),
    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    icon: const Icon(Icons.check_circle_outline_rounded),
    primaryColor: Colors.white,
    backgroundColor: Colors.green[600],
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: false,
    closeButtonShowType: CloseButtonShowType.none,
    closeOnClick: false,
    pauseOnHover: false,
    dragToClose: false,
    applyBlurEffect: false,
  );
}
