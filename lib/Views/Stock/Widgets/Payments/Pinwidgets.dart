
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';


class CartPinInputModal extends StatefulWidget {
  @override
  _CartPinInputModalState createState() => _CartPinInputModalState();
}


class _CartPinInputModalState extends State<CartPinInputModal> {

  final List<String> _pin = ['', '', '', ''];
  int _currentIndex = 0;

  void _handleKeyPress(String value) {
    setState(() {
      if (value == 'delete') {
        if (_currentIndex > 0) {
          _currentIndex--;
          _pin[_currentIndex] = '';
        }
      } else {
        if (_currentIndex < 4) {
          _pin[_currentIndex] = value;
          _currentIndex++;

          if (_currentIndex == 4) {
            _onPinComplete();
          }
        }
      }
    });
  }

    void _onPinComplete() {
    String enteredPin = _pin.join('');
    print("Entered PIN: $enteredPin");


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          SizedBox(height: 16),
          _buildPinFields(),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {

            },
            child: CustomText(text: "Forgot Payment PIN?", fontSize: 11),
          ),
          SizedBox(height: 20),
          _buildNumberPad(),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(width: 24), 
        Expanded(
          child: Center(
            child: CustomText(
              text: "Enter Payment PIN",
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }


  Widget _buildPinFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(4, (index) {
        return Container(
          height: 50,
          width: 50,
          margin: EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _pin[index],
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        );
      }),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        for (int i = 1; i <= 3; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int j = 1; j <= 3; j++)
                Expanded(
                  child: _buildNumberButton('${3 * (i - 1) + j}'),
                ),
            ],
          ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox()), 
            Expanded(child: _buildNumberButton('0')), 
            Expanded(child: _buildNumberButton('delete', isDelete: true)),
          ],
        ),

      ],
    );
  }

  Widget _buildNumberButton(String value, {bool isDelete = false}) {
    return GestureDetector(
      onTap: () => _handleKeyPress(value),
      child: Container(
        height: 70,
        margin: EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[200],
        ),
        child: isDelete
            ? Icon(Icons.backspace, size: 24)
            : Text(value, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
