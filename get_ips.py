#!/usr/bin/env python3
import json
from pathlib import Path
from sys import argv


def parse_file(file_name: str, value_output: str) -> str:
    file_input = Path(file_name.strip())
    with open(file_input, 'r') as reader:
        json_data = json.load(reader)
        ips = json_data['vm_private_ips']['value']
        vm_name = json_data['vm_name']['value']
        return_value = ips if value_output == 'ip' else vm_name
    return f"{', '.join(return_value)},"


try:
    filename = argv[1].lower().strip()
    value = argv[2].lower().strip()
    if 'ip' in value:
        print(parse_file(filename, value))
    if 'name' in value:
        print(parse_file(filename, value))
    else:
        print(parse_file(filename, value))

except (Exception, NameError, IndexError):
    print('\nNo file specified or value detected ("name" or "ip"), exiting\n')
