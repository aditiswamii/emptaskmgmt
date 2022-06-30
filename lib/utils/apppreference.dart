import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences  {
  static const USERID = "USERID";
  static const  IS_DEVICE_REGISTERED = "IS_THIS_REGISTERED";
  static const  TOKEN = "TOKEN";
  static const  NAME = "NAME";
  static const  EMAIL = "EMAIL";
  static const FCMTOKEN="FCMTOKEN";
  static const PROFILE_COMPLETE="PROFILE_COMPLETE";
  static const PIC="PIC";
  static const LOGIN="LOGIN";


  setAuthToken(String authToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, authToken);
  }
  getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(TOKEN);
    return stringValue;
  }
  setPic(String pic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, pic);
  }
  getPic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(TOKEN);
    return stringValue;
  }
  setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(NAME, name);
  }
  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(NAME);
    return stringValue;
  }
  setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(EMAIL, email);
  }
  getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(EMAIL);
    return stringValue;
  }
  setFCMToken(String fcmtoken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(FCMTOKEN, fcmtoken);
  }
  getFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(FCMTOKEN);
    return stringValue;
  }
  setuserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(USERID, userId);
  }
  getuserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int? intValue = prefs.getInt(USERID);
    return intValue;
  }
  setIsRegistered(bool isregistered) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_DEVICE_REGISTERED, isregistered);
  }
  getIsRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool(IS_DEVICE_REGISTERED);
    return boolValue;
  }
  setLogin(bool login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_DEVICE_REGISTERED, login);
  }
  isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool(IS_DEVICE_REGISTERED);
    return boolValue;
  }
  setProfileComplete(bool isyes) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PROFILE_COMPLETE, isyes);
  }
  getProfileComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool(PROFILE_COMPLETE);
    return boolValue;
  }
  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(TOKEN);
    prefs.remove(IS_DEVICE_REGISTERED);
    prefs.remove(USERID);
    prefs.remove(EMAIL);

  }



}