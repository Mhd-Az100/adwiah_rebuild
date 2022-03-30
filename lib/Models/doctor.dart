class Doctor {
  String doctorName;
  String speciality;
  String phoneNumber;
  String mobileNumber;
  String address;

  Doctor.fromJson(Map<String, dynamic> json)
      : doctorName = json['doctorName'],
        speciality = json['speciality'],
        phoneNumber = json['phoneNumber'],
        mobileNumber = json['mobileNumber'],
        address = json['address'];
  Future<Map<String, dynamic>> toJson() async {
    // List a=await storage.read(key: 'doctors')!=null?jsonDecode(await storage.read(key: 'doctors')):[];
    // print(a);
    // a.add({
    //   'doctorName': doctorName,
    //   'speciality':speciality,
    //   'phoneNumber':phoneNumber,
    //   'mobileNumber':mobileNumber,
    //   'address':address
    // });
    // storage.write(key: 'doctors', value: jsonEncode(a));
    return {
      'doctorName': doctorName,
      'speciality': speciality,
      'phoneNumber': phoneNumber,
      'mobileNumber': mobileNumber,
      'address': address
    };
  }
}
