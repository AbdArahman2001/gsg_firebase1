import 'package:flutter/material.dart';
import 'package:gsg_firebase1/Auth/models/user_model.dart';
import 'package:gsg_firebase1/Auth/providers/auth_provider.dart';
import 'package:gsg_firebase1/Auth/ui/widgets/user_info_card.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provider.of<AuthProvider>(context).currentUser != null
          ? UserInfoCard(Provider.of<AuthProvider>(context).currentUser)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
