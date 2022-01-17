import 'package:fyto/models/plant.dart';

const attributeTypes = [
  {'id': 11, 'name': 'virágzat'},
  {'id': 12, 'name': 'levél alak'},
  {'id': 13, 'name': 'levél szél'},
  {'id': 14, 'name': 'levélkapocs'},
  {'id': 21, 'name': 'virág alak'},
  {'id': 22, 'name': 'virág szín'},
  {'id': 23, 'name': 'szár alak'},
  {'id': 31, 'name': 'kéreg minta'},
  {'id': 32, 'name': 'kéreg szín'},
  {'id': 33, 'name': 'termés'},
];

const attributeValues = [
  {'id': 1100, 'name': 'fürt'},
  {'id': 1101, 'name': 'magányos'},
  {'id': 1200, 'name': 'lándzsás'},
  {'id': 1201, 'name': 'tojásdad'},
  {'id': 1202, 'name': 'szálas'},
  {'id': 1203, 'name': 'elliptikus'},
  {'id': 1204, 'name': 'hasogatott'},
  {'id': 1205, 'name': 'kerekded'},
  {'id': 1206, 'name': 'tűlevél'},
  {'id': 1207, 'name': 'pikkely'},
  {'id': 1208, 'name': 'vese'},
  {'id': 1209, 'name': 'osztott'},
  {'id': 1210, 'name': 'szárnyalt'},
  {'id': 1211, 'name': 'összetett'},
  {'id': 1212, 'name': 'visszás tojásdad'},
  {'id': 1213, 'name': 'ár'},
  {'id': 1214, 'name': 'háromszögletes'},
  {'id': 1215, 'name': 'kard'},
  {'id': 1216, 'name': 'lapát'},
  {'id': 1217, 'name': 'visszás lándzsás'},
  {'id': 1218, 'name': 'szív'},
  {'id': 1219, 'name': 'karéjos'},
  {'id': 1300, 'name': 'ép'},
  {'id': 1301, 'name': 'fűrészes'},
  {'id': 1400, 'name': 'nyeles'},
  {'id': 1404, 'name': 'lefutó'},
  {'id': 2102, 'name': '5 tagú'},
  {'id': 2105, 'name': 'fészek'},
  {'id': 2111, 'name': 'forrt'},
  {'id': 2200, 'name': 'sárga'},
  {'id': 2201, 'name': 'fehér'},
  {'id': 2300, 'name': 'hengeres'},
  {'id': 3100, 'name': 'sima'},
  {'id': 3200, 'name': 'szürke'},
  {'id': 3300, 'name': 'toboz'},
];

const pa = [
  {
    'type': 11,
    'attributes': [1100, 1101]
  },
  {
    'type': 12,
    'attributes': [
      1200,
      1201,
      1202,
      1203,
      1204,
      1205,
      1206,
      1207,
      1208,
      1209,
      1210,
      1211,
      1212,
      1213,
      1214,
      1215,
      1216,
      1217,
      1218,
      1219
    ]
  },
  {
    'type': 13,
    'attributes': [1300, 1301]
  },
  {
    'type': 14,
    'attributes': [1400, 1404]
  },
  {
    'type': 21,
    'attributes': [2102, 2105, 2111]
  },
  {
    'type': 22,
    'attributes': [2200, 2201]
  },
  {
    'type': 23,
    'attributes': [2300]
  },
  {'type': 31, 'attributes': [3100]},
  {'type': 32, 'attributes': [3200]},
  {'type': 33, 'attributes': [3300]},
];

const List<Plant> plants = [
  Plant(
    name: 'Apró szulák',
    latinName: '',
    flower: 1101,
    leafShape: 1200,
    leafEdge: 1300,
    leafClamp: 1400,
    flowerShape: 2111,
    flowerColour: 2201,
    stemShape: 2300,
  ),
  Plant(
    name: 'Bakszakáll',
    latinName: '',
    flower: 1101,
    leafShape: 1200,
    leafEdge: 1300,
    leafClamp: 1404,
    flowerShape: 2105,
    flowerColour: 2200,
    stemShape: 2300,
  ),
  Plant(
    name: 'Arany pimpó',
    latinName: '',
    flower: 1101,
    leafShape: 1211,
    leafEdge: 1301,
    leafClamp: 1400,
    flowerShape: 2102,
    flowerColour: 2200,
    stemShape: 2300,
  ),
];
