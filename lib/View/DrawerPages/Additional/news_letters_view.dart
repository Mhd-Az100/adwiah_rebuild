import 'package:adwiah/View/DrawerPages/Additional/news_letters_details.dart';
import 'package:adwiah/View/DrawerPages/drawer_view.dart';
import 'package:adwiah/View/InitialPages/View_Model/initial_data_view_model.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsLetters extends StatelessWidget {
  NewsLetters({Key? key}) : super(key: key);
  InitialAppController controller = Get.put(Get.find<InitialAppController>());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: Stack(
        children: [
          SizedBox(height: 220, child: Header()),
          Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                // actions: <Widget>[BarcodeReader(mode: 1)],
                elevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: FittedBox(
                    child: Text('News Letter',
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        style: TextStyle(fontSize: 24))),
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 220 - MediaQuery.of(context).padding.top - 55,
                    child: Center(
                      child: FittedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaterialButton(
                                  minWidth: 130,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: const FittedBox(
                                    child: Text(
                                      'English',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        // color: lang == 'en'
                                        //     ? Colors.white
                                        //     : Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  height: 45,
                                  onPressed: () async {
                                    // lang = 'en';
                                    // await loadFeed();
                                    // setState(() {
                                    //   lang = 'en';
                                    // });
                                  },
                                  // color: lang == 'en'
                                  //     ? Color(0xff5C376D)
                                  //     : Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                MaterialButton(
                                  minWidth: 130,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: const FittedBox(
                                    child: Text(
                                      'العربية',
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 14,
                                        // color: lang == 'ar'
                                        //     ? Colors.white
                                        //     : Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  height: 45,
                                  onPressed: () async {
                                    // lang = 'ar';
                                    // await loadFeed();
                                    // setState(() {
                                    //   lang = 'ar';
                                    // });
                                  },
                                  // color: lang == 'ar'
                                  //     ? Color(0xff5C376D)
                                  //     : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: ListView.builder(
                        itemCount: controller.posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Directionality(
                            textDirection: TextDirection.ltr,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.fromBorderSide(BorderSide(
                                      color:
                                          // subdata[i]['Type'] == 2
                                          //     ? Colors.red[900] :
                                          Colors.black54,
                                      width: 2.0)),
                                ),
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Text(
                                            controller.posts[index].title!,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          controller.posts[index].postDate!
                                              .toString()
                                              .substring(0, 11),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w100),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              controller.posts[index]
                                                  .shortDescription!,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          Expanded(
                                            child: Image.network(controller
                                                .posts[index].imageUrl!
                                                .trim()),
                                          ),
                                        ],
                                      ),
                                      MaterialButton(
                                        child: const Text(
                                          'Details',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Get.to(NewsDetails(
                                            item: controller.posts[index],
                                            lang: 'en',
                                          ));
                                        },
                                        color: Color(0xff5C376D),
                                      )
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.all(5.0),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 9),
          child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: BottomControllBar(0))),
    );
  }
}
