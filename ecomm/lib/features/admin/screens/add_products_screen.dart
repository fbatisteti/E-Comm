import 'package:dotted_border/dotted_border.dart';
import 'package:ecomm/common/widgets/custom_button.dart';
import 'package:ecomm/common/widgets/custom_textfield.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AddProductsScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductsScreen({ Key? key }) : super(key: key);

  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productQuantityController = TextEditingController();

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ]; // igual às GlobalVariables

  String category = 'Mobiles';

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    productDescriptionController.dispose();
    productPriceController.dispose();
    productQuantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container( // gambiarra para colocar um gradiente
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
          title: const Text('Add Product', style: TextStyle(color: Colors.black),)
        ),
      ),

      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.folder_open, size: 40,),
                        const SizedBox(height: 15,),
                        Text(
                          'Select product images',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade400
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          
                const SizedBox(height: 30,),
          
                CustomTextfield(controller: productNameController, hintText: 'Product name'),
                const SizedBox(height: 10,),
                CustomTextfield(controller: productDescriptionController, hintText: 'Description', maxLines: 7,),
                const SizedBox(height: 10,),
                CustomTextfield(controller: productPriceController, hintText: 'Product price'),
                const SizedBox(height: 10,),
                CustomTextfield(controller: productQuantityController, hintText: 'Product quantity'),
                const SizedBox(height: 10,),

                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10,),

                CustomButton(text: 'Sell', onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}