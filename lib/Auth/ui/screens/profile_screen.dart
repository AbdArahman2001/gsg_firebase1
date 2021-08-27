import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/models/user_model.dart';
import 'package:gsg_firebase1/Auth/providers/auth_provider.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/user_info_card.dart';
import 'package:gsg_firebase1/statics/statics.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false)
        .getCurrentUserFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .fillControllers();
                Navigator.of(context)
                    .pushNamed(Statics.statics.editProfileRoute);
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () =>
                  Provider.of<AuthProvider>(context, listen: false).signOut(),
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Container(
        child:
            Provider.of<AuthProvider>(context).currentUserFromFirestore != null
                ? UserInfoCard(
                    Provider.of<AuthProvider>(context).currentUserFromFirestore)
                : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
