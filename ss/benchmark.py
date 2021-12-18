#!/usr/bin/python
"""A script for testing ss nodes
"""
import importlib
import os
import json
import time
import argparse
from subprocess import DEVNULL, STDOUT, check_call
import urllib3

from ss.utils import get_config_path, write_json

if urllib3.__version__ != '1.25.8':
    print("fix urllib3 version issue...")
    os.system("http_proxy= && https_proxy= && pip install urllib3==1.25.8")
    importlib.reload(urllib3)
    print("Now urllib3==", urllib3.__version__)
    print("Please rerun the command again")
    exit(0)

import requests


def parse_json_file(filename):
    with open(filename) as json_data:
        data = json.load(json_data)
    return data["configs"]


def print_json(c):
    print(
        "----------------------------------------------------------------------------------"
    )
    print(json.dumps(c, indent=4, sort_keys=True))
    print(
        "----------------------------------------------------------------------------------"
    )


def hint(c):
    print()
    print("Best ss server has decided!")
    # print_json(c)
    print("You can also use command below in other platform 🚀\n")
    print(f'  proxy set \"{c["server"]}:{c["server_port"]}\"')


# use http proxy
def access(url="https://www.google.com"):
    proxies = {
        'http': 'http://127.0.0.1:8999',
        'https': 'https://127.0.0.1:8999',
    }
    r = None
    try:
        r = requests.get(url,
                         timeout=2,
                         proxies=proxies)
    except Exception as e:
        pass
    return r


def benchmark(patience=10, verbose=False, delete=False):
    json_file = get_config_path()
    configs = []
    elapsed = []

    with open(json_file) as json_data:
        data = json.load(json_data)
    print(f"[INFO]: {len(data['configs'])} nodes exists, testing...")
    for c in data["configs"]:
        # 1. generate ss.json
        write_json(c)
        # 2. start docker service for ss
        check_call(['docker-compose', 'restart'],
                   stdout=DEVNULL,
                   stderr=STDOUT)
        # waite a little bit, maybe we can't use the docker service immediately
        time.sleep(1)

        # 3. test the link using current proxy
        r = access()
        # can use proxy
        if r and r.ok:
            configs.append(c)
            elapsed.append(r.elapsed.total_seconds())
            if verbose:
                print(f'{c["server"]}:{c["server_port"]} ✅ ({r.elapsed.total_seconds()}s)')
        else:
            if verbose:
                print(f'{c["server"]}:{c["server_port"]} ❌')

        # 4. only want first n nodes
        if len(configs) > patience and not delete:
            break
    if configs is None:
        raise Exception("It seems all of your nodes useless")

    if delete:
        print("[INFO]:Saving to export.json")
        data["configs"] = configs
        write_json(data, filename="export.json")

    c = configs[elapsed.index(min(elapsed))]
    write_json(c)
    hint(c)
    print(f"[INFO]: got {len(configs)} available nodes")


def parse_args():
    parser = argparse.ArgumentParser(description="ss benchmark")
    parser.add_argument("-v", "--verbose", action="store_true")
    parser.add_argument("-d", "--delete", action="store_true", help="Delete the unavailable nodes in the file")
    args = parser.parse_args()
    return args


if __name__ == "__main__":
    print("Auto deciding best ss server, this may take some time...")
    print("You can wait and have a cup of tea")
    config = parse_args()
    benchmark(1, config.verbose, config.delete)
