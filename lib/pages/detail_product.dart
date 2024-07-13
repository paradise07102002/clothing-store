import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clothing_store/model/getProductById.dart' as GetProductByIdModel;
import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/getOptionValueById.dart' as GetOptionValueByIdModel;
import 'package:clothing_store/model/cart/getCart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:clothing_store/pages/cart_page.dart';

import '../provider/app_localizations.dart';


String linkImage = '';
int indexThumbnail = 0;

int idColor = -1, idSize = -1;

int userId = 0;
int cartId = 0;
int idProductViant = 0;

Future<List<String>> fetchThumbnails(int idProduct) async {
  final String apiUrl = 'http://10.0.2.2:5117/api/OptionValue/GetOptionValueByProductId?id=$idProduct';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final getOptionValueById = GetOptionValueByIdModel.GetOptionValueById.fromJson(json.decode(response.body));
    if (getOptionValueById.result != null && getOptionValueById.result!.isNotEmpty) {
      return getOptionValueById.result!.map((result) => result.thumbnail ?? '').toList();
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load option values');
  }
}

class DetailProductPage extends StatefulWidget {
  DetailProductPage({super.key, required this.productId});

  final int productId;
  @override
  State<DetailProductPage> createState() => _DetailProductPage();
}

class _DetailProductPage extends State<DetailProductPage> {

  GetProductByIdModel.ProductVariants? productVariants;
  Future<void> fetProductVariant() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int idProduct = widget.productId;
    final response = await http.get(Uri.parse('http://localhost:5117/api/Product/getProductByProductId/$idProduct'));

