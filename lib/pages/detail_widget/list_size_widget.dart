import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/getOptionValueById.dart' as GetOptionValueByIdModel;
import 'package:clothing_store/pages/detail_widget/detail_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'size_widget.dart';

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
