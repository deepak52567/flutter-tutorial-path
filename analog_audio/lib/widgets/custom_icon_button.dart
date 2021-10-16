import 'package:analog_audio/models/enums.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final ButtonStyleType type;
  final bool lightShade;

  const CustomIconButton(
      {Key? key,
      required this.onPressed,
      required this.icon,
      this.type = ButtonStyleType.Stroked,
      this.lightShade = false})
      : super(key: key);

  Widget get _coreIconButton {
    return Center(
      child: Container(
        child: lightShade ? Icon(
          icon,
          size: 25,
          color: Colors.grey.shade900,
        ) : Icon(
          icon,
          size: 25,
        ),
        width: 50,
        height: 50,
      ),
    );
  }

  Widget get _filledButton {
    return Ink(
      width: 50,
      height: 50,
      decoration: ShapeDecoration(
        color: lightShade ? Colors.white : Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: _coreIconButton,
      ),
    );
  }

  Widget get _strokedButton {
    return Ink(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
          style: BorderStyle.solid,
          width: 1.0,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: _coreIconButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).splashColor,
      splashFactory: Theme.of(context).splashFactory,
      borderRadius: BorderRadius.circular(8),
      onTap: () => onPressed(),
      child: type == ButtonStyleType.Filled ? _filledButton : _strokedButton,
    );
  }
}
