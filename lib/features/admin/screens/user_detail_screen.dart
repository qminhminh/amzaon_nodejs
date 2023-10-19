import 'package:amazon_clone_nodejs/common/widgets/loader.dart';
import 'package:amazon_clone_nodejs/features/admin/screens/cart_user.dart';
import 'package:amazon_clone_nodejs/features/admin/services/admin_services.dart';
import 'package:amazon_clone_nodejs/models/user.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final AdminServices adminServices = AdminServices();
  List<User>? _userlist = [];

  @override
  void initState() {
    super.initState();
    getFecthAllUser();
  }

  void getFecthAllUser() async {
    _userlist = await adminServices.getAllUsers(context);
    setState(() {});
  }

  void navigatorUserCart(User user) {
    Navigator.pushNamed(context, CartUser.routeName, arguments: user);
  }

  void deleteUser(User user, int index) {
    adminServices.deleteUser(
        context: context,
        user: user,
        onSuccess: () {
          _userlist!.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return _userlist == null
        ? const Loader()
        : Scaffold(
            body: _userlist == null
                ? const Loader()
                : Scaffold(
                    body: ListView.builder(
                      itemCount: _userlist!.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(3),
                      itemBuilder: (context, index) {
                        final userdata = _userlist![index];
                        return Card(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Id:  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(userdata.id),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        navigatorUserCart(userdata);
                                        // Handle edit
                                      } else if (value == 'delete') {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.only(
                                              left: 2,
                                              right: 2,
                                              top: 20,
                                              bottom: 10,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            title: const Row(
                                              children: [
                                                Text(
                                                    'Do you want to delete this user?'),
                                              ],
                                            ),
                                            actions: [
                                              MaterialButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Undo',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                              MaterialButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  deleteUser(userdata, index);
                                                },
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    itemBuilder: (context) {
                                      return [
                                        const PopupMenuItem(
                                          value: 'edit',
                                          child: Text('Cart'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',
                                          child: Text('Delete'),
                                        ),
                                      ];
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Name:  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    userdata.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Email:  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(userdata.email),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Password:  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(userdata.password),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Address:  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(userdata.address),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Type:  ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(userdata.type),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          );
  }
}
