import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
        builder: (ctx, authProvider, _) => Scaffold(
              appBar: AppBar(
                title: Text('Edit profile'),
                actions: [
                  IconButton(
                      onPressed: () async {
                        await authProvider.editProfile();
                        Navigator.of(ctx).pop();
                      },
                      icon: Icon(Icons.done)),
                ],
              ),
              body: authProvider.isUpdatingProfile
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => authProvider.pickImage(),
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: authProvider.pickedImage == null
                                  ? NetworkImage(authProvider
                                      .currentUserFromFirestore.imageUrl)
                                  : FileImage(authProvider.pickedImage),
                            ),
                          ),
                          SingleInfoEdit(
                              'First Name', authProvider.fNameController),
                          SingleInfoEdit(
                              'Last Name', authProvider.lNameController),
                          SingleInfoEdit(
                              'Country', authProvider.countryController),
                          SingleInfoEdit('City', authProvider.cityController),
                        ],
                      ),
                    ),
            ));
  }
}

class SingleInfoEdit extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  SingleInfoEdit(this.title, this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title + ':',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 5,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
