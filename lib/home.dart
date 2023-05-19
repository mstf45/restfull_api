import 'package:flutter/material.dart';
import 'package:restfull_api/model/user_model.dart';
import 'package:restfull_api/service/user_service.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  final UserService _service = UserService();
  List<UsersModelData?> users = [];

  bool? isLoading;
  @override
  void initState() {
    super.initState();
    _service.fetchUsers().then((value) {
      if (value != null && value.data != null) {
        setState(() {
          users = value.data!;
          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İnternetten Veri Çekme İşlemleri'),
      ),
      body: isLoading == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isLoading == true
              ? ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        '${users[index]!.firstName}${users[index]!.lastName}',
                      ),
                      subtitle: Text('${users[index]!.email}'),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(users[index]!.avatar!),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('Bir Sorun Oluştu'),
                ),
    );
  }
}
