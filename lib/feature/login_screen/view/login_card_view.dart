import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/core/constants/logo_path.dart';
import 'package:school_project_ibdb/feature/forget-pass-view/forget_pass_view.dart';

import '../../../core/custom/circle_color_widget.dart';
import '../../sign_up/sign_up_view.dart';
import 'login_card_view_cubit.dart';

class LoginCardView extends StatefulWidget {
  const LoginCardView({Key? key}) : super(key: key);

  @override
  State<LoginCardView> createState() => _LoginCardViewState();
}

class _LoginCardViewState extends State<LoginCardView> with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
              child: context.read<LoginCardCubit>().changeBackground(context)),
          dataStruct(context),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: context.paddingNormal,
              child: Switch.adaptive(
                  value: context.read<LoginCardCubit>().isLibrary,
                  onChanged: (v) {
                    context.read<LoginCardCubit>().changeApperance(v);
                  }),
            ),
          ),
        ]),
      ),
    );
  }

  Widget dataStruct(BuildContext context) {
    double _outerBlur = 0;
    double _innerBlur = 0;
    if (context.read<LoginCardCubit>().isLibrary) {
      _outerBlur = 2;
      _innerBlur = 15;
    } else {
      _outerBlur = 10;
      _innerBlur = 0;
    }
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: _outerBlur, sigmaY: _outerBlur),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: context.horizontalPaddingMedium,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: _innerBlur, sigmaY: _innerBlur),
                child: Card(
                  elevation: 0,
                  color: context.read<LoginCardCubit>().isLibrary ? Colors.transparent : Colors.green[100],
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.dynamicWidth(0.05))),
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
                          Text("Log in",
                              style: Theme.of(context).textTheme.headline2?.copyWith(
                                  color: context.read<LoginCardCubit>().isLibrary
                                      ? Colors.white
                                      : Colors.black)),
                          Text("Welcome",
                              style: Theme.of(context).textTheme.headline5?.copyWith(
                                  color: context.read<LoginCardCubit>().isLibrary
                                      ? Colors.white
                                      : Colors.black)),
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
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70),
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
