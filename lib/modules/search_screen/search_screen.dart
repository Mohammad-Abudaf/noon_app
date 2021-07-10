import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/componants/componants.dart';

class SearchSceen extends StatelessWidget{
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              child: defaultFormField(label: 'search', controller: searchController, prefix: Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}