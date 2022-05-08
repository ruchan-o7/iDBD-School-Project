import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:school_project_ibdb/core/constants/border_radius.dart';
import 'package:school_project_ibdb/product/book_categories/categories.dart';

class AddBookView extends StatelessWidget {
  AddBookView({Key? key}) : super(key: key);

  String publishDate = "";
  //Todo: generate book id 12 letter,
  //Todo:

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Add book"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: context.paddingLow,
          child: Form(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: context.dynamicHeight(0.20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadiusConst.normal,
                      ),
                      child: const Icon(Icons.add_a_photo),
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusConst.normal),
                          child: TextFormField(decoration: const InputDecoration(hintText: "Book name")),
                        ),
                        const Divider(),
                        Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadiusConst.normal),
                            child: TextFormField(decoration: const InputDecoration(hintText: "Author name"))),
                      ],
                    ),
                  ),
                ],
              ),
              Card(
                child: ListTile(
                  leading: const Text("Categories"),
                  title: DropdownButton(
                    borderRadius: BorderRadiusConst.normal,

                    onChanged: ((value) {}), //Todo:function implement
                    value: Categories.instance.getCategorieList?.first,
                    icon: const Icon(Icons.arrow_downward),
                    items: Categories.instance.getCategorieList
                        ?.map((String value) => DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                  ),
                ),
              ),
              Card(
                  child: ListTile(
                leading: const Text("Publish Date"),
                title: TextFormField(
                  decoration: InputDecoration(
                      hintText: publishDate,
                      suffixIcon: IconButton(
                          onPressed: () async {
                            final date = await showDatePicker(
                                currentDate: DateTime.now(),
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(0),
                                lastDate: DateTime.now());
                            publishDate = "${date?.day}/${date?.month}/${date?.year}";
                            print(publishDate);
                          },
                          icon: const Icon(Icons.calendar_month))),
                ),
              )),
              Card(
                  child: ListTile(
                leading: const Text("Page Count"),
                title: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(),
                ),
              )),
              Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusConst.normal),
                  child: TextFormField(
                    maxLines: 18,
                    decoration: const InputDecoration(hintText: "Description"),
                  )),
            ],
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Ok",
                            style: Theme.of(context).textTheme.button,
                          ))
                    ],
                    title: Center(
                      child: Text("Request sent succesfuly"),
                    ),
                  ));
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
