import 'dart:convert';

import 'package:flutter_app/Screen/Models.dart';
import 'package:flutter_app/Screen/class/apidata%20get.dart';
import 'package:http/http.dart' as http;

import '../Models.dart';

class Services {
 static Future<List<getData>> getApiData() async {
    var url =
        'https://quizapi.io/api/v1/questions?apiKey=HywSJlYPmGqrfaHVHcHEiDtKViOUjFBccIDgADAz&limit=5';
    //   var jsonData= jsonDecode(response.body);
    try {
      var response = await http.get(Uri.parse(url));
      print(response);
      if (200 == response.statusCode) {

         final List<getData> users = welcomeFromJson(response.body);

        myList.addAll(users);

        return users;
      } else {
        return List<getData>();
      }
    } catch (e) {
      return List<getData>();
    }
  }



}

//  var url = 'http://jsonplaceholder.typicode.com/users';
//
//  Future<List<getData>> getUsers() async {
// try {
// var response = await http.get(Uri.parse(url));
// if (200 == response.statusCode) {
// final List<getData> users = getData.fromJson(response.body);
// return users;
// } else {
// return List<User>();
// }
// } catch (e) {
// return List<User>();
// }
// }
