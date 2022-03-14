import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

///
/// Validator class
///
class Validator {
  static String? validateName(String? name) {
    if (name!.isEmpty) {
      return GetStorage().read('lang') == "ar"
          ? "حقل الاسم مطلوب"
          : "The Name field is required";
      //return '';
    }
    return null;
  }

  static String? validateMessage(String? name) {
    if (name!.isEmpty) {
      return GetStorage().read('lang') == "ar"
          ? "حقل الرسالة مطلوب"
          : "The Message field is required";
      //return '';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return GetStorage().read('lang') == "ar"
          ? "حقل البريد الالكتروني مطلوب"
          : "The Email field is required";
      //return '';
    } else if (!GetUtils.isEmail(email)) {
      return GetStorage().read('lang') == "ar"
          ? "أدخل بريد إلكتروني صالح"
          : "Enter Valid Email";
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone!.isEmpty) {
      return GetStorage().read('lang') == "ar"
          ? "حقل رقم الهاتف مطلوب"
          : "The Phone Number field is required";
      //return '';
    } else if (phone.length < 3 || phone.length > 10) {
      return GetStorage().read('lang') == "ar"
          ? "أدخل رقم هاتف صالح"
          : "Enter Valid Phone Number";
    }
    return null;
  }

  static String? validateAddress(String? address) {
    if (address!.isEmpty) {
      return GetStorage().read('lang') == "ar"
          ? "حقل العنوان مطلوب"
          : "The Address field is required";

      //return '';
    }
    return null;
  }

  static String? validateCity(String? address) {
    if (address!.isEmpty) {
      return GetStorage().read('lang') == "ar"
          ? "حقل المدينة مطلوب"
          : "The City field is required";

      //return '';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    {
      if (password!.trim().length < 6 && password.trim().length > 0) {
        return GetStorage().read('lang') == "ar"
            ? "كلمة المرور قصيرة جدًا"
            : "Password Too Short";
      } else if (password.isEmpty) {
        return GetStorage().read('lang') == "ar"
            ? "حقل كلمة السر مطلوب"
            : "The Password field is required";
      } else {
        return null;
      }
    }
  }

  static String? validateLoginPassword(String? password) {
    {
      if (password!.trim().length < 3 && password.trim().length > 0) {
        return GetStorage().read('lang') == "ar"
            ? "كلمة المرور قصيرة جدًا"
            : "Password Too Short";
      } else if (password.isEmpty) {
        return GetStorage().read('lang') == "ar"
            ? "حقل كلمة السر مطلوب"
            : "The Password field is required";
      } else {
        return null;
      }
    }
  }

  static String? validatePasswordConf(String? password, confpassword) {
    {
      if (password != confpassword) {
        return GetStorage().read('lang') == "ar"
            ? "كلمة المرور غير متطابقة"
            : "The Password doesn`t match";
      }
      return null;
    }
  }
}
