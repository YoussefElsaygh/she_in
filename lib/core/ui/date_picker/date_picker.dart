import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color calendarHighlightedColor;
  final Color calendarTopBackgroundColor;
  final DateTime calendarFirstYear;
  final DateTime calendarLastYear;
  final Function dateRangeSelected;
  final String firstDate;
  final String lastDate;

  const DatePicker(
      {Key key,
      this.backgroundColor,
      this.borderColor,
      this.calendarHighlightedColor,
      this.calendarTopBackgroundColor,
      @required this.calendarLastYear,
      @required this.dateRangeSelected,
      @required this.calendarFirstYear,
      this.textColor,
      this.firstDate,
      this.lastDate})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();
  DateTime firstDate = new DateTime.now();
  DateTime lastDate = new DateTime.now();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: widget.calendarHighlightedColor,
        backgroundColor: widget.calendarTopBackgroundColor,
        primaryColor: widget.calendarTopBackgroundColor,
      ),
      child: new Builder(
        builder: (context) => new FlatButton(
          textColor: widget.textColor, //Colors.deepOrangeAccent
          color: widget.backgroundColor, //Colors.deepOrangeAccent,
          shape: new RoundedRectangleBorder(
              side: BorderSide(
                  color: widget.borderColor,
                  style: BorderStyle.solid,
                  width: 0.4),
              borderRadius: new BorderRadius.circular(35.0)),
          onPressed: () async {
            final List<DateTime> picked = await DateRagePicker.showDatePicker(
                context: context,
                initialFirstDate: firstDate,
                initialLastDate: lastDate,
//                  .add(new Duration(days: 7)),
                firstDate: widget.calendarFirstYear, //new DateTime(2020)
                lastDate: widget.calendarLastYear //new DateTime(2021)
                );
            if (picked != null && picked.length == 2) {
              widget.dateRangeSelected(picked);
            }
          },
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            alignment: Alignment.center,
            // constraints:
            //     BoxConstraints(minWidth: 0.2 * width, maxWidth: 0.45 * width),
            child: Row(
              children: <Widget>[
                _changeDateRange(widget.firstDate, widget.lastDate),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6,
                  ),
                ),
                // Icon(Icons.calendar_today,color: Color(Palette.SWIFTY_YELLOW_COLOR_0xFFFDB73D),)
                SvgPicture.asset("assets/images/calendar.svg")
              ],
            ),
          ),
        ),
      ),
    );
  }

  _changeDateRange(String first, String last) {
    return new Text(
      first.length == 0
          ? '${DateFormat.MMMd().format(firstDate)} - ${DateFormat.yMMMd().format(lastDate)}'
          : '$first - $last',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w600),
    );
  }
}
