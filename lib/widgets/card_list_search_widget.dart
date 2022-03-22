import 'package:adwiah/Models/brand.dart';
import 'package:adwiah/Models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class CardListSearch extends StatelessWidget {
  CardListSearch({Key? key, this.ingredient, this.ontap, this.brand})
      : super(key: key);
  IngredientModel? ingredient;
  BrandModel? brand;
  void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 40, 10),
      child: InkWell(
        onTap: ontap,
        child: Tooltip(
          message: ingredient != null ? ingredient!.name : brand!.brandName,
          child: Container(
            height: 40 + ((context.diagonalInches / 6.0).floorToDouble() * 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: const Border.fromBorderSide(BorderSide(width: 2.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  ingredient != null
                      ? ingredient!.type == 2
                          ? Container(
                              color: Colors.red[900],
                              width: 4,
                            )
                          : const SizedBox()
                      : const SizedBox(),
                  const SizedBox(
                    width: 3,
                  ),
                  Flexible(
                    child: Text(
                      // activ == 'name'
                      //     ? subdata[i]['Name'].toString()
                      //     :
                      ingredient != null
                          ? ingredient!.name!
                          : brand!.brandName!,
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
