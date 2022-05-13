import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/border_radius.dart';
import '../../../core/constants/logo_path.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/custom/custom_btn.dart';
import '../../../core/custom/custom_sized_box.dart';
import '../../../core/custom/input_dec_custom.dart';
import '../../../core/enum/padding_values.dart';
import '../../../product/utils/validator/validator.dart';
import '../../search_view/search_view.dart';
import '../../sign_up/sign_up_view.dart';
import '../view_model/sign_in_screen_view_model.dart';

@Deprecated("This widget deprecated. Use insted of LoginCardView")
class SignInViewold extends StatelessWidget {
  SignInViewold({Key? key}) : super(key: key);
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
          if (state is SignInLoadingState) {
            const AlertDialog(
              title: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingFirebaseState) {
            return progressBuilder();
          } else if (state is LoadedFirebaseState) {
            return generalStrucyBuilder(context);
          } else if (state is SignInSucces) {
            return SearchView();
          } else {
            return const Scaffold();
          }
        },
      ),
    );
  }

  Scaffold generalStrucyBuilder(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: (focusEmail.hasFocus || focusPassword.hasFocus)
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: PaddingValues.min.rawValues(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [structBuilder(context), joinUsBuilder(context)],
          ),
        ),
      ),
    );
  }

  TextButton joinUsBuilder(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.read<SignInScreenCubit>().goToPage(context, SignUpView());
        },
        child: Text(StringConstants().joinUs));
  }

  Column structBuilder(BuildContext context) {
    return Column(
      children: [
        CustomSizedBox(context, 10),
        logoBuilder(context),
        CustomSizedBox(context, 2),
        formBuilder(context),
        forgetPassText(context),
        signInBtn(context), //await silindi belki lazım olabilir
      ],
    );
  }

  ClipRRect logoBuilder(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusConst.veryLow,
      child: Image.asset(
        LogoPaths.normal,
        height: MediaQuery.of(context).size.height * 0.3,
      ),
    );
  }

  Form formBuilder(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          mailTextField(),
          CustomSizedBox(context, PercentageConstants().small),
          passwordTextfield(),
        ],
      ),
    );
  }

  Scaffold progressBuilder() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Padding signInBtn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: PercentageConstants().medium),
      child: CustomBtn(StringConstants().signIn, () async {
        context.read<SignInScreenCubit>().looseFocus();
        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fields can not empty")));
        } else {
          context
              .read<SignInScreenCubit>()
              .sendRequest(emailController.text, passwordController.text, context);
        }
      }, context),
    );
  }

  Row forgetPassText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [TextButton(onPressed: () {}, child: Text(StringConstants().forgetPassword))],
    );
  }

  TextFormField mailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      focusNode: focusEmail,
      validator: (v) => Validator().validateEmail(email: v),
      decoration: InputDecCustom(StringConstants().eMailHint, isMail: true),
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

  CustomSizedBox spacerWidget(BuildContext context) {
    return CustomSizedBox(context, PercentageConstants().medium);
  }
}
