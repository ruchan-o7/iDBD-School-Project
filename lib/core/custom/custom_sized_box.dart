import 'package:flutter/cupertino.dart';

class customSizedBox extends SizedBox {
  customSizedBox(this.context, this.percentOf, {Key? key})
      : super(
            key: key,
            height: MediaQuery.of(context).size.height * (percentOf / 100));
  final BuildContext context;
  final double percentOf;
}
