import 'package:charts_flutter_new/flutter.dart';
import 'package:ecomm/features/admin/models/sales.dart';
import 'package:flutter/material.dart';

class CategoryProductChat extends StatelessWidget {
  final List<Series<Sales, String>> seriesList;
  const CategoryProductChat({
    Key? key,
    required this.seriesList
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BarChart(
      seriesList,
      animate: true,
    );
  }
}