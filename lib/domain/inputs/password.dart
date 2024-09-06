import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:demo_apk/main.dart';

import 'inputs.dart';

// Define input validation errors
enum PasswordErrorInput {
  empty,
  length,
  format,
  confirm,
  invalid_char,
  personalValidation
}

// Extend FormzInput and provide the input type and error type.
class PasswordInput extends FormzInput<String, PasswordErrorInput> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  final bool isRequired;
  final bool beStrict;
  final int minLength;
  final String? passwordConfirm;
  final PersonalValidation? personalValidation;

  // Call super.pure to represent an unmodified form input.
  const PasswordInput.pure({
    this.isRequired = true,
    this.beStrict = false,
    this.minLength = 8,
    this.passwordConfirm,
    this.personalValidation,
  }) : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordInput.dirty(
    String value, {
    this.isRequired = true,
    this.beStrict = false,
    this.minLength = 8,
    this.passwordConfirm,
    this.personalValidation,
  }) : super.dirty(value);

  String? errorMessage(BuildContext context) {
    if (isValid || isPure) return null;
    if (displayError == PasswordErrorInput.empty) {
      return AppLocalizations.of(context)!.validForm_campoRequerido;
    }
    if (displayError == PasswordErrorInput.format) {
      return AppLocalizations.of(context)!.validForm_formatoIncorrecto;
    }
    if (displayError == PasswordErrorInput.length) {
      return AppLocalizations.of(context)!.validForm_longitud(minLength);
    }
    if (displayError == PasswordErrorInput.confirm) {
      return AppLocalizations.of(context)!.validForm_confirmPassword;
    }
    if (displayError == PasswordErrorInput.invalid_char) {
      return AppLocalizations.of(context)!.validForm_invalid_char;
    }
    if (displayError == PasswordErrorInput.personalValidation) {
      return personalValidation!(value).message ?? "Error";
    }
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PasswordErrorInput? validator(String value) {
    value = value.trim();
    if (value.isEmpty) {
      if (isRequired) {
        return PasswordErrorInput.empty;
      } else {
        return null;
      }
    }
    if (value.length < minLength) return PasswordErrorInput.length;
    if (!passwordRegExp.hasMatch(value) && beStrict) {
      return PasswordErrorInput.format;
    }
    if (value.contains("{") || value.contains("}")) {
      return PasswordErrorInput.invalid_char;
    }
    if (passwordConfirm != null && value != passwordConfirm) {
      return PasswordErrorInput.confirm;
    }
    if (personalValidation != null && !personalValidation!(value).isValid) {
      return PasswordErrorInput.personalValidation;
    }
    return null;
  }

  String get realValue => value.trim();
}
