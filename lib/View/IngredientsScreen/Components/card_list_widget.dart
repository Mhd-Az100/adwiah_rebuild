import 'package:adwiah/Widgets/alphabet_scoll.dart';
import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class CardList extends StatelessWidget {
  CardList({Key? key, required this.item}) : super(key: key);
  AzItem item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 40, 10),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => IngDetailsScreen(
          //             subdata[i]['ID'], subdata[i]['Name'])));
        },
        child: Tooltip(
          message: item.title,
          child: Container(
            height: 40 + ((context.diagonalInches / 6.0).floorToDouble() * 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: const Border.fromBorderSide(BorderSide(
                  color:
                      // subdata[i]['Type'] == 2
                      //     ? Colors.red[900] :
                      Colors.black54,
                  width: 2.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // subdata[i]['Type'] == 2
                  //     ? Container(
                  //         color: Colors.red[900],
                  //         width: 4,
                  //       )
                  //     : SizedBox(),
                  const SizedBox(
                    width: 3,
                  ),
                  Flexible(
                    child: Text(
                      // activ == 'name'
                      //     ? subdata[i]['Name'].toString()
                      //     :
                      item.title!,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color:
                              // subdata[i]['Type'] == 2
                              //     ? Colors.red[900]:
                              Colors.black54,
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
