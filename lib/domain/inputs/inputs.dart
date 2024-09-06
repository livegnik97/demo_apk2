export 'decimal.dart';
export 'email.dart';
export 'general.dart';
export 'name.dart';
export 'number.dart';
export 'password.dart';
export 'phone.dart';
export 'username.dart';

export 'custom_personal_validation.dart';

/**
 * Returns true if value is correct else return false
 */
typedef PersonalValidation = PersonalValidationResult Function(String value);

class PersonalValidationResult {
  late bool isValid;
  String? message;
  PersonalValidationResult.isValid() {
    isValid = true;
  }
  PersonalValidationResult.noValid(String this.message) {
    isValid = false;
  }
}

enum FormStatus {
  invalid,
  valid,
  validating,
  posting
}

/*
    "validForm_campoRequerido": "Campo requerido",
    "validForm_formatoIncorrecto": "Formato incorrecto",
    "validForm_longitud": "Debe poseer mínimo {cant} caracteres",
    "validForm_confirmPassword": "Debe coincidir con la contraseña"
*/