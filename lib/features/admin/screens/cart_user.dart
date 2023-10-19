import 'package:amazon_clone_nodejs/models/user.dart';
import 'package:flutter/material.dart';

class CartUser extends StatefulWidget {
  static const String routeName = '/cart-user';
  const CartUser({super.key, required this.user});
  final User user;

  @override
  State<CartUser> createState() => _CartUserState();
}

class _CartUserState extends State<CartUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart User'),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.user.cart.length,
            itemBuilder: (context, cartIndex) {
              final cartItem = widget.user.cart[cartIndex];
              final quantity = cartItem['quantity'];
              final product = cartItem['product'];
              return Card(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Pro Name: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(product['name']),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Category: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(product['category']),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Quantity: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('$quantity'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Money: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('${quantity * product['price']}'),
                        ],
                      ),
                    ]),
              );
            },
          ),
        ));
  }
}
