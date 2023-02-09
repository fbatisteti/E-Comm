import 'package:ecomm/common/widgets/custom_button.dart';
import 'package:ecomm/common/widgets/custom_textfield.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:ecomm/constants/utils.dart';
import 'package:ecomm/features/address/services/addres_services.dart';
import 'package:ecomm/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount
  }) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  //List<PaymentItem> paymentItems = [];
  String addressToBeUsed = '';
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    // paymentItems.add(
    //   PaymentItem(
    //     amount: widget.totalAmount,
    //     label: 'Total Amount',
    //     status: PaymentItemStatus.final_price,
    //   )
    // );
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  //void onApplePayResult(res) {}
  //void onGooglePayResult(res) {}

  void onGenericPayResult() {
    if (Provider.of<UserProvider>(context, listen: false).user.address.isEmpty) {
      addressServices.SaveUserAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totalAmount));
  }

  void payPressed(String addresFromProvider) {
    addressToBeUsed = "";
    
    bool isForm = flatBuildingController.text.isNotEmpty
    || areaController.text.isNotEmpty
    || pincodeController.text.isNotEmpty
    || cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed = '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
        onGenericPayResult();
      } else {
        showSnackBar(context, 'Please, fill all address fields');
        throw Exception('Please, fill all address fields');
      }
    } else if (addresFromProvider.isNotEmpty) {
      addressToBeUsed = addresFromProvider;
      onGenericPayResult();
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container( // gambiarra para colocar um gradiente
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if(address.isNotEmpty) Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(address, style: const TextStyle(fontSize: 18),),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text('OR', style: TextStyle(fontSize: 18),),
                  const SizedBox(height: 20,),
                ],
              ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: flatBuildingController,
                      hintText: 'Flat, House Number, Building',
                    ),
                    const SizedBox(height: 10,),
                    CustomTextfield(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10,),
                    CustomTextfield(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10,),
                    CustomTextfield(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
              CustomButton(
                text: "MockPay",
                onTap: () => payPressed(address),
                color: Colors.yellow,
              ),
              // ApplePayButton(
              //   onPressed: () => payPressed(address),
              //   width: double.infinity,
              //   height: 50,
              //   margin: const EdgeInsets.only(top: 15),
              //   style: ApplePayButtonStyle.whiteOutline,
              //   type: ApplePayButtonType.buy,
              //   paymentConfiguration: 'applepay.json',
              //   onPaymentResult: onApplePayResult,
              //   paymentItems: paymentItems
              // ),
              // const SizedBox(height: 10,),
              // GooglePayButton(
              //   onPressed: () => payPressed(address),
              //   height: 50,
              //   margin: const EdgeInsets.only(top: 15),
              //   type: GooglePayButtonType.buy,
              //   //paymentConfiguration: 'gpay.json',
              //   onPaymentResult: onGooglePayResult,
              //   paymentItems: paymentItems,
              //   loadingIndicator: const Center(child: CircularProgressIndicator(),),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}