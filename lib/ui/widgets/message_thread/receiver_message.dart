import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cham_app/colors.dart';
import 'package:cham_app/models/local_message.dart';
import 'package:cham_app/theme.dart';

class ReceiverMessage extends StatelessWidget {
  final String _url;
  final LocalMessage _message;
  const ReceiverMessage(this._message, this._url);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topLeft,
      widthFactor: 0.75,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: isLightTheme(context) ? kBubbleLight : kBubbleDark,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  position: DecorationPosition.background,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    child: Text(
                      _message.message.contents.trim(),
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(height: 1.2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, left: 12.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    // child: Text(
                    //   DateFormat('h:mm a').format(_message.message.timestamp),
                    //   style: Theme.of(context).textTheme.overline.copyWith(
                    //       color: isLightTheme(context)
                    //           ? Colors.black54
                    //           : Colors.white70),
                    // ),
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: isLightTheme(context)
                ? Colors.blueGrey[800]
                : Colors.blueGrey[200],
            radius: 18,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Icon(Icons.person, size: 35.0, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
