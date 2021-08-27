import 'package:flutter/material.dart';

class SingleInfoRow extends StatelessWidget {
  final String field;
  final String value;

  SingleInfoRow(this.field, this.value);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.text = value;
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[300],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            field,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 22),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
