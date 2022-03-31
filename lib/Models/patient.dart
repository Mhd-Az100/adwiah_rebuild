import 'dart:convert';

import 'package:adwiah/Models/disease.dart';
import 'package:get_storage/get_storage.dart';

// StorageHelperController storage = Get.find<StorageHelperController>();
final storage = GetStorage();

class Patient {
  String? name;
  String? gender;
  String? dob;
  List chronic_diseases = [];
  List chronic_midicens = [];
  List drug_hypersensetitvity = [];
  Patient.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        gender = json['gender'],
        dob = json['dob'],
        chronic_diseases = json['chronic_diseases'] ?? [],
        chronic_midicens = json['chronic_midicens'] ?? [],
        drug_hypersensetitvity = json['drug_hypersensetitvity'] ?? [];

  Map<String, dynamic> toJson() {
    var p = jsonEncode({
      'name': name,
      'gender': gender,
      'dob': dob,
      'chronic_diseases': chronic_diseases,
      'chronic_midicens': chronic_midicens,
      'drug_hypersensetitvity': drug_hypersensetitvity
    });
    storage.write('patient', p);
    return {
      'name': name,
      'gender': gender,
      'dob': dob,
      'chronic_diseases': chronic_diseases,
      'chronic_midicens': chronic_midicens,
      'drug_hypersensetitvity': drug_hypersensetitvity
    };
  }
}
