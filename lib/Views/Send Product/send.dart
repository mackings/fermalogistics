import 'package:fama/Views/Send%20Product/steps/step1.dart';
import 'package:fama/Views/Send%20Product/steps/step2.dart';
import 'package:fama/Views/Send%20Product/steps/step3.dart';
import 'package:fama/Views/Send%20Product/steps/step4.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class SendProduct extends ConsumerStatefulWidget {
  const SendProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SendProductState();
}

class _SendProductState extends ConsumerState<SendProduct> {

  List<bool> _stepsCompleted = [false, false, false, false];
  int _currentStep = 0;

  final Map<String, dynamic> formData = {};
  void _completeStep(Map<String, dynamic> data) {

    setState(() {
      _stepsCompleted[_currentStep] = true;
      formData.addAll(data);
      if (_currentStep < 3) {
        _currentStep++;
      } else {
        
        print('All steps completed with data: $formData');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Send Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return Container(
                  width: 70,
                  height: 3,
                  color: _stepsCompleted[index] ? Colors.red : Colors.grey,
                );
              }),
            ),
            Expanded(
              child: _getFormForStep(_currentStep),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getFormForStep(int step) {
    switch (step) {
      case 0:
        return StepForm1(onComplete: _completeStep);
      case 1:
        return StepForm2(onComplete: _completeStep);
      case 2:
        return StepForm3(onComplete: _completeStep);
      case 3:
        return StepForm4(onComplete: _completeStep);
      default:
        return Container();
    }
  }
  
}



