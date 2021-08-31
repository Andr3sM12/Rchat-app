import 'package:flutter/material.dart';
import 'package:cham_app/ui/widgets/home/online_indicator.dart';

class ProfileImage extends StatelessWidget {
  final bool online;

  const ProfileImage({this.online = false});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.blueGrey[300],
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(126.0),
            child: Icon(Icons.person, size: 40.0, color: Colors.black87),
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: online ? OnlineIndicator() : Container(),
          // )
        ],
      ),
    );
  }
}
