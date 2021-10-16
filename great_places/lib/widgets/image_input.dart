import 'dart:io';

import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          height: 100,
          width: 100,
          child: _storedImage != null
              ? Image.file(
            _storedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
              : Text('No Image Taken', textAlign: TextAlign.center,),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    TextStyle(color: Theme
                        .of(context)
                        .colorScheme
                        .primary))),
          ),
        )
      ],
    );
  }
}
