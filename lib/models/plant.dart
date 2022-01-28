class PlantAttributes {
  final Map<int, int> attributes;

  const PlantAttributes(this.attributes);
}

class Plant extends PlantAttributes {
  String? name;
  String? latinName;

  Plant({
    required this.name,
    required this.latinName,
    required attributes,
  }) : super(attributes);

  Plant.fromRaw(Map<String, Object> raw)
      : super(raw['attributes'] as Map<int, int>) {
    name = raw['name'] as String;
    latinName = raw['latinName'] as String;
  }

  bool isFit(PlantAttributes criteria) {
    return criteria.attributes.keys.every((attributeType) {
      return attributes.containsKey(attributeType) &&
          criteria.attributes[attributeType] == attributes[attributeType];
    });
  }
}
