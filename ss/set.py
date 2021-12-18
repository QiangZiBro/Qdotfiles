# -*- coding: UTF-8 -*-
import argparse
import os
import sys

os.chdir(os.path.expanduser("~/.Qdotfiles"))
sys.path.append(os.path.expanduser("~/.Qdotfiles"))
from ss.benchmark import benchmark
from ss.update_ss import parse_config, find_in_other_places
from ss.utils import write_json, restart_ss_service, print_json


def parse_args():
    parser = argparse.ArgumentParser(description="Command lind proxy set")
    parser.add_argument("ip", nargs="?", type=str, default="")
    parser.add_argument("-a", "--auto", action="store_true", help="Auto decides the best node")
    parser.add_argument("-v", "--verbose", action="store_true", help="Show more messages")
    parser.add_argument("-d", "--delete", action="store_true", help="Delete the unavailable nodes in the file")
    args = parser.parse_args()
    return args


def parse_ip(ip):
    if ip:
        split = ip.split(":")
        ip = split[0]
        port = split[-1] if ":" in ip else ""
    else:
        ip = port = None
    return ip, port


def find_config(ip):
    ip, port = parse_ip(ip)
    if ip:
        return parse_config(ip, port)
    else:
        return find_in_other_places()


if __name__ == "__main__":
    configs = parse_args()
    if configs.auto:
        benchmark(3, configs.verbose, configs.delete)
    else:
        config = find_config(configs.ip)
        if config:
            print("[INFO]:Config found")
            write_json(config, "ss.json")
            print("[INFO]:Restart ss service")
            restart_ss_service()
        else:
            print("[INFO]:Didn't find any config")
