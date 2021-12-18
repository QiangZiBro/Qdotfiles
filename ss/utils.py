# -*- coding: UTF-8 -*-
import json
import os
from subprocess import check_call, DEVNULL, STDOUT


def get_config_path():
    os.chdir(os.path.expanduser("~/.Qdotfiles"))
    export = os.path.expanduser("~/.Qdotfiles/ss/export.json")
    gui_json = os.path.expanduser("~/.Qdotfiles/ss/gui-config.json")
    if os.path.exists(export):
        json_file = export
    elif os.path.exists(gui_json):
        json_file = gui_json
    else:
        raise Exception("No export.json or gui-config.json in ss")
    return json_file


def print_json(c):
    print(
        "----------------------------------------------------------------------------------"
    )
    print(json.dumps(c, indent=4, sort_keys=True))
    print(
        "----------------------------------------------------------------------------------"
    )


def write_json(c, filename="ss.json"):
    PREFIX = os.path.expanduser("~/.Qdotfiles/ss")
    c["local_port"] = 1080
    with open(f"{PREFIX}/{filename}", "w") as outfile:
        json.dump(c, outfile, indent=4)


def restart_ss_service():
    check_call(['docker-compose', 'restart'],
               stdout=DEVNULL,
               stderr=STDOUT)
