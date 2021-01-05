import 'package:flutter/material.dart';

class BottomSheetMenu extends StatefulWidget {
  List<String> options;
  final double bottomSheetFirstStepHeight;
  final TextEditingController textEditingController;
  String selectedOption;
  String defaultSelectedOption;
  Function doOnChange;
  double width;
  BuildContext context;
  final String semanticsKey;

  bool _enableCloseBar = false;

  bool get enableCloseBar => _enableCloseBar;

  set enableCloseBar(bool value) {
    _enableCloseBar = value;
  }

  BottomSheetMenu(
      {@required this.options,
      @required this.defaultSelectedOption,
      this.bottomSheetFirstStepHeight,
      this.doOnChange,
      @required this.context,
      @required this.textEditingController,
      this.width,
      this.semanticsKey,
      Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BottomSheetMenuState();
  }
}

class BottomSheetMenuState extends State<BottomSheetMenu> {
  // var textController = new TextEditingController();

//  TextEditingController _dropDownController;
  @override
  void initState() {
    super.initState();
    widget.textEditingController.text = (widget.defaultSelectedOption != null)
        ? widget.defaultSelectedOption
        : '';
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    return _buildBottomSheet(widget.options, widget.bottomSheetFirstStepHeight);
  }

  // _getBottomSheetHeight(double height, double deviceHeight) {
  //   if (height != null) {
  //     if (height == deviceHeight) {
  //       print("widget.bottomSheetFristStepHeight ${height}");
  //       print("widget.bottomSheetFristStepHeight ${deviceHeight}");
  //
  //       widget.enableCloseBar = true;
  //       return (height - 20);
  //     } else {
  //       return height;
  //     }
  //   } else {
  //     print("else widget.bottomSheetFristStepHeight ${height}");
  //     print("else widget.bottomSheetFristStepHeight ${deviceHeight}");
  //     widget.enableCloseBar = false;
  //     return 300.0;
  //   }
  // }

  _buildBottomSheet(List<String> options, double height) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    return showModalBottomSheet<dynamic>(
      context: widget.context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext bc) {
        return Container(
          height: (100.0 * options.length),
          color: Color(0xFFD5D7DB),
          child: Column(
            children: <Widget>[
              _closeBar(height),
              Expanded(
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                    child: new ListTile(
                      title: new Text(options[index].toString()),
                      onTap: () => setState(
                        () {
                          widget.defaultSelectedOption = options[index];
                          widget.textEditingController.text = options[index];
                          print(
                              "selected value is ${widget.defaultSelectedOption}");
                          // (widget.doOnChange != null)
                          //     ? widget.doOnChange(dropDownList[index])
                          //     : () {};
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _closeBar(double deviceHeight) {
    return Visibility(
        visible: widget.enableCloseBar,
        child: Container(
          height: 50,
          width: 500,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFFD5D7DB).withOpacity(0.4),
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 0, //extend the shadow
              )
            ],
          ),
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[500]),
                  child: IconButton(
                      color: Colors.grey[500],
                      icon: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                      onPressed: () => {Navigator.pop(widget.context)}),
                ),
              ],
            ),
          ),
        ));
  }
}
