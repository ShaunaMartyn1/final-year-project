import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final int maxLines;
  final String title;
  final bool hasTitle;
  final String initialValue;
  final Function(String)? onChanged;
  final Function(bool)? onFocusChanged;

  const CustomTextFormField({
    Key? key,
    required this.maxLines,
    required this.title,
    required this.hasTitle,
    required this.initialValue,
    required this.onChanged,
    this.onFocusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          hasTitle //check if title is = true
            ? SizedBox(
              width: 75,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            )
            : const SizedBox(),
          Expanded(
            child: Focus(
              child: TextFormField(
                maxLines: maxLines,
                initialValue: initialValue,
                onChanged: onChanged,
                onEditingComplete: () {
                  print('Editing Complete/Done');
                },
                decoration: InputDecoration(
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .primary),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white,
                      ),
                  ),
                ),
              ),
              onFocusChange: onFocusChanged ?? (hasFocus) {},//only update the value of isUpdate boolean
            ),
          ),
        ],
      ),
    );
  }
}
