import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../../core/constants/border_radius.dart';
import '../../core/constants/logo_path.dart';
import '../base_model/book_response_mode.dart';

class HomeBookCard extends SizedBox {
  HomeBookCard({Key? key, required this.model, required this.context})
      : super(
            key: key,
            child: SizedBox(
              height: context.dynamicHeight(0.3),
              width: context.dynamicWidth(0.4),
              child: Padding(
                padding: context.paddingLow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: context.dynamicHeight(0.015)),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), borderRadius: BorderRadiusConst.normal),
                      height: context.dynamicHeight(0.25),
                      child: ClipRRect(
                        borderRadius: BorderRadiusConst.normal,
                        child: model?.imageLinks?.thumbnail == null
                            ? Image.asset(LogoPaths.dummyBook)
                            : Image.network(
                                model?.imageLinks?.thumbnail ?? "",
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.08),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Text(model?.title ?? "null title"),
                          Text(model?.authors?.first ?? "null authors",
                              style: Theme.of(context).textTheme.bodySmall)
                        ],
                      ),
                    ),
                    SizedBox(height: context.dynamicHeight(0.015)),
                  ],
                ),
              ),
            ));
  final VolumeInfo? model;
  final BuildContext context;
}
