import csv
import json

attribute_values = []
raw_plants = []

with open('utils/plant_attribute_values.json') as attribute_values_file, \
        open('utils/plants.tsv') as plants_file:
    attribute_values = json.load(attribute_values_file)
    raw_plants = list(csv.reader(plants_file, delimiter='\t'))


def to_attribute_id(attribute):
    print(attribute)
    return list(filter(lambda x: x['name'] == attribute.decode('utf-8'), attribute_values))[0]['id']


def to_attribute_id_object(raw):
    index_id_paring = [
        [2, '11'], [3, '12'], [4, '13'], [5, '14'],
        [6, '21'], [7, '22'], [8, '23'],
        [9, '31'], [10, '32'], [11, '33'],
    ]
    attributes = {}
    for index, id in index_id_paring:
        if raw[index] != '':
            attributes[id] = to_attribute_id(raw[index])

    if len(attributes) == 0:
        # to ensure type safety in dart in case of an empty attribute list
        attributes = {'': ''}
    return attributes


def to_object(raw):
    plant = {}
    plant['name'] = raw[0]
    plant['latinName'] = raw[1]
    plant['attributes'] = to_attribute_id_object(raw)
    plant['description'] = raw[12]
    return plant


with open('utils/plants.json', 'w') as plants_json:
    plant_objects = list(map(to_object, raw_plants[3:]))
    json.dump(plant_objects, plants_json, ensure_ascii=False)
