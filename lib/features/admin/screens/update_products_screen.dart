import 'dart:io';
import 'package:amazon_clone_nodejs/common/widgets/custom_button.dart';
import 'package:amazon_clone_nodejs/constants/global_variables.dart';
import 'package:amazon_clone_nodejs/constants/utils.dart';
import 'package:amazon_clone_nodejs/features/admin/services/admin_services.dart';
import 'package:amazon_clone_nodejs/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UpdateProductScreen extends StatefulWidget {
  static const String routeName = '/update-product';
  final Product product;
  const UpdateProductScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<UpdateProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<UpdateProductScreen> {
  String productName = '';
  String description = '';
  String price = '';
  String quantity = '';
  final AdminServices adminServices = AdminServices();

  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  // ignore: non_constant_identifier_names
  void UpdatesellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.updateProduct(
          context: context,
          id: widget.product.id,
          name: productName == '' ? widget.product.name : productName,
          description:
              description == '' ? widget.product.description : description,
          price: price == '' ? widget.product.price : 0,
          quantity: quantity == '' ? widget.product.quantity : 0,
          category: category,
          images: images);
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            'Update ${widget.product.name}',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                TextFormField(
                  onChanged: (val) => productName = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  initialValue: widget.product.name,
                  decoration: const InputDecoration(
                      hintText: 'Product Name',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      ))),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (val) => description = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  initialValue: widget.product.description,
                  decoration: const InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      ))),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (val) => price = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  initialValue: '${widget.product.price}',
                  decoration: const InputDecoration(
                      hintText: 'Price',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      ))),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (val) => quantity = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  initialValue: '${widget.product.quantity}',
                  decoration: const InputDecoration(
                      hintText: 'Quantity',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      )),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black38,
                      ))),
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                CustomButton(
                  color: Colors.orange,
                  text: 'Update sell',
                  onTap: UpdatesellProduct,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
