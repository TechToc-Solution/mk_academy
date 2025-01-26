import 'package:flutter/material.dart';

class CustomLeaderboardShow extends StatelessWidget {
  const CustomLeaderboardShow(
      {super.key,
      required this.index,
      required this.data,
      required this.is_you});
  final int index;
  final Map data;
  final bool is_you;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: is_you,
      selectedTileColor: const Color.fromARGB(55, 0, 0, 0),
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        data["name"],
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "المستوى: " + data["level"],
        style: TextStyle(color: Colors.white),
      ),
      trailing: index == 0
          ? Icon(
              Icons.looks_one_rounded,
              color: Colors.white,
            )
          : index == 1
              ? Icon(
                  Icons.looks_two_rounded,
                  color: Colors.white,
                )
              : index == 2
                  ? Icon(
                      Icons.looks_3_rounded,
                      color: Colors.white,
                    )
                  : Text(
                      textAlign: TextAlign.center,
                      (index + 1).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
    );
  }
}
