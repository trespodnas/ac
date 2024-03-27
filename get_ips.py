#!/usr/bin/env python3
import json
from pathlib import Path
from sys import argv


def parse_file(file_name: str) -> str:
    file_input = Path(file_name.strip())
    if not file_input.is_file():
        print(f'\n{file_input} : File does not exist, exiting\n')
        exit(1)
    else:
        with open(file_input, 'r') as reader:
            json_data = json.load(reader)
            ips = json_data['vm_private_ips']['value']

    return f"{', '.join(ips)},"


if __name__ == '__main__':
    try:
        filename = argv[1]
        print(parse_file(filename))
    except (NameError, IndexError):
        print('\nNo file detected, exiting\n')
