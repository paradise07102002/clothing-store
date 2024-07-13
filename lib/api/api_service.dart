import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:clothing_store/model/signup.dart';
import 'package:clothing_store/model/category.dart' as CategoryModel;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clothing_store/model/getAllProduct.dart' as GetAllProductModel;
import 'package:clothing_store/model/getProductById.dart' as GetProductByIdModel;
import 'package:clothing_store/model/getOptionValueById.dart' as GetOptionValueByIdModel;
import 'package:clothing_store/model/cart/getCart.dart' as GetCartModel;
import 'package:clothing_store/model/cart/addCartItem.dart' as AddCartItemModel;
import 'package:clothing_store/model/cart/putCartItem.dart' as PutCartItemModel;
import 'package:clothing_store/model/cart/deleteCartItem.dart' as DeleteCartItem;
import '../model/cart/getCart.dart';
import 'package:clothing_store/model/payment/getPayment.dart' as GetPaymentModel;

//Login
Future<void> loginUser(String username, String password) async {
  final String apiUrl = 'http://10.0.2.2:5117/api/User/login';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if(response.statusCode == 200) {
      final Map<String, dynamic> responseData =jsonDecode(response.body);
      final String token = responseData['result']['token'];
      final Map<String, dynamic> user = responseData['result']['user'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('user', jsonEncode(user));

      print("Login successful");
    } else {
      print('Failed to login. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to login');
    }
  } catch(e) {
    print('Error: $e');
    throw Exception('Failed to login');
  }
}
//SignUp
Future<void> registerUser(SignUp signUp) async {
  final String apiUrl = 'http://10.0.2.2:5117/api/User/signUp';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(signUp.toJson()),
    );

    if (response.statusCode == 200) {
      print("User registered successfully");
    } else {
      print('Failed to register user. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to register user');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to register user');
  }
}

//Get Category
Future<List<CategoryModel.Result>> fetchCategories() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Category'));

  if (response.statusCode == 200) {
    // Giải mã phản hồi JSON thành một bản đồ
    Map<String, dynamic> data = json.decode(response.body);

    // Chuyển đổi bản đồ JSON thành đối tượng Category
    CategoryModel.Category category = CategoryModel.Category.fromJson(data);

    // Trả về danh sách các Result từ Category
    return category.result ?? [];
  } else {
    debugPrint('Failed to load categories: ${response.statusCode}');
    throw Exception('Failed to load Categories');
  }
}

//Get all product
Future<List<GetAllProductModel.Result>> getAllProduct() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Product/getAllProduct'));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);

    GetAllProductModel.GetAllProduct getAllProduct = GetAllProductModel.GetAllProduct.fromJson(data);

    return getAllProduct.result ?? [];
  } else {
    debugPrint('Failed to load categories: ${response.statusCode}');
    throw Exception('Failed to load Categories');
  }
}

Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userJson = prefs.getString('user');
  if (userJson != null) {
    Map<String, dynamic> user = jsonDecode(userJson);
    return user['id'];
  }
  return null;
}
// Get product By Id
Future<GetProductByIdModel.Result?> getProductById(int productId) async {
  final String apiUrl = 'http://10.0.2.2:5117/api/Product/getProductByProductId/$productId';
  final response = await http.get(Uri.parse(apiUrl));

  try {
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      GetProductByIdModel.GetProductById getProductById = GetProductByIdModel.GetProductById.fromJson(data);

      return getProductById.result;
    } else {
      debugPrint('Failed to load optionvalue: ${response.statusCode}');
      throw Exception('failed to load');
    }
  } catch(e) {
    debugPrint('Failed to load optionvalue: ${response.statusCode}');
    throw Exception('Failed to load optionvalue: ${response.statusCode}');
  }
}