    if (response.statusCode == 200) {
      setState(() {
        productVariants = GetProductByIdModel.ProductVariants.fromJson(jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to load cart');
    }
  }

  bool _isFavorite = false;
  int _selectedColorId = -1;
  int _selectedSizeId = -1;

  void updateImageProduct (String newImage) {
    setState(() {
      linkImage = newImage;
    });
  }

  late Future<List<String>> futureThumbnails;
  String? selectedThumbnail;

  GetCart? cartData;
  int? idNguoiDung;

  void _selectColor(int index, int colorId) {
    setState(() {
      _selectedColorId = colorId;
      indexThumbnail = index;
    });
  }

  void _selectSize(int index, int sizeId) {
    setState(() {
      _selectedSizeId = sizeId;
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void getCartId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getInt('userId') ?? 0;
    });
    try {
      if (userId != 0) {
        GetCart? getcart = await fetchCartByUserId(userId);
        if (getcart != null) {
          setState(() {
            cartId = getcart.result?.id ?? 0;
          });
        }
      }
    } catch (e) {
      throw Exception('Failed');
    }
  }

  late Future<GetProductByIdModel.Result?> futureProduct;

  @override
  void initState() {
    super.initState();
    getCartId();
    futureProduct = getProductById(widget.productId);
    fetchData();
    futureThumbnails = fetchThumbnails(widget.productId);
    fetProductVariant();
    mainn();
  }

  void _showLoginAlertDialog(int ggg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text('$ggg'),
          actions: <Widget>[
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.pop(context); // Đóng AlertDialog
              },
            ),
          ],
        );
      },
    );
  }
  void _showAlertDialog(String ggg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(ggg),
          actions: <Widget>[
            TextButton(
              child: Text('Đóng'),
              onPressed: () {
                Navigator.pop(context); // Đóng AlertDialog
              },
            ),
          ],
        );
      },
    );
  }
  GetProductByIdModel.ProductVariants? filterProductVariant(List<GetProductByIdModel.ProductVariants> variants, int colorOptionValueId, int sizeOptionValueId) {
    for (var variant in variants) {
      bool matchColor = false;
      bool matchSize = false;

      if (variant.variantValues != null) {
        for (var value in variant.variantValues!) {
          if (value.optionId == 1 && value.optionValueId == colorOptionValueId) {
            matchColor = true;
          }
          if (value.optionId == 2 && value.optionValueId == sizeOptionValueId) {
            matchSize = true;
          }
        }
      }

      if (matchColor && matchSize) {
        return variant;
      }
    }

    return null;
  }

  void mainn() async {

    try {
      List<GetProductByIdModel.ProductVariants>? variants = await fetchProductVariant(widget.productId);

      if (variants!.isNotEmpty) {
        GetProductByIdModel.ProductVariants? filteredVariant = filterProductVariant(variants!, idColor, idSize);

        if (filteredVariant != null) {
          setState(() {
            idProductViant = filteredVariant.id!;
          });
          // _showAlertDialog('${filteredVariant.id}');
        } else {
          print('No matching product variant found');
        }
      }
      else {
        print('No product variants found');
      }
    } catch (e) {
      throw Exception('Failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GetProductByIdModel.Result?>(
        future: futureProduct,
        builder: (context, productSnapshot) {
          if (productSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (productSnapshot.hasError) {
            return Center(child: Text('Error: ${productSnapshot.error}'));
          } else if (!productSnapshot.hasData || productSnapshot.data == null) {
            return Center(child: Text('No data available'));
          } else {
            GetProductByIdModel.Result product = productSnapshot.data!;
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 45.0),
                    Container(
                      color: Colors.white,
                      height: 60.0,
                      width: 400.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 15.0),
                          SizedBox(
                            width: 48.0,
                            height: 48.0,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 48.0,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.zero)
                              ),
                            ),
                          ),
                          // const SizedBox(width: 120.0,),
                          // Expanded(
                          //     child: Text(AppLocalizations.of(context)?.translate('productDetail') ?? '',
                          //       style: TextStyle(
                          //           fontSize: 24.0,
                          //           fontWeight: FontWeight.bold),
                          //       overflow: TextOverflow.ellipsis,
                          //     ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      height: 400.0,
                      width: 400.0,
                      child: FutureBuilder<List<String>>(
                        future: futureThumbnails,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            return Image.network(snapshot.data![indexThumbnail], width: 250.0, height: 250.0,);
                          } else {
                            return Image.network('', width: 250.0, height: 250.0,);
                          }
                        },
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: 400.0,
                      height: 100.0,
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 7.0, right: 7.0),
                      child: SingleChildScrollView(
                        child: Text(product.description ?? '', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: 400.0,
                      child: Row(
                        children: [
                          SizedBox(width: 25.0,),
                          Expanded(
                            child: Text(product.price.toString() + ' đ', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.red), overflow: TextOverflow.ellipsis,),
                          ),
                          SizedBox(width: 100.0,),
                          IconButton(
                            icon: Icon(
                              _isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: _isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: _toggleFavorite,
                            iconSize: 48.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            width: 350.0,
                            margin: EdgeInsets.only(left: 10.0),
                            child: Text('Màu', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            width: 350.0,
                            height: 64.0,
                            child: ListColorWidget(idProduct: widget.productId, onColorSelected: _selectColor),
                            // child: ListColorWidget(idProduct: widget.productId, onColorSelected: _selectColor),
                          ),
                          Container(
                            width: 350.0,
                            margin: EdgeInsets.only(left: 10.0),
                            child: Text('Size', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35.0, bottom: 15.0),
                            height: 64.0,
                            child: ListSizeWidget(idProduct: widget.productId, onSizeSelected: _selectSize),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      width: 350.0,
                      height: 50.0,
                      margin: EdgeInsets.only(top: 5.0),
                      child: TextButton(
                        onPressed: () async {
                          // Check if both color and size are selected
                          if (_selectedColorId == -1 || _selectedSizeId == -1) {
                            _showAlertDialog('Vui lòng chọn cả MÀU và SIZE');
                          } else {

                            List<GetProductByIdModel.ProductVariants>? variants = await fetchProductVariant(widget.productId);
                            if (variants!.isNotEmpty) {
                              GetProductByIdModel.ProductVariants? filteredVariant = filterProductVariant(variants!, idColor, idSize);
                              if (filteredVariant != null) {
                                setState(() {
                                  idProductViant = filteredVariant.id!;
                                });
                                _showAlertDialog('Đã thêm sản phẩm vào giỏ hàng');
                                addCartQuantity(cartId, idProductViant);
                                ////
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                idNguoiDung = preferences.getInt('userId') ?? 0;
                                final response = await http.get(Uri.parse('http://10.0.2.2:5117/api/Cart/GetCartByUserId/$idNguoiDung'));

                                // debugPrint('ccc: ${idNguoiDung}');
                                try {
                                  if (response.statusCode == 200) {
                                    setState(() {
                                      cartData = GetCart.fromJson(jsonDecode(response.body));
                                    });
                                  } else {
                                    debugPrint('hhg: ${response.statusCode}');
                                  }
                                } catch (e) {
                                  debugPrint('ggh: ${response.statusCode}');
                                }
                                ////
                                // _showAlertDialog('${filteredVariant.id}');
                              } else {
                                print('No matching product variant found');
                              }
                            }
                            // addCartQuantity(cartId, idProductViant);
                            // _showAlertDialog('$idProductViant');
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.orange,
                          textStyle: const TextStyle(fontSize: 18.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          ),
                        ),
                        child: const Text('Thêm vào giỏ', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class ColorWidget extends StatefulWidget {
  ColorWidget({super.key, required this.colorProduct, required this.isSelected, required this.onTap, required this.urlImage});

  final String colorProduct;
  final bool isSelected;
  final VoidCallback onTap;

  String urlImage;

  State<ColorWidget> createState() => _ColorWidget();
}

class _ColorWidget extends State<ColorWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: widget.isSelected ? Colors.blue : Colors.grey, width: 3.0)
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: Colors.grey, width: 2.0),
                      color: hexColor(widget.colorProduct),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: widget.isSelected ? Icon(Icons.check_box, color: Colors.blue, size: 15.0,) : null,
            )
          ],
        ),
      ),
    );
  }
}

