class PlantAttributes {
  final int? flower;
  final int? leafShape;
  final int? leafEdge;
  final int? leafClamp;

  final int? flowerShape;
  final int? flowerColour;
  final int? stemShape;

  final int? crustPattern;
  final int? crustColour;
  final int? crop;

  const PlantAttributes({
    this.flower,
    this.leafShape,
    this.leafEdge,
    this.leafClamp,
    this.flowerShape,
    this.flowerColour,
    this.stemShape,
    this.crustPattern,
    this.crustColour,
    this.crop,
  });
}

class Plant extends PlantAttributes {
  final String name;
  final String latinName;

  const Plant({
    required this.name,
    required this.latinName,
    required flower,
    required leafShape,
    required leafEdge,
    required leafClamp,
    flowerShape,
    flowerColour,
    stemShape,
    crustPattern,
    crustColour,
    crop,
  }) : super(
          flower: flower,
          leafShape: leafShape,
          leafEdge: leafEdge,
          leafClamp: leafClamp,
          flowerShape: flowerShape,
          flowerColour: flowerColour,
          stemShape: stemShape,
          crustPattern: crustPattern,
          crustColour: crustColour,
          crop: crop,
        );

  bool isFit(PlantAttributes criteria) {
    if (criteria.flower != null && flower != criteria.flower) {
      return false;
    }
    if (criteria.leafShape != null && leafShape != criteria.leafShape) {
      return false;
    }
    if (criteria.leafEdge != null && leafEdge != criteria.leafEdge) {
      return false;
    }
    if (criteria.leafClamp != null && leafClamp != criteria.leafClamp) {
      return false;
    }
    if (criteria.flowerShape != null && flowerShape != criteria.flowerShape) {
      return false;
    }
    if (criteria.flowerColour != null &&
        flowerColour != criteria.flowerColour) {
      return false;
    }
    if (criteria.stemShape != null && stemShape != criteria.stemShape) {
      return false;
    }
    if (criteria.crustPattern != null &&
        crustPattern != criteria.crustPattern) {
      return false;
    }
    if (criteria.crustColour != null && crustColour != criteria.crustColour) {
      return false;
    }
    if (criteria.crop != null && crop != criteria.crop) {
      return false;
    }
    return true;
  }
}
