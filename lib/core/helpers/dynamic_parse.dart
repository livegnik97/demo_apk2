/*
  MODO DE USO
  - Al parsear un dato dynamic en int, double o list puede generar un error
  y sino se contiene explota, con esta clase ya no te debes preocupar por eso

  - Para parseo simple de int
  int amount = DynamicParse.toInt(json['amount'], 0);

  - Para parseo simple de int?
  int? amount = DynamicParse.toIntOrNull(json['amount']);

  - Para parseo simple de double
  double amount = DynamicParse.toDouble(json['amount'], 0);

  - Para parseo simple de double?
  double? amount = DynamicParse.toDoubleOrNull(json['amount']);

  - Para parseo de un objeto de una clase que también se va a construir con
  un json y pudiera generar un error a la hora de construirse
  Review? review = DynamicParse.toObjectOrNull(
              json["review"], (item) => Review.fromJson(item)),
  variante con valor por defecto
  Review review = DynamicParse.toObject(
              json["review"], (item) => Review.fromJson(item), Review()),

  - Para parseo de listas, esto garantiza que si ocurre un error en un item
  no se afecte la lista completa
  List<DocumentModel> documents =
    DynamicParse.toList(json["documents"], (item) => DocumentModel.fromJson(item));
*/

import 'package:flutter/foundation.dart';

typedef CustomParseFunction<T> = T Function(dynamic item);

//* Poner en true si quieres que el error se lanze fuera de la clase
const bool forceCrash = false;

class DynamicParse {
  static int toInt(dynamic data, int defaultValue) {
    return toIntOrNull(data) ?? defaultValue;
  }

  static int? toIntOrNull(dynamic data) {
    if (data == null) return null;
    if (data is int) return data;
    try {
      return int.parse('$data');
    } catch (e) {
      if (kDebugMode) {
        print("DynamicParseError general: $e");
        print(
            "DynamicParseError when trying to parse data of type ${data.runtimeType} to int");
        print("DynamicParseError data: $data");
        if (forceCrash) rethrow;
      }
    }
    return null;
  }

  static double toDouble(dynamic data, double defaultValue) {
    return toDoubleOrNull(data) ?? defaultValue;
  }

  static double? toDoubleOrNull(dynamic data) {
    if (data == null) return null;
    if (data is double) return data;
    try {
      return double.parse('$data');
    } catch (e) {
      if (kDebugMode) {
        print("DynamicParseError general: $e");
        print(
            "DynamicParseError when trying to parse data of type ${data.runtimeType} to double");
        print("DynamicParseError data: $data");
        if (forceCrash) rethrow;
      }
    }
    return null;
  }

  static num toNumber(dynamic data, double defaultValue) {
    return toNumberOrNull(data) ?? defaultValue;
  }

  static num? toNumberOrNull(dynamic data) {
    if (data == null) return null;
    if (data is num) return data;
    try {
      return num.parse('$data');
    } catch (e) {
      if (kDebugMode) {
        print("DynamicParseError general: $e");
        print(
            "DynamicParseError when trying to parse data of type ${data.runtimeType} to num");
        print("DynamicParseError data: $data");
        if (forceCrash) rethrow;
      }
    }
    return null;
  }

  static T toObject<T>(
      dynamic data, CustomParseFunction<T> parseFunction, T defaultValue) {
    return toObjectOrNull<T>(data, parseFunction) ?? defaultValue;
  }

  static T? toObjectOrNull<T>(
      dynamic data, CustomParseFunction<T> parseFunction) {
    if (data == null) return null;
    try {
      return parseFunction(data);
    } catch (e) {
      if (kDebugMode) {
        print("DynamicParseError general: $e");
        print(
            "DynamicParseError when trying to parse data of type ${data.runtimeType} to $T");
        print("DynamicParseError data: $data");
        if (forceCrash) rethrow;
      }
    }
    return null;
  }

  static List<T> toList<T>(
      dynamic dataList, CustomParseFunction<T> parseFunction) {
    final result = <T>[];
    if (dataList == null) return result;
    if (dataList is! Iterable) {
      if (kDebugMode) {
        print(
            "DynamicParseError when trying to parse data of type ${dataList.runtimeType} to ${List<T>}");
        print("DynamicParseError data: $dataList");
        if (forceCrash) {
          throw ArgumentError(
              "DynamicParseError into toList() method because dataList is not Iterable");
        }
      }
      return result;
    }
    try {
      for (final item in dataList) {
        try {
          result.add(parseFunction(item));
        } catch (e) {
          if (kDebugMode) {
            print("DynamicParseError general: $e");
            print(
                "DynamicParseError when trying to parse data of type ${item.runtimeType} to $T");
            print("DynamicParseError data: $item");
            if (forceCrash) rethrow;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("DynamicParseError general: $e");
        print(
            "DynamicParseError when trying to parse data of type ${dataList.runtimeType} to ${List<T>}");
        print("DynamicParseError data: $dataList");
        if (forceCrash) rethrow;
      }
    }
    return result;
  }
}