class ListColorWidget extends StatefulWidget {
  const ListColorWidget({super.key, required this.idProduct, required this.onColorSelected});

  final int idProduct;
  final Function(int, int) onColorSelected;

  State<ListColorWidget> createState() => _ListColorWidget();
}

class _ListColorWidget extends State<ListColorWidget> {
  late Future<List<GetOptionValueByIdModel.Result>> futureOptions;
  int _selectedIndexColor = -1; //No color selected initially

  @override
  void initState() {
    super.initState();
    futureOptions = getOptionColor(widget.idProduct);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetOptionValueByIdModel.Result>>(
        future: futureOptions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Snapshot error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data! == null) {
            return Center();
          } else {
            return Container(
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  GetOptionValueByIdModel.Result colorProduct = snapshot.data![index];
                  return ColorWidget(
                    colorProduct: colorProduct.value ?? '',
                    isSelected: _selectedIndexColor == index,
                    onTap: () {
                      setState(() {
                        _selectedIndexColor = index;
                        idColor = colorProduct.id!;
                        widget.onColorSelected(index, colorProduct.id ?? 0);
                      });
                      // widget.onColorSelected(index, colorProduct.id ?? 0, linkImage);
                    },
                    urlImage: linkImage,
                  );
                },
              ),
            );
          }
        }
    );
  }
}

class SizeWidget extends StatefulWidget {
  const SizeWidget({super.key, required this.sizeProduct, required this.isSelected, required this.onTap});

  final String sizeProduct;
  final bool isSelected;
  final VoidCallback onTap;

  State<SizeWidget> createState() => _SizeWidget();
}

class _SizeWidget extends State<SizeWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: widget.isSelected ? Colors.blue : Colors.grey, width: 3.0),
            shape: BoxShape.rectangle
        ),
        child: Stack(
          children: [
            Center(
              child: Expanded(child: Text(widget.sizeProduct, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black), overflow: TextOverflow.ellipsis,),),
            ),
            Align(
              alignment: Alignment.topRight,
              child: widget.isSelected ? Icon(Icons.check_box, color: Colors.blue, size: 15.0,) : null,
            )
          ],
        ),
      ),
    );
  }
}

class ListSizeWidget extends StatefulWidget {
  const ListSizeWidget({super.key, required this.idProduct, required this.onSizeSelected});

  final int idProduct;
  final Function(int, int) onSizeSelected;

  State<ListSizeWidget> createState() => _ListSizeWidget();
}

class _ListSizeWidget extends State<ListSizeWidget> {
  late Future<List<GetOptionValueByIdModel.Result>> futureOptions;
  int _selectedIndexSize = -1; //No size selected initially

  @override
  void initState() {
    super.initState();
    futureOptions = getOptionSize(widget.idProduct);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetOptionValueByIdModel.Result>>(
        future: futureOptions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Snapshot error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data! == null) {
            return Center();
          } else {
            return Container(
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  GetOptionValueByIdModel.Result sizeProduct = snapshot.data![index];
                  return SizeWidget(
                    sizeProduct: sizeProduct.value ?? '',
                    isSelected: _selectedIndexSize == index,
                    onTap: () {
                      setState(() {
                        _selectedIndexSize = index;
                        idSize = sizeProduct.id!;
                        widget.onSizeSelected(index, sizeProduct.id ?? 0);
                      });
                    },
                  );
                },
              ),
            );
          }
        }
    );
  }
}

Color hexColor(String code) {
  return Color(int.parse(code, radix: 16) + 0xFF000000);
}
