import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePage();
}
class _FavoritePage extends State<FavoritePage>
{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120.0,
          decoration: BoxDecoration(
            color: Color(0xFF486EFF),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 15.0,),
              SizedBox(
                width: 48.0,
                height: 48.0,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back, color: Colors.white, size: 48.0,),
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)
                  ),
                ),
              ),
              const SizedBox(width: 120.0,),
              Text('Cart', style: TextStyle(color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ],
    );
  }
}