import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String url = '10.0.2.2:8000';
const String endpoint = '/api/v1';
var dataUser = {};
var datapegawai = {};

class SharedPref {
  static saveStr(String key, String message) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, message);
  }

  static readPrefStr(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static saveInt(String key, int message) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, message);
  }

  static readPrefInt(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static getAllData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getKeys();
  }

  static saveNullableStr(String key, String? value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value ?? '');
  }

  static Future<String?> readNullableStr(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static saveNullableInt(String key, int? value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (value != null) {
      pref.setInt(key, value);
    } else {
      pref.remove(key);
    }
  }

  static Future<int?> readNullableInt(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }
}
