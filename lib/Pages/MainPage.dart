import 'package:flutter/material.dart';
import 'package:pr_mbls/GlobalWidgets/CustomButtons.dart';
import 'package:pr_mbls/GlobalWidgets/CustomLists.dart';
import '../GlobalWidgets/CustomTexts.dart';

class MainPage extends StatelessWidget {
  CustomTexts texts = CustomTexts();
  CustomLists lists = CustomLists();
  CustomButtons buttons = CustomButtons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                texts.MediumAppName(60, 24),
              ],
            ),
            Expanded(
              flex: MediaQuery.of(context).size.height.round(),
              child: lists.mainList(),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buttons.profileButton(context),
                Spacer(),
                buttons.addPublishButton(context),
                Spacer(),
                buttons.settingsButton(context),
              ],
            ),
          ]
        ),
      ),
    );
  }

}