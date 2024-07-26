import 'package:clothing_store/api/api_service.dart';
import 'package:clothing_store/model/category.dart' as CategoryModel;
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidget();
}
class _CategoryWidget extends State<CategoryWidget> {
  late Future<List<CategoryModel.Result>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel.Result>>(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // debugPrint('Snapshot error: ${snapshot.error}');
          // return Center(child: Text('Lỗi'));
          return Center(child: Text('Snapshot error: ${snapshot.error}'));
        } else if(!snapshot.hasData || snapshot.data!.isEmpty) {
          debugPrint('No categories found');
          return const Center(child: Text('No Category found'));
        } else {
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 5.0,
              // crossAxisSpacing: 15.0,
              // childAspectRatio: 1,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {{
              CategoryModel.Result category = snapshot.data![index];
              return Column(
                children: [
                  Container(
                    width: 64.0,
                    height: 64.0,
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: Image.network(category.thumbnail ?? 'https://tse3.mm.bing.net/th?id=OIP.YEvB14OZEQZ2oALiFkJj-wHaE8&pid=Api&P=0&h=180', width: 64.0, height: 64.0, fit: BoxFit.contain),
                    ),
                    // child: Image.network(category.thumbnail ?? 'https://tse3.mm.bing.net/th?id=OIP.YEvB14OZEQZ2oALiFkJj-wHaE8&pid=Api&P=0&h=180'),
                  ),
                  Expanded(child: Text(category.name ?? 'Error', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),)
                ],
              );
            }},
          );
        }
      },
    );
  }
}
