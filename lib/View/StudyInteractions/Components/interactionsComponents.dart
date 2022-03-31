import 'package:adwiah/View/StudyInteractions/interactions.dart';
import 'package:flutter/material.dart';

class SeveritiesCard extends StatelessWidget {
  final data, details, mode;
  SeveritiesCard(this.data, this.details, {this.mode = 0});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GetInteractions(
                        details,
                        this.mode == 0
                            ? this.details[0]['ID']
                            : this.details[0]['Ing_ID'],
                        this.mode)));
          },
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 1, 25, 1),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Material(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      this.data['Severity_Level'],
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )),
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(50),
            color: data['Severity_Level_ID'] == 1
                ? Colors.green
                : data['Severity_Level_ID'] == 2
                    ? Colors.yellow[600]
                    : data['Severity_Level_ID'] == 3
                        ? Colors.orange
                        : Colors.red,
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetInteractions(
                            details,
                            this.mode == 0
                                ? this.details[0]['ID']
                                : this.details[0]['Ing_ID'],
                            this.mode)));
              },
            ),
          ),
        )
      ],
    );
  }
}