//Get optionvalue by id product
Future<List<GetOptionValueByIdModel.Result>> getOptionColor(int idProduct) async {
  final reponse = await http.get(Uri.parse('http://10.0.2.2:5117/api/OptionValue/GetOptionValueByProductId?id=$idProduct'));

  try {
    if (reponse.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(reponse.body);

      GetOptionValueByIdModel.GetOptionValueById getOptionValueById = GetOptionValueByIdModel.GetOptionValueById.fromJson(data);

      List<GetOptionValueByIdModel.Result> colorResult = getOptionValueById.result!.where((element) => element.optionId == 1).toList();
      // return getOptionValueById.result ?? [];
      return colorResult;
    } else {
      debugPrint('Failed to load optionvalue: ${reponse.statusCode}');
      throw Exception('Failed eee');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load optionvalue: $e');
  }
}
//Get optionvalue by id product
Future<List<GetOptionValueByIdModel.Result>> getOptionSize(int idProduct) async {
  final reponse = await http.get(Uri.parse('http://10.0.2.2:5117/api/OptionValue/GetOptionValueByProductId?id=$idProduct'));

  try {
    if (reponse.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(reponse.body);

      GetOptionValueByIdModel.GetOptionValueById getOptionValueById = GetOptionValueByIdModel.GetOptionValueById.fromJson(data);

      List<GetOptionValueByIdModel.Result> colorResult = getOptionValueById.result!.where((element) => element.optionId == 2).toList();
      // return getOptionValueById.result ?? [];
      return colorResult;
    } else {
      debugPrint('Failed to load optionvalue: ${reponse.statusCode}');
      throw Exception('Failed eee');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load optionvalue: $e');
  }
}

Future<void> addCartQuantity(int idCart, int idProductVariant) async {
  final apiUrl = 'http://10.0.2.2:5117/api/Cart/AddCartItem?id=$idCart';

  AddCartItemModel.AddCartItem addCartItem = AddCartItemModel.AddCartItem(
    productVariantId: idProductVariant,
    quantity: 1,
    isIncreasedBy: false
  );

  String jsonBody = json.encode(addCartItem.toJson());

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: jsonBody
  );

  try {
    if (response.statusCode == 200) {

    } else {
      debugPrint('ccc: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('ccc: ${response.statusCode}');
  }
}

Future<void> updateCartQuantity(int idCart, int cartItem,int idProductVariant, int quantity) async {
  final apiUrl = 'http://10.0.2.2:5117/api/Cart/$idCart/lineItems/$cartItem';

  PutCartItemModel.PutCartItem putCartItem = PutCartItemModel.PutCartItem(
      productVariantId: idProductVariant,
      quantity: quantity,
      isIncreasedBy: false
  );

  String jsonBody = json.encode(putCartItem.toJson());

  final response = await http.put(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonBody
  );

  try {
    if (response.statusCode == 200) {

    } else {
      debugPrint('fff: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('ggg: ${response.statusCode}');
  }
}

Future<void> deleteCartQuantity(int idCart, int cartItem,int idProductVariant) async {
  final apiUrl = 'http://10.0.2.2:5117/api/Cart/$idCart/lineItems/$cartItem';

  DeleteCartItem.DeleteCartItem deleteCartItem = DeleteCartItem.DeleteCartItem(
      productVariantId: idProductVariant,
      quantity: 0,
      isIncreasedBy: true
  );

  String jsonBody = json.encode(deleteCartItem.toJson());

  final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonBody
  );

  try {
    if (response.statusCode == 200) {

    } else {
      debugPrint('fff: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('ggg: ${response.statusCode}');
  }
}

Future<GetCartModel.GetCart?> fetchCartByUserId(int userId) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Cart/GetCartByUserId/$userId'));

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return GetCartModel.GetCart.fromJson(jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load cart');
  }
}

Future<List<GetProductByIdModel.ProductVariants>?> fetchProductVariant(int productId) async {

  final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Product/getProductByProductId/$productId'));

  try {
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      debugPrint("Data received from API: $data");

      GetProductByIdModel.GetProductById productById = GetProductByIdModel.GetProductById.fromJson(data);
      if (productById.result != null && productById.result!.productVariants != null) {
        return productById.result!.productVariants!;
      } else {
        throw Exception('Failed to load product variants');
      }
    } else {
      throw Exception('Failed to load product variants');
    }
  } catch (e) {
    debugPrint('Error: $e');
  }
}

Future<GetCartModel.GetCart> fetchDataX(int idNguoiDung) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  idNguoiDung = preferences.getInt('userId') ?? 0;
  final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Cart/GetCartByUserId/$idNguoiDung'));

  debugPrint('ccc: ${idNguoiDung}');
  if (response.statusCode == 200) {
    return GetCart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load cart');
  }
}

//Thanh toán
Future<GetPaymentModel.GetPayment?> fetchPaymentMethods() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Cart/getAllPaymentMethod'));

  try {
    if (response.statusCode == 200) {
      return GetPaymentModel.GetPayment.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('failedd: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('failedd: ${response.statusCode}');
  }
}
