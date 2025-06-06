import 'package:flutter/material.dart';
import 'package:impostor/utils/colors.dart';

class PlayersList extends StatelessWidget {
  final List<String> names;

  const PlayersList({Key? key, required this.names}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(12),
      itemCount: names.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 153, 0).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            names[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }

}