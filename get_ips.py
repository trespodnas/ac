#!/usr/bin/env python3
import json
from pathlib import Path
from sys import argv


def parse_file(file_name: str, get_item: str) -> str:
    file_input = Path(file_name.strip())
    searched_output = []
    with open(file_input, 'r') as reader:
        json_data = json.load(reader)
        ips = json_data['vm_private_ips']['value']
        vm_name = json_data['vm_name']['value']
    output_list = dict(zip(vm_name, ips))
    if get_item == 'ip':
        return f"{', '.join(ips)},"
    elif get_item == 'scan':
        for k, v in output_list.items():
            if get_item in k:
                searched_output.append(v)
        return f"{', '.join(searched_output)},"
    elif get_item == 'sc':
        for k, v in output_list.items():
            if not get_item in k:
                searched_output.append(v)
        return f"{', '.join(searched_output)},"


if __name__ == '__main__':
    try:
        filename = argv[1].lower().strip()
        value = argv[2].lower().strip()
        print(parse_file(filename, value))
    except (Exception, NameError, IndexError):
        print('\nNo file specified or value detected ("name" or "ip"), exiting\n')
