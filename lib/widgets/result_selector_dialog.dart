import 'package:flutter/material.dart';
import 'package:fyto/models/plant.dart';
import 'package:fyto/widgets/result_selector.dart';

class ResultSelectorDialog extends StatelessWidget {
  List<Plant> results;

  ResultSelectorDialog(this.results);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
        child: ResultSelector(results),
      ),
    );
  }
}
