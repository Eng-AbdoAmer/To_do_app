import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class BodyView extends StatefulWidget {
  final MYnote;
  final index;
  const BodyView({Key? key, this.MYnote, this.index}) : super(key: key);

  @override
  State<BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<BodyView> {

  bool Isfavo = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.MYnote[widget.index].noteTitle!,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          subtitle: Row(
            children: [
              Text(
                widget.MYnote[widget.index].noteDate!,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                widget.MYnote[widget.index].noteTime!,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Isfavo ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
            onPressed: () {
              setState(() {
                Isfavo = !Isfavo;

              });
            },
          ),
        ),
        const Divider(color: Colors.pink, thickness: 1),
      ],
    );
  }
}
