import 'package:flutter/material.dart';
import 'package:fyto/utils/utils.dart';

class PlantDetailsAttributes extends StatelessWidget {
  final Map<String, String> attributes;

  const PlantDetailsAttributes(this.attributes);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 18, left: 24),
      itemCount: attributes.entries.length,
      itemBuilder: (context, index) {
        MapEntry e = attributes.entries.elementAt(index);
        String attributeType = resolveAttributeTypeName(e.key);
        String attributeValue = resolveAttributeValueName(e.value);

        return Container(
          height: 50,
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(capitalizeFirstLetter(attributeType),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  )),
              Text(capitalizeFirstLetter(attributeValue),
                  style: TextStyle(
                    color: Colors.green[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  )),
            ],
          ),
        );
      },
    );
  }
}
