import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/getOptionValueById.dart' as GetOptionValueByIdModel;
import 'package:clothing_store/pages/detail_widget/color_widget.dart';
import 'package:clothing_store/pages/detail_widget/detail_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
