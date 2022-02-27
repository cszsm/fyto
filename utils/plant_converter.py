import csv
import json

attribute_values = []
raw_plants = []

with open('utils/plant_attribute_values.json') as attribute_values_file, \
        open('utils/plants.tsv') as plants_file:
    attribute_values = json.load(attribute_values_file)
    raw_plants = list(csv.reader(plants_file, delimiter='\t'))


def to_attribute_id(attribute):
    return list(filter(lambda x: x['name'] == attribute, attribute_values))[0]['id']


def to_attribute_ids(raw):
    index_id_paring = [
        [2, '11'], [3, '12'], [4, '13'], [5, '14'],
        [6, '21'], [7, '22'], [8, '23'],
        [9, '31'], [10, '32'], [11, '33'],
    ]
    attributes = {}
    for index, id in index_id_paring:
        if raw[index] != '':
            attributes[id] = to_attribute_id(raw[index])
    return attributes


def to_object(raw):
    plant = {}
    plant['name'] = raw[0]
    plant['latinName'] = raw[1]
    plant['attributes'] = to_attribute_ids(raw)
    plant['description'] = raw[12]
    return plant


test_plants = [
    to_object(raw_plants[12]),
    to_object(raw_plants[13]),
    to_object(raw_plants[26])
]

with open('utils/plants.json', 'w') as plants_json:
    json.dump(test_plants, plants_json, ensure_ascii=False)
