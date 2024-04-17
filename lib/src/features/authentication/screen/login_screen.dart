import 'package:chahel_web_1/src/app_details/app_details.dart';
import 'package:chahel_web_1/src/common/others/toast.dart';
import 'package:chahel_web_1/src/features/authentication/provider/auth_provider.dart';
import 'package:chahel_web_1/src/features/sidebar/screen/sidebar.dart';
import 'package:chahel_web_1/src/utils/constants/colors/colors.dart';
import 'package:chahel_web_1/src/utils/constants/image/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  bool authLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: formkey,
          child: SizedBox(
            width: 360,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  BImage.logo,
                  height: 200,
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 360,
                  child: TextFormField(
                    controller: usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter an email.";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(color: BColors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: BColors.buttonLightColor!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: BColors.buttonLightColor!),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: BColors.buttonLightColor!),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      hintText: "Enter an email here",
                      hintStyle: const TextStyle(color: BColors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 360,
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a password.";
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(color: BColors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: BColors.buttonLightColor!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: BColors.buttonLightColor!),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:
                            BorderSide(color: BColors.buttonLightColor!),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      hintText: "Enter a password here",
                      hintStyle: const TextStyle(color: BColors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          _showPasswordRestDilogue(authProvider);
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: BColors.grey),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 260,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      final isValid = formkey.currentState!.validate();

                      if (isValid) {
                        setState(() {
                          authLoading = true;
                        });

                        authProvider
                            .signInWithEmailAndPassword(
                                usernameController.text.trim(),
                                passwordController.text.trim(),
                                context)
                            .then((user) {
                          if (user != null) {
                            setState(() {
                              authLoading = false;
                            });
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SideMenuScreen()),
                                (route) => false);
                          } else {
                            setState(() {
                              authLoading = false;
                            });
                          }
                        });
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          BColors.buttonDarkColor!),
                    ),
                    child: authLoading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showPasswordRestDilogue(AuthProvider authProvider) async {
    // ignore: unused_local_variable
    bool _loading = false;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Center(child: Text('Reset Password')),
            content: SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      resquestEmailContent,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      color: BColors.buttonLightColor!,
                      onPressed: () async {
                        setState(() {
                          _loading = true;
                        });
                        await authProvider
                            .sendPasswordResetEmail(AppDetails.email)
                            .then((_) {
                          setState(() {
                            _loading = false;
                          });
                          toastSucess(
                              context, "Password reset link sent to email");
                          Navigator.of(context).pop();
                        });
                      },
                      child: const Text(
                        "Send Reset Password Link",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

String resquestEmailContent =
    "A Password reset request was sent to email address (${AppDetails.email}) . Please click the link in that massage to reset your password.\n\nIf you do not recieve the password reset message within a few moments,Please check your spam folder or other filtering tools.";
