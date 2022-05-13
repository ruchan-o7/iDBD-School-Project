import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../neumorphic_container/custom_container.dart';
import '../utils/validator/validator.dart';
import '../../core/constants/border_radius.dart';
import '../../core/constants/logo_path.dart';
import '../base_model/book_response_mode.dart';

class HomeBookCard extends SizedBox {
  HomeBookCard({Key? key, required this.model, required this.context})
      : super(
            key: key,
            child: NeumCont(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: context.dynamicHeight(0.015)),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadiusConst.normal),
                    height: context.dynamicWidth(0.5),
                    child: Validator().validateString(model?.imageLinks?.thumbnail)
                        ? Container(
                            margin: context.paddingLow,
                            child: ClipRRect(
                              borderRadius: BorderRadiusConst.normal,
                              child: Image.network(
                                model?.imageLinks?.thumbnail ?? "",
                                fit: BoxFit.cover,
                                width: context.dynamicWidth(0.35),
                              ),
                            ),
                          )
                        : Image.asset(LogoPaths.dummyBook),
                  ),
                ],
              ),
            ));
  final VolumeInfo? model;
  final BuildContext context;
}

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, this.model, required this.context}) : super(key: key);
  final VolumeInfo? model;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusConst.veryLow),
      child: Validator().validateString(model?.imageLinks?.thumbnail)
          ? SizedBox(
              width: context.dynamicWidth(0.33),
              child: Padding(
                padding: context.paddingLow,
                child: ClipRRect(
                  borderRadius: BorderRadiusConst.veryLow,
                  child: Image.network(
                    model?.imageLinks?.thumbnail ?? "",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            )
          : SizedBox(
              width: context.dynamicWidth(0.33),
              child: Image.asset(
                LogoPaths.dummyBook,
              ),
            ),
    );
  }
}

class ListBookCard extends StatelessWidget {
  const ListBookCard({Key? key, required this.model, required this.context}) : super(key: key);
  final BuildContext context;
  final VolumeInfo? model;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(
            width: context.dynamicWidth(0.3),
            height: context.dynamicHeight(0.2),
            child: Validator().validateString(model?.imageLinks?.thumbnail)
                ? Padding(
                    padding: context.paddingLow,
                    child: ClipRRect(
                        borderRadius: BorderRadiusConst.veryLow,
                        child: Image.network(model?.imageLinks?.thumbnail ?? "", fit: BoxFit.cover)),
                  )
                : Image.asset(LogoPaths.dummyBook),
          ),
          SizedBox(
            width: context.dynamicWidth(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(model?.title ?? "null title",
                    style: Theme.of(context).textTheme.bodyLarge, overflow: TextOverflow.ellipsis),
                Text(model?.authors?.first ?? "null authors",
                    style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis),
                SizedBox(height: context.dynamicHeight(.01)),
                Text("  ${model?.description ?? "no description"}",
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4),
              ],
            ),
          )
        ],
      ),
    );
  }
}
