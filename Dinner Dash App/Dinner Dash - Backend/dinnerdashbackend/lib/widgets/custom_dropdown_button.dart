import 'package:dinnerdashbackend/models/category_model.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final Function(String?)? onChanged;

  const CustomDropdownButton({
    Key? key,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            'Category',
            style: Theme.of(context)
                .textTheme
                .headlineSmall,
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: SizedBox(
            height: 45, 
            child: DropdownButtonFormField( 
              iconSize: 20, 
              onChanged: onChanged,
              items: items
                .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                )).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
