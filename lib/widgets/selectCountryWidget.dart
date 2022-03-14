import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

import 'header2.dart';

class SelectCountryWidget extends StatefulWidget {
  @override
  _SelectCountryWidgetState createState() => _SelectCountryWidgetState();
}

class _SelectCountryWidgetState extends State<SelectCountryWidget> {
  var countries = [];

  /* void initData() async {
    var c = await storage.read(key: 'countries');
    if (c == null) {
      var t = await getGoldenToken(hostUrl1);
      if (t != null) {
        var token = jsonDecode(t);
        c = await getCountries(hostUrl1, token);
      }
    }
    print(c);
    if (c != null) {
      setState(() {
        countries = jsonDecode(c);
      });
    }
  }*/

  @override
  void initState() {
    //initData();
    super.initState();
  }

  Widget loader() {
    if (countries.length > 0) {
      return ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, i) {
            return InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        color: countries[i]['Active']
                            ? Color(0xff5C376D)
                            : Color(0xff5C376D).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: context.diagonalInches >= 7
                          ? MediaQuery.of(context).size.width * 0.6
                          : MediaQuery.of(context).size.width,
                      height: 50 +
                          ((context.diagonalInches / 6.0).floorToDouble() * 20),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            countries[i]['Country'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          countries[i]['Active']
                              ? Text('Last Update 3/8/2021',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(0.5)))
                              : Text(
                                  'Data under updating ...',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white.withOpacity(0.5)),
                                )
                        ],
                      ))),
                ),
              ),
              onTap: () async {
                /*   if (countries[i]['Active']) {
                  await storage.write(key: 'inglistversion', value: '');
                  await storage.write(key: 'brandlistversion', value: '');
                  await storage.write(key: 'deslistversion', value: '');

                  await storage.write(
                      key: 'selectedCountry',
                      value: countries[i]['Country_ID'].toString());
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataLoadingScreen()),
                      (route) => false);
                }*/
              },
            );
          });
    } else if (countries.length == 0)
      return Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xffed5565))),
      );
    else
      return Center(
          child: Text(
        'Error Try again later',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: Colors.black45,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0Xfff5eded),
      body: Stack(
        children: [
          SizedBox(height: 220, child: Header2()),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: Align(
                  alignment: Alignment.center,
                  child: Text("Select Country",
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 300,
                  height: 220 - MediaQuery.of(context).padding.top - 55,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'soon... \n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Cairo',
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextSpan(
                                  text: 'other countries will be available')
                            ],
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.w600))),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'قريبا... \n',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Cairo',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(text: 'دول اخرى ستكون متاحة')
                            ],
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Cairo',
                                fontSize: 16,
                                fontWeight: FontWeight.w600))),
                  ),
                ),
                Expanded(child: loader()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
