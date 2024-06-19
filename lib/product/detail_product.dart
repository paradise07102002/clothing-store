import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class DetailProductPage extends StatefulWidget {
  const DetailProductPage({super.key});

  @override
  State<DetailProductPage> createState() => _DetailProductPage();
}
class _DetailProductPage extends State<DetailProductPage> {
  List<ColorProduct> colorProducts = [
    ColorProduct(color: 'FFFFFF', name: 'Trắng'),
    ColorProduct(color: '000000', name: 'Đen'),
    ColorProduct(color: 'FF0000', name: 'Đỏ'),
    ColorProduct(color: '486EFF', name: 'Xanh dương'),
    ColorProduct(color: 'F4C009', name: 'Vàng'),
  ];
  List<SizeProduct> sizeProducts = [
    SizeProduct(size: 'M'),
    SizeProduct(size: 'L'),
    SizeProduct(size: 'XL'),
    SizeProduct(size: 'XXL'),
  ];
  bool _isFavorite = false;
  String moTa = 'sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffsssssssssssssssssssssssssssssssssssssssssss';
  void _tonggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 35.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 15.0,),
                SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back, color: Colors.black, size: 48.0,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero)
                    ),
                  ),
                ),
                const SizedBox(width: 120.0,),
                Text('Cart', style: TextStyle(color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),)
              ],
            ),
            SizedBox(height: 15.0,),
            Container(width: 350.0, height: 1.0, color: Colors.black,),
            SizedBox(height: 15.0,),
            Container(
              width: 350.0,
              height: 400.0,
              decoration: BoxDecoration(
                color: Color(0xFFDEDEDD),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                children: [
                  SizedBox(height: 15.0,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white
                    ),
                    child: Image.asset('assets/products/product4.png', width: 250.0, height: 300.0,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              width: 350.0,
              child: Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      Text('Tên sản phẩm', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black), overflow: TextOverflow.ellipsis,),
                      Text('100.000.000 đ', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black), overflow: TextOverflow.ellipsis,),
                    ],
                  ),),
                  SizedBox(width: 100.0,),
                  IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: _tonggleFavorite,
                    iconSize: 64.0,
                  ),
                ],
              ),
            ),
            Container(
              width: 350.0,
              margin: EdgeInsets.only(left: 10.0),
              child: Text('Màu', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              width: 350.0,
              height: 64.0,
              // padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(1.0)),
              //   border: Border.all(color: Colors.grey, width: 1.0)
              // ),
              child: ListColorWidget(colorProducts: colorProducts),
            ),
            Container(
              width: 350.0,
              margin: EdgeInsets.only(left: 10.0),
              child: Text('Size', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            Container(
              margin: EdgeInsets.only(left: 35.0),
              // width: double.infinity,
              height: 64.0,
              child: ListSizeWidget(sizeProducts: sizeProducts),
            ),
            Container(
              width: 350.0,
              margin: EdgeInsets.only(left: 10.0),
              child: Text('Mô tả', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            Container(
              width: 350.0,
              height: 100.0,
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(1.0)),
                border: Border.all(color: Colors.grey, width: 1.0)
              ),
              margin: EdgeInsets.only(left: 10.0),
              child: SingleChildScrollView(
                child: Text(moTa, style: TextStyle(fontSize: 16.0, color: Colors.grey),),
              ),
            ),
            Container(
              width: 350.0,
              margin: EdgeInsets.only(left: 10.0),
              child: Text('Mô tả', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            Container(
              width: 350.0,
              margin: EdgeInsets.only(left: 10.0),
              child: Text('Mô tả', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            Container(
              width: 350.0,
              margin: EdgeInsets.only(left: 10.0),
              child: Text('Mô tả', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}

//UI FOR COLOR
class ColorWidget extends StatefulWidget {
  const ColorWidget({super.key, required this.colorProduct, required this.isSelected, required this.onTap});

  final ColorProduct colorProduct;
  final bool isSelected;
  final VoidCallback onTap;

  State<ColorWidget> createState() => _ColorWidget();
}
class _ColorWidget extends State<ColorWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
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
                      color: hexColor(widget.colorProduct.color),
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

//UI FOR LIST COLOR
class ListColorWidget extends StatefulWidget {
  const ListColorWidget({super.key, required this.colorProducts});

  final List<ColorProduct> colorProducts;
  State<ListColorWidget> createState() => _ListColorWidget();
}
class _ListColorWidget extends State<ListColorWidget> {
  int _selectedIndex = -1; //No color selected initially
  void _selectColor(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10.0,
        ),
        itemCount: widget.colorProducts.length,
        itemBuilder: (context, index) {
          final colorProduct = widget.colorProducts[index];
          return ColorWidget(colorProduct: colorProduct, isSelected: _selectedIndex == index, onTap: () => _selectColor(index),
          );
        },
      ),
    );
  }
}
//UI SIZE LIST
class SizeWidget extends StatefulWidget {
  const SizeWidget({super.key, required this.sizeProduct, required this.isSelected, required this.onTap});

  final SizeProduct sizeProduct;
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
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: widget.isSelected ? Colors.blue : Colors.grey, width: 3.0),
            shape: BoxShape.rectangle
        ),
        child: Stack(
          children: [
            Center(
              child: Expanded(child: Text(widget.sizeProduct.size, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black), overflow: TextOverflow.ellipsis,),),
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
//UI LIST SIZE
class ListSizeWidget extends StatefulWidget {
  const ListSizeWidget({super.key, required this.sizeProducts});

  final List<SizeProduct> sizeProducts;

  State<ListSizeWidget> createState() => _ListSizeWidget();

}
class _ListSizeWidget extends State<ListSizeWidget> {
  int _selectedIndex = -1; //No color selected initially
  void _selectSize(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10.0,
        ),
        itemCount: widget.sizeProducts.length,
        itemBuilder: (context, index) {
          final sizeProduct = widget.sizeProducts[index];
          return SizeWidget(sizeProduct: sizeProduct, isSelected: _selectedIndex == index, onTap: () => _selectSize(index));
        },
      ),
    );
  }
}

class ColorProduct {
  final String color;
  final String name;

  ColorProduct({required this.color, required this.name});
}
class SizeProduct {
  final String size;

  SizeProduct({required this.size});
}
Color hexColor (String code) {
  // if (code.length != 6 && code.length != 8) {
  //   print('Invalid color format: $code');
  //   return Colors.transparent;
  // }
  return Color(int.parse(code, radix: 16) + 0xFF000000);
}
class Description {
  final String moTa;

  Description({required this.moTa});
}