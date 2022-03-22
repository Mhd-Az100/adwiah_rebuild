import 'package:adwiah/Models/posts_news.dart';
import 'package:adwiah/View/DrawerPages/drawer_view.dart';
import 'package:adwiah/widgets/bottombar.dart';
import 'package:adwiah/widgets/header.dart';
import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  NewsDetails({this.item, this.lang = 'en'});
  final PostsModel? item;
  final String lang;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: Stack(
        children: [
          SizedBox(height: 300, child: Header()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              // actions: <Widget>[BarcodeReader(mode: 1)],
              elevation: 0,
              backgroundColor: Colors.transparent, centerTitle: true,
              title: FittedBox(
                  child: Text('News Details',
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      style: TextStyle(fontSize: 24))),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Directionality(
                textDirection:
                    lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 300 - MediaQuery.of(context).padding.top - 55,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          Image.network(item!.imageUrl!),
                          SizedBox(
                            height: 20,
                          ),
                          Text(item!.description!)
                        ],
                      )),
                    )
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 9),
          child: Container(
              width: 200,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: BottomControllBar(0))),
    );
  }
}
