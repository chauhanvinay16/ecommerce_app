import 'dart:convert';
import 'package:e_com_pay/modal/user_register_modal.dart';
import 'package:http/http.dart' as http;
import '../modal/product_modal.dart';
import '../modal/single_product_modal.dart';
import '../modal/user_detail_modal.dart';

class ApiServices {
  String baseUrl = "https://fakestoreapi.com";

  Future<dynamic> userLogin(String username, String password) async {
    try {
      var response = await http.post(Uri.parse("$baseUrl/auth/login"),
          body: {
            "username": username,
            "password": password,
          }
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      return null;
    }
  }
  Future<dynamic> registerUser(UserRegisterModal userRegisterModal) async {
    var response = await http.post(Uri.parse('$baseUrl/users'),
        body: jsonEncode(userRegisterModal),
        headers: {'Content-Type': 'application/json'}); // Add JSON headers

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body); // Decode JSON response
      return responseData; // Return the decoded response
    } else {
      throw Exception('Register API Error');
    }
  }

  //All Product
  Future<List<ProductModal>?> getAllproduct() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/products'));
      print(response.body);
      if (response.statusCode == 200) {
        return List<ProductModal>.from(json.decode(response.body).map((x) => ProductModal.fromJson(x)));
      }
    } catch (e) {
      print("Error:${e.toString()}");
      return []; // return an empty list if an exception occurs
    }
  }

  Future<SingleProductModal?>getsingleproduct(int id)async{
    try{
      var response= await http.get(Uri.parse('$baseUrl/products/$id'));
      print("Single Product API===>${response.body}");

      if(response.statusCode==200){
        return SingleProductModal.fromJson(jsonDecode(response.body));
      }
    }catch(e){
      print("Error:${e.toString()}");
    }
  }

  Future<dynamic> getallcategory() async {
    var response = await http.get(Uri.parse('$baseUrl/products/categories'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Categoty API Error');
    }
  }

  //All category Product
  Future<List<ProductModal>?> getAllproductcategory(String categoryName) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/products/category/$categoryName'));
      print(response.body);
      if (response.statusCode == 200) {
        return List<ProductModal>.from(json.decode(response.body).map((x) => ProductModal.fromJson(x)));
      }
    } catch (e) {
      print("Error:${e.toString()}");
      return []; // return an empty list if an exception occurs
    }
  }

  Future<UserDetail>userdetail(int userid)async{
    var response=await http.get(Uri.parse('$baseUrl/users/$userid'));
    print(response.body);
    if(response.statusCode==200){
      return UserDetail.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("UserDetail API Errorr");
    }
  }
}