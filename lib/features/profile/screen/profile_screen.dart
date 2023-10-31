import 'package:amazon_clone_nodejs/common/widgets/loader.dart';
import 'package:amazon_clone_nodejs/constants/global_variables.dart';
import 'package:amazon_clone_nodejs/features/chat/screen/chat_screen.dart';
import 'package:amazon_clone_nodejs/features/profile/services/profile_services.dart';
import 'package:amazon_clone_nodejs/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileServices profileServices = ProfileServices();
  String name = "";
  String email = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text('Profile Me'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ChatScreen.routeName);
                },
                icon: const Icon(Icons.chat))
          ],
        ),
      ),
      body: userProvider == null
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Name
                  TextFormField(
                    onChanged: (val) =>
                        name = val ?? '', // vadicator kiểm tra dữ liệu nhập
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    initialValue: userProvider.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(
                        Icons.inbox_outlined,
                        color: Colors.blue,
                      ),
                      hintText: 'eg. Qsdvsal  ',
                      label: const Text('Name'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Email
                  TextFormField(
                    onSaved: (val) =>
                        '' ?? '', // vadicator kiểm tra dữ liệu nhập
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    initialValue: userProvider.email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                      hintText: 'eg. Qsdal@gmail.com  ',
                      label: const Text('Email'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Pass
                  TextFormField(
                    onSaved: (val) =>
                        '' ?? '', // vadicator kiểm tra dữ liệu nhập
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    initialValue: userProvider.password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.blue,
                      ),
                      hintText: 'eg. **** ',
                      label: const Text('Password'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Address
                  TextFormField(
                    onSaved: (val) =>
                        '' ?? '', // vadicator kiểm tra dữ liệu nhập
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    initialValue: userProvider.address,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(
                        Icons.add_circle_outline_sharp,
                        color: Colors.blue,
                      ),
                      hintText: 'eg. tan phu ',
                      label: const Text('Address'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
