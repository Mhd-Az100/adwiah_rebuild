// ignore_for_file: use_key_in_widget_constructors

import 'package:adwiah/Models/brands_by_id_model.dart';
import 'package:adwiah/View/BrandsScreen/Components/brand_icons.dart';
import 'package:adwiah/View/BrandsScreen/branddetailsscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BrandCard extends StatelessWidget {
  final BrandByIdModel data;
  BrandCard(this.data, {Key? key}) : super(key: key);
  final oCcy = NumberFormat("#,##0", "en_US");
  final dateformat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        InkWell(
          onTap: () {
            Get.to(() => BrandDetailsScreen(data));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        data.brandName!,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Color(0xff1c2340),
                          fontWeight: FontWeight.w800,
                        ),
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                    Text(
                      data.pharmaceuticalForm!,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: Color(0xff1c2340),
                        fontWeight: FontWeight.w400,
                      ),
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(child: BranIconRow(data.bg, data.otc, data.icon)),
                    const SizedBox(
                      height: 10,
                    ),
                    data.caliberEn != null && data.caliberEn != ""
                        ? Column(
                            children: [
                              Text(
                                data.caliberEn != null && data.caliberEn != ""
                                    ? data.caliberEn!
                                    : "",
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: Color(0xff1c2340),
                                  fontWeight: FontWeight.w400,
                                ),
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    Wrap(
                      children: [
                        RichText(
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor,
                            text: TextSpan(
                                style: const TextStyle(height: 1.5),
                                children: [
                                  const TextSpan(
                                    text: 'Lab/Country : ',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      color: Color(0xff1c2340),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${data.lab ?? ''}  ',
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      color: Color(0xffed5565),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ])),
                        RichText(
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor,
                            text: TextSpan(
                                style: const TextStyle(height: 1.5),
                                children: [
                                  const TextSpan(
                                    text: 'Price : ',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      color: Color(0xff1c2340),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: data.price.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      color: Color(0xffed5565),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ])),
                        RichText(
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor,
                            text: TextSpan(
                                style: const TextStyle(height: 1.5),
                                children: [
                                  const TextSpan(
                                    text: 'Last Price Update : ',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      color: Color(0xff1c2340),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: data.lastUpdateDate != null
                                        ? dateformat.format(dateformat
                                            .parse(data.lastUpdateDate!))
                                        : '',
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      color: Color(0xffed5565),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ]))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(50),
            color: const Color(0xff5C376D),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => BrandDetailsScreen(this.data)));
              },
            ),
          ),
        )
      ],
    );
  }
}
