import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/feature/forget-pass-view/forget_pass_view.dart';

import '../../../core/custom/circle_color_widget.dart';
import '../../sign_up/sign_up_view.dart';
import 'login_card_view_cubit.dart';

class LoginCardView extends StatelessWidget {
  const LoginCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCardCubit>(
      create: (context) => LoginCardCubit(),
      child: BlocConsumer<LoginCardCubit, LoginCardState>(
          builder: (context, state) {
            if (state is LoadingFirebaseState) {
              return progressBuilder();
            } else {
              return logInStruct(context);
            }
          },
          listener: (context, state) {}),
    );
  }

  Scaffold logInStruct(BuildContext context) {
    return Scaffold(
      body: ClipRRect(
        child: Stack(fit: StackFit.expand, children: [
          Positioned(
              child: const CircleShape(
                shapeColor: Colors.teal,
              ),
              bottom: context.dynamicHeight(0.69)),
          Positioned(
            bottom: context.dynamicHeight(0.15),
            child: const CircleShape(shapeColor: Colors.green),
          ),
          Positioned(child: const CircleShape(shapeColor: Colors.blue), left: context.dynamicWidth(0.5)),
          dataStruct(context),
        ]),
      ),
    );
  }

  Widget dataStruct(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: context.horizontalPaddingMedium,
            child: Card(
              color: Colors.green[100],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.dynamicWidth(0.05))),
              child: Padding(
                padding: context.horizontalPaddingNormal,
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: context.dynamicHeight(0.02),
                      ),
                      Text("Log in", style: Theme.of(context).textTheme.headline3),
                      Text("Welcome", style: Theme.of(context).textTheme.headline5),
                      SizedBox(
                        height: context.dynamicHeight(0.04),
                      ),
                      mailTextField(context),
                      SizedBox(
                        height: context.dynamicHeight(0.02),
                      ),
                      passTextField(context),
                      forgetPassBTN(context),
                      logInBTN(context),
                      const Divider(),
                      signUpBTN(context),
                      SizedBox(
                        height: context.dynamicHeight(0.02),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row signUpBTN(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen[200]!),
              shape: MaterialStateProperty.all(const StadiumBorder()),
            ),
            onPressed: () {
              context.read<LoginCardCubit>().emailController.clear();
              context.read<LoginCardCubit>().passwordController.clear();
              context.read<LoginCardCubit>().goToPage(context, SignUpView());
            },
            child: const Text("Sign Up"),
          ),
        ),
      ],
    );
  }

  TextFormField mailTextField(BuildContext context) {
    return TextFormField(
      controller: context.read<LoginCardCubit>().emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail_outline),
          labelText: "e-mail",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(context.dynamicWidth(0.05)))),
    );
  }

  TextFormField passTextField(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (v) {
        context.read<LoginCardCubit>().sendRequest(context.read<LoginCardCubit>().emailController.text,
            context.read<LoginCardCubit>().passwordController.text, context);
      },
      controller: context.read<LoginCardCubit>().passwordController,
      obscureText: true,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline),
          labelText: "password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(context.dynamicWidth(0.05)))),
    );
  }

  Row forgetPassBTN(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPassView())),
          child: Text(
            "Forget password",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }

  Row logInBTN(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(const StadiumBorder()),
            ),
            onPressed: () {
              context.read<LoginCardCubit>().sendRequest(context.read<LoginCardCubit>().emailController.text,
                  context.read<LoginCardCubit>().passwordController.text, context);
            },
            child: Text(
              "Log in",
              style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Scaffold progressBuilder() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
