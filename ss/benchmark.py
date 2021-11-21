import os
import json
import time
from subprocess import DEVNULL, STDOUT, check_call

import requests


def check():
    os.chdir(os.path.expanduser("~/.Qdotfiles"))
    export = os.path.expanduser("~/.Qdotfiles/ss/export.json")
    gui_json = os.path.expanduser("~/.Qdotfiles/ss/gui-config.json")
    if os.path.exists(export):
        json_file = export
    elif os.path.exists(gui_json):
        json_file = gui_json
    else:
        raise Exception(
            "You should put either export.json or gui-config.json in ss/")

    return json_file


def parse_export(json_file):
    with open(json_file) as json_data:
        data = json.load(json_data)
    return data["configs"]


def write(c):
    PREFIX = os.path.expanduser("~/.Qdotfiles/ss")
    c["local_port"] = 1080
    with open(f"{PREFIX}/ss.json", "w") as outfile:
        json.dump(c, outfile, indent=4)


proxies = {
    'http': 'http://127.0.0.1:8999',
    'https': 'https://127.0.0.1:8999',
}


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
    #print_json(c)
    print("You can also use command below in other platform 🚀\n")
    print(f'  proxy set \"{c["server"]}:{c["server_port"]}\"')


def benchmark(json_file, patience=10):
    configs = []
    elapsed = []
    for c in parse_export(json_file):
        write(c)
        check_call(['docker-compose', 'restart'],
                   stdout=DEVNULL,
                   stderr=STDOUT)
        time.sleep(1)

        r = None
        for _ in range(3):
            try:
                r = requests.get("https://google.com",
                                 timeout=2,
                                 proxies=proxies)
            except:
                #print(f'{c["server"]}:{c["server_port"]} failed')
                break
        if r and r and r.ok:
            configs.append(c)
            elapsed.append(r.elapsed.total_seconds())

        if len(configs) > patience:
            break

    if configs is None:
        raise Exception("It seems all of your nodes useless")

    c = configs[elapsed.index(min(elapsed))]
    write(c)
    hint(c)


if __name__ == "__main__":
    print("Auto deciding best ss server, this may take some time...")
    print("You can wait and have a cup of tea")
    benchmark(check(), 3)
