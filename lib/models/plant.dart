class PlantAttributes {
  final Map<int, int> attributes;

  const PlantAttributes(this.attributes);
}

class Plant extends PlantAttributes {
  String name;
  String latinName;
  String description;

  Plant({
    required this.name,
    required this.latinName,
    required attributes,
    required this.description,
  }) : super(attributes);

  Plant.fromRaw(Map<String, Object> raw)
      : name = raw['name'] as String,
        latinName = raw['latinName'] as String,
        description = raw['description'] as String,
        super(raw['attributes'] as Map<int, int>);

  bool isFit(PlantAttributes criteria) {
    return criteria.attributes.keys.every((attributeType) {
      return attributes.containsKey(attributeType) &&
          criteria.attributes[attributeType] == attributes[attributeType];
    });
  }
}
