import 'package:amazon_clone_nodejs/common/widgets/loader.dart';
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
    getCartUser();
  }

  void getFecthAllUser() async {
    _userlist = await adminServices.getAllUsers(context);
    setState(() {});
  }

  void getCartUser() {}
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
            body: ListView.builder(
                itemCount: _userlist!.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(3),
                itemBuilder: (context, index) {
                  final userdata = _userlist![index];
                  return Card(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Id:  ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              Text(userdata.id),
                              const SizedBox(
                                width: 30,
                              ),
                              PopupMenuButton(onSelected: (value) {
                                if (value == 'edit') {
                                } else if (value == 'delete') {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 2,
                                                    right: 2,
                                                    top: 20,
                                                    bottom: 10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            title: const Row(
                                              children: [
                                                Text('Do you have delete user?')
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
                                                      color: Colors.blue),
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
                                                      color: Colors.blue),
                                                ),
                                              )
                                            ],
                                          ));
                                }
                              }, itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                    value: 'see cart',
                                    child: Text('Cart'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ];
                              }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('Name:  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              Text(
                                userdata.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('Name:  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              Text(userdata.email),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('Pass:  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              Text(userdata.password),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('Address:  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              Text(userdata.address),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text('Type:  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              Text(userdata.type),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ]),
                  );
                }),
          );
  }
}
