import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/product/utils/validator/validator.dart';
import '../../core/constants/border_radius.dart';
import '../../core/constants/logo_path.dart';
import '../base_model/book_response_mode.dart';

class HomeBookCard extends SizedBox {
  HomeBookCard({Key? key, required this.model, required this.context})
      : super(
            key: key,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: context.dynamicHeight(0.015)),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadiusConst.normal),
                  height: context.dynamicHeight(0.25),
                  child: Validator().validateString(model?.imageLinks?.thumbnail)
                      ? Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadiusConst.normal,
                          ),
                          child: Container(
                            margin: context.paddingLow,
                            child: ClipRRect(
                              borderRadius: BorderRadiusConst.normal,
                              child: Image.network(
                                model?.imageLinks?.thumbnail ?? "",
                                fit: BoxFit.cover,
                                width: context.dynamicWidth(0.35),
                              ),
                            ),
                          ),
                        )
                      : Image.asset(LogoPaths.dummyBook),
                ),
              ],
            ));
  final VolumeInfo? model;
  final BuildContext context;
}
