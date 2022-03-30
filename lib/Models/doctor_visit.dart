import 'dart:convert';

class DoctorVisit {
  String doctorName;
  String specialisty;
  String address;
  String phoneNumber;
  String visiteDate;
  String symptoms;
  List labTests;
  String Diagnosis;

  DoctorVisit.fromJson(Map<String, dynamic> json)
      : doctorName = json['doctorName'],
        specialisty = json['specialisty'],
        address = json['address'],
        phoneNumber = json['phoneNumber'],
        visiteDate = json['visiteDate'],
        symptoms = json['symptoms'],
        labTests = json['labTests'],
        Diagnosis = json['Diagnosis'];

  Future<Map<String, dynamic>> toJson() async {
    // List a=await storage.read(key: 'doctorVisitsList')!=null?jsonDecode(await storage.read(key: 'doctorVisitsList')):[];
    // print(a);
    // a.add({
    //   'doctorName': doctorName,
    //   'specialisty': specialisty,
    //   'address': address,
    //   'phoneNumber': phoneNumber,
    //   'symptoms': symptoms,
    //   'labTests': labTests,
    //   'Diagnosis': Diagnosis,
    //   'visiteDate': visiteDate
    // });
    // storage.write(key: 'doctorVisitsList', value: jsonEncode(a));
    return {
      'doctorName': doctorName,
      'specialisty': specialisty,
      'address': address,
      'phoneNumber': phoneNumber,
      'symptoms': symptoms,
      'labTests': labTests,
      'Diagnosis': Diagnosis,
      'visiteDate': visiteDate
    };
  }
}
