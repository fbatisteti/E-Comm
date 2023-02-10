import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:ecomm/common/widgets/loader.dart';
import 'package:ecomm/features/admin/models/sales.dart';
import 'package:ecomm/features/admin/services/admin_services.dart';
import 'package:ecomm/features/admin/widget/category_product_chat.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({ Key? key }) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  double? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (earnings == null || totalSales == null)
    ? const Loader()
    : Column(
        children: [
          Text(
            '\$$totalSales',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 250,
            child: CategoryProductChat(seriesList: [
              charts.Series(
                id: 'Sales',
                data: earnings!,
                domainFn: (Sales sales, _) => sales.label,
                measureFn: (Sales sales, _) => sales.earnings,
              ),
            ]),
          )
        ],
      );
  }
}