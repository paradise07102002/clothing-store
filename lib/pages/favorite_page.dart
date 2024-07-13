import 'package:flutter/material.dart';

import '../provider/app_localizations.dart';

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
        const SizedBox(height: 45.0,),
        Expanded(
          child: Text(
            AppLocalizations.of(context)?.translate('favorite') ?? '',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 500.0,
          height: 2.0,
          color: Colors.black,
        )
      ],
    );
  }
}