import 'package:flutter/material.dart';
import 'package:steps_indicator/steps_indicator.dart';

class StepperLineIndicator extends StatefulWidget {
  final int selectedStep;
  final List<Widget> steps;

  StepperLineIndicator({this.selectedStep = 0, this.steps})
      : assert(steps != null && selectedStep >= 0);

  @override
  _StepperLineIndicatorState createState() => _StepperLineIndicatorState();
}

class _StepperLineIndicatorState extends State<StepperLineIndicator>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  int _selectedStep = -1;
  List _steps;

  @override
  initState() {
    super.initState();
    _steps = widget.steps;

    if (_steps == null || _steps.length == 0) {
      _steps = [];
      _steps.add(Container);
    }
  }

  Widget _buildSteps() {
    if (_selectedStep < widget.selectedStep ||
        _selectedStep < widget.selectedStep) {
      controller = AnimationController(
          duration: const Duration(milliseconds: 1000), vsync: this);
      animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
      controller.forward();
      _selectedStep = widget.selectedStep;
    }

    return FadeTransition(
        opacity: animation,
        child: _steps[(widget.selectedStep < widget.steps.length)
            ? widget.selectedStep
            : _steps.length - 1]);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        deviceWidth < 550.0 ? deviceWidth - 10 : deviceWidth * 0.7;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: StepsIndicator(
              selectedStep: (widget.selectedStep < widget.steps.length)
                  ? widget.selectedStep
                  : _steps.length - 1,
              nbSteps: widget.steps.length,
              doneLineColor: Colors.orangeAccent,
              doneStepColor: Colors.orangeAccent,
              undoneLineColor: Colors.grey,
              unselectedStepColorIn: Colors.grey,
              selectedStepColorOut: Colors.orangeAccent,
              selectedStepColorIn: Colors.orangeAccent,
              unselectedStepColorOut: Colors.grey,
              lineLength: (targetWidth / _steps.length) - 10),
        ),
        _buildSteps(),
      ],
    );
  }
}
