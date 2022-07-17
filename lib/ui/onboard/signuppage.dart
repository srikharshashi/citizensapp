import 'package:citizenapp2/cubits/signup_cubit/signup_cubit.dart';
import 'package:citizenapp2/cubits/theme_cubit/theme_cubit.dart';
import 'package:citizenapp2/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernamekey = GlobalKey<FormState>();
  final passwordkey = GlobalKey<FormState>();
  final ETHKey = GlobalKey<FormState>();
  final pwdckey = GlobalKey<FormState>();

  final usernamecont = TextEditingController();
  final pwdcontroller = TextEditingController();
  final pwdccontroller = TextEditingController();
  final ETHController = TextEditingController();
  final txtcontroller = TextEditingController();

  showtoast(String message) {
    Fluttertoast.showToast(
      msg: message, // message
      toastLength: Toast.LENGTH_SHORT, // length
      gravity: ToastGravity.BOTTOM, // location
      timeInSecForIosWeb: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarr(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context).walletAddress),
                    TextFormField(
                      controller: ETHController,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter some text';
                        return null;
                      },
                    ),
                  ],
                )),
            Form(
              key: usernamekey,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context).anonymousUserName),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter some text';
                          else if (value.length < 6)
                            return "Enter a longer username";
                          return null;
                        },
                        controller: usernamecont,
                      ),
                    ],
                  )),
            ),
            Form(
              key: passwordkey,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context).password),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter some text';
                          else if (value.length < 6)
                            return "Enter a longer password";
                          return null;
                        },
                        controller: pwdcontroller,
                      ),
                    ],
                  )),
            ),
            Form(
              key: pwdckey,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context).confirmPassword),
                      TextFormField(
                        obscureText: true,
                        controller: pwdccontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter some text';
                          else if (value.length < 6)
                            return "Enter a longer password";
                          else if (pwdccontroller.value.text !=
                              pwdcontroller.value.text)
                            return "Passwords dont match";
                          return null;
                        },
                      ),
                    ],
                  )),
            ),
            Container(
              height: 30,
            ),
            BlocConsumer<SignupCubit, SignupState>(
              listener: ((context, state) {
                if (state is SignUpSucess)
                  showtoast("Signup success");
                else if (state is UserExists)
                  showtoast("User already exists");
                else if (state is SignUpFail) showtoast("signup had failed");
              }),
              builder: (context, state) {
                if (state is SignupInitial) {
                  return Container(
                    child: ElevatedButton(
                        onPressed: () {
                          if (usernamekey.currentState!.validate()) {
                            if (passwordkey.currentState!.validate()) {
                              if (pwdckey.currentState!.validate()) {
                                context.read<SignupCubit>().signup(
                                    usernamecont.text,
                                    pwdccontroller.text,
                                    ETHController.text);
                              }
                            }
                          }
                        },
                        child: Text(AppLocalizations.of(context).signUp)),
                  );
                } else if (state is SignUpLoad) {
                  return SpinKitWave(
                    color: context.read<ThemeCubit>().gettheme() == "Light"
                        ? Colors.black
                        : Colors.teal,
                    size: 50.0,
                  );
                } else {
                  return ElevatedButton(
                      onPressed: () {
                        context.read<SignupCubit>().reload();
                      },
                      child: Text(AppLocalizations.of(context).retry));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
