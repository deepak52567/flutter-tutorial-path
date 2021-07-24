import 'package:analog_audio/models/enums.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final ButtonStyleType type;

  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.type = ButtonStyleType.Stroked,
  }) : super(key: key);

  Widget get _coreIconButton {
    return Center(
      child: Container(
        child: Icon(
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
        color: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
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
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: Colors.grey.shade300,
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
