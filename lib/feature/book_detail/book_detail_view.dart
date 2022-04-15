import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class BookDetail extends StatelessWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // leading: IconButton(
        //   color: Colors.black,
        //   onPressed: () {},
        //   icon: Icon(Icons.arrow_back),
        // ),
        // actions: [
        //   IconButton(
        //     color: Colors.black,
        //     onPressed: () {},
        //     icon: Icon(Icons.send_and_archive),
        //   ),
        // ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: 221,
                height: 330,
                child: Column(
                  children: [
                    SizedBox(
                        height: context.dynamicHeight(0.3),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              "https://picsum.photos/250",
                              fit: BoxFit.cover,
                            ))),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(20),
                    //     image: const DecorationImage(
                    //       image: NetworkImage(
                    //           'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    //   width: 179,
                    //   height: 200,
                    //   margin: EdgeInsets.only(bottom: 10),
                    // ),
                    Container(
                      child: Column(
                        children: [
                          Text('Catcher in the Rye'),
                          Text(
                            'J.D. Salinger',
                            style: TextStyle(fontSize: 13),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                              ),
                              Text('4.0')
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    Text(
                      'About the author',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "This is a long texThis is a long teThis is a This is a long teThis is a long teThis is a long teThis is a long teThis is a long teThis is a long teThis is a long teThis is a long teThis is a long teThis is a long te teThis is a long teThis is a long teThis is a long teThis is a long teThis is a long teThis is a long teThis is a long tet",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'The Catcher in the Rye is a novel by J. D. Salinger, partially published in serial form in 1945–1946 a published in serial form in 1945–1946 a published in serial form in 1945–1946 a published in serial form in 1945–1946 a published in serial form in 1945–1946 a published in serial form in 1945–1946 a published in serial form in 1945–1946 a published in serial form in 1945–1946 a published in serial form in 1945–1946 and as a novel in 1951. It was originally intended for adu lts but is often read by adolescents for its theme of angst, alienation and as a critique......',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      softWrap: false,
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('Read Previews'),
                      textColor: Colors.white,
                      color: Colors.red,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('Buy for %14.05'),
                      textColor: Colors.white,
                      color: Colors.black45,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
