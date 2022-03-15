import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/custom/custom_btn.dart';
import '../../../core/custom/custom_sized_box.dart';
import '../../../core/enum/padding_values.dart';
import '../../search_view/search_view.dart';
import '../../sign_up/sign_up_view.dart';
import '../../../product/utils/validator/validator.dart';
import '../../../core/custom/input_dec_custom.dart';

import '../view_model/sign_in_screen_view_model.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);
  bool isChecked = false;
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInScreenCubit(
          emailController: emailController,
          focusEmail: focusEmail,
          focusPassword: focusPassword,
          formKey: formkey,
          passwordController: passwordController),
      child: BlocConsumer<SignInScreenCubit, SignInScreenState>(
        listener: (context, state) {
          if (state is SignInSucces) {}
        },
        builder: (context, state) {
          if (state is LoadingFirebaseState) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (state is LoadedFirebaseState) {
            return Scaffold(
              body: SingleChildScrollView(
                physics: (focusEmail.hasFocus || focusPassword.hasFocus)
                    ? const AlwaysScrollableScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: PaddingValues.min.rawValues(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          customSizedBox(context, 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/sign_in/IBDb-logos.jpeg",
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                          ),
                          customSizedBox(context, 2),
                          Form(
                            key: formkey,
                            child: Column(
                              children: [
                                mailTextField(),
                                customSizedBox(
                                    context, percentageConstants().small),
                                passwordTextfield(),
                              ],
                            ),
                          ),
                          forgetPassText(context),
                          signInBtn(
                              context), //await silindi belki lazım olabilir
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            context
                                .read<SignInScreenCubit>()
                                .goToPage(context, SignUpView());
                          },
                          child: Text(StringConstants().joinUs))
                    ],
                  ),
                ),
              ),
            );
          } else if (state is SignInSucces) {
            return SearchView();
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }

  Padding signInBtn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: percentageConstants().medium),
      child: CustomBtn(StringConstants().signIn, () async {
        context.read<SignInScreenCubit>().looseFocus();
        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Alanlar boş bırakılamaz")));
        } else {
          context.read<SignInScreenCubit>().sendRequest(
              emailController.text, passwordController.text, context);
        }
      }, context),
    );
  }

  Row forgetPassText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {}, child: Text(StringConstants().forgetPassword))
      ],
    );
  }

  TextFormField mailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      focusNode: focusEmail,
      validator: (v) => Validator().validateEmail(email: v),
      decoration: InputDecCustom(StringConstants().eMailHint),
    );
  }

  TextFormField passwordTextfield() {
    return TextFormField(
      controller: passwordController,
      focusNode: focusPassword,
      obscureText: true,
      validator: (v) => Validator().validatePassword(password: v),
      decoration: InputDecCustom(StringConstants().passwordHint),
    );
  }

  customSizedBox spacerWidget(BuildContext context) {
    return customSizedBox(context, percentageConstants().medium);
  }
}
