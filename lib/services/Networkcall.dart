import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class Networkcall {
  static final Networkcall networkcall = new Networkcall._internal();
  Networkcall._internal();
  factory Networkcall() {
    return networkcall;
  }

  // //>>>>>>>>>>>>>>>>>>>>>>>>>>> singerRegister <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  // Future<bool> singerRegisterApiCall(
  //     String name, String mobile, String password, String email) async {
  //   // post_url
  //   String url = BASE_URL + 'singerRegister';
  //   Map<String, dynamic> body = {
  //     "name": "$name",
  //     "mobile": "$mobile",
  //     "password": "$password",
  //     "email": "$email"
  //   };
  //   var headers = {
  //     'Content-Type': "application/json",
  //     'Accept': "application/json",
  //     // 'Authorization': authorization!,
  //   };
  //   // print(json.encode(body));
  //   try {
  //     Response response =
  //         await MyClient().post(Uri.parse(url), body: body, headers: headers);
  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.decode(response.body);
  //       print('singerRegister $jsonResponse');
  //       if (jsonResponse['status'] == SUCCESS) {
  //         showToast(json.decode(response.body)["message"], red);
  //         return true;
  //       } else {
  //         throw CustomError(json.decode(response.body)["message"]);
  //       }
  //     } else {
  //       throw CustomError(json.decode(response.body)["message"]);
  //     }
  //   } on SocketException {
  //     throw CustomError('No Internet connection 😑');
  //   } catch (e) {
  //     print(e);
  //     e is CustomError
  //         ? throw CustomError(e.errorMessage())
  //         : throw CustomError(INTERNET_ERROR);
  //   }
  // }
  
  
  //>>>>>>>>>>>>>>>>>>>>>>>>>>> Fetch_OrganiserList <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  // Future<OrganiserModel?> fetchOrganiser() async {
  //   final auth_token = 'Bearer ${SharePreferenceInstance().getToken()}';
  //   String url = '$BASE_URL$allorganizer';
  //   print(url);
  //   print(auth_token);

  //   try {
  //     var headers = {
  //       'Content-Type': "application/json",
  //       'Accept': "application/json",
  //       'Authorization': auth_token,
  //     };
  //     Response response = await MyClient().get(
  //       Uri.parse(url),
  //       headers: headers,
  //     );
  //     if (response.statusCode == 200) {
  //       var jsonResponse = json.decode(response.body);
  //       print('jsonResponse: + $jsonResponse');
  //       if (jsonResponse['status'] == 'success') {
  //         return OrganiserModel.fromJson(jsonResponse);
  //       } else {
  //         throw CustomError(json.decode(response.body)["message"]);
  //       }
  //     } else {
  //       throw CustomError(json.decode(response.body)["message"]);
  //     }
  //   } on SocketException {
  //     throw CustomError('No Internet connection 😑');
  //   } catch (e) {
  //     // print(e);
  //     // showToast((e as CustomError).errorMessage(), red);
  //     e is CustomError
  //         ? throw CustomError(e.errorMessage())
  //         : throw CustomError(INTERNET_ERROR);
  //   }
  // }


}

Networkcall networkcallService = new Networkcall();
