import 'package:dinnerdashbackend/config/responsive.dart';
import 'package:dinnerdashbackend/models/opening_hours_model.dart';
import 'package:flutter/material.dart';

class OpeningHoursSettings extends StatelessWidget {

  //final OpeningHoursSettings openingHours; original
  final OpeningHours openingHours;
  final Function(bool?)? onCheckboxChanged;///
  final Function (String, String)? onSliderChanged;

  double _timeStringToDouble(String time) {
    List<String> parts = time.split(':');
    return double.parse(parts[0]) + (double.parse(parts[1]) / 60.0);
  }

  String _doubleToTimeString(double time) {
    int hours = time.toInt();
    int minutes = ((time - hours) * 60).toInt();
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  const OpeningHoursSettings({
    Key? key,
    required this.openingHours,
    required this.onCheckboxChanged,
    required this.onSliderChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = Responsive.isMobile(context) ? 100 : 50;
    EdgeInsets padding = Responsive.isMobile(context)
      ?  const EdgeInsets.all(10)
      : const EdgeInsets.all(20);


    return Container(
      height: height,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: padding,
      color: Theme.of(context).colorScheme.background,
      child:
      Responsive.isMobile(context) ?
        Column(children: [
        Row(
          children: [
            _buildCheckbox(context),
             const SizedBox(width: 10),
        _buildText(context)
          ],
        ),//checkbox for days of the week
        const SizedBox(height: 10),
        Expanded(
          child: _buildSlider(context),
        ),//slider for time
       
      ],
      )
      : Row(
        children: [
          _buildCheckbox(context),//checkbox for days of the week
          const SizedBox(width: 10),
          Expanded(
            child: _buildSlider(context),
          ),//slider for time
          const SizedBox(width: 10),
          _buildText(context)
        
      ],
      ),
    );
  }

  SizedBox _buildText(BuildContext context) {
    return SizedBox(width: 125, child: openingHours.isOpen ? Text('Open ${openingHours.openAt} to ${openingHours.closeAt}',
      style: Theme.of(context).textTheme.headlineSmall,
      ) : Text(
        'Closed ${openingHours.day}',
        style: Theme.of(context).textTheme.headlineSmall
      ),);
  }

  Row _buildCheckbox(BuildContext context) {
    return Row(
        children: [
          /*Checkbox(
            value: openingHours.isOpen, 
          onChanged: onCheckboxChanged,
          activeColor: Theme.of(context).colorScheme.primary,
          fillColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.primary),
          ),*/

          Checkbox(
            value: openingHours.isOpen,
            onChanged: onCheckboxChanged != null ? (bool? newValue) => onCheckboxChanged!(newValue ?? false) : null,
            activeColor: Theme.of(context).colorScheme.primary,
            fillColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
          ),

          const SizedBox(width: 10),
          SizedBox(
            width: 100, 
            child: Text(
              openingHours.day, 
              style: Theme.of(context).textTheme.headlineSmall
            ),
          ),

        ],
      );
  }

 /* RangeSlider _buildSlider(BuildContext context) { original has errors 
    return RangeSlider(
      divisions: 24,
      values: RangeValues(
          openingHours.openAt, 
          openingHours.closeAt),
        min: 0,
        max: 24,
        onChanged: onSliderChanged,
    );
  }
}*/

RangeSlider _buildSlider(BuildContext context) {
    double openAt = _timeStringToDouble(openingHours.openAt);
    double closeAt = _timeStringToDouble(openingHours.closeAt);

    return RangeSlider(
      divisions: 24 * 4, // Divisions for every 15 minutes
      values: RangeValues(openAt, closeAt),
      min: 0,
      max: 24,
      onChanged: (RangeValues values) {
        String newOpenAt = _doubleToTimeString(values.start);
        String newCloseAt = _doubleToTimeString(values.end);
        if (onSliderChanged != null) {
          onSliderChanged!(newOpenAt, newCloseAt);
        }
      },
    );
  }
}
