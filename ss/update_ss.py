"""
A script parse specific config from ss configuration file,
and update config file to remote servers and restart services
on remote servers.

Author: QiangZiBro
Contact: qiangzibro@gmail.com
"""
import os
import json
import argparse
from ss.utils import get_config_path


def get_machines():
    """stupid way to parse servers"""
    with open("../.env") as f:
        for line in f:
            if line.startswith("SERVERS"):
                line = line.replace('"', "")
                line = line.replace("'", "")
                line = line.replace("\n", "")
                line = line.split("=")[-1]
                return line.split(" ")[1:]
    return []


def parse_args():
    parser = argparse.ArgumentParser(description="""
    Setting ss configuration based on rules
    """)

    parser.add_argument("ip",
                        nargs="?",
                        type=str,
                        help="Remote ss server ip address with port")
    parser.add_argument(
        "-f",
        "--file",
        type=str,
        default="export.json",
        help="Export file,\
            should in ss directory",
    )
    parser.add_argument(
        "-r",
        "--remote",
        default=False,
        action="store_true",
        help="Update ss file to remote",
    )
    parser.add_argument(
        "-d",
        "--docker_restart",
        default=False,
        action="store_true",
        help="Restart docker after update ss file",
    )
    args = parser.parse_args()
    json_file = args.file
    if args.ip:
        split = args.ip.split(":")
        ip = split[0]
        port = split[-1] if ":" in args.ip else ""
    else:
        ip = port = None
    return ip, port, json_file, args


def write(c):
    PREFIX = os.path.expanduser("~/.Qdotfiles/ss")
    c["local_port"] = 1080
    with open(f"{PREFIX}/ss.json", "w") as outfile:
        json.dump(c, outfile, indent=4)


def parse_config(ip, port):
    with open(get_config_path()) as json_data:
        data = json.load(json_data)
    for c in data["configs"]:
        if (port and str(c["server"]) == ip and str(c["server_port"]) == port) or (
                port == "" and str(c["server"]) == ip):
            return c
    else:
        return None


def excute(template, machines):
    cmds = [template.format(m) for m in machines] + ["wait"]
    cmd = " \n ".join(cmds)
    os.system(cmd)


def find_in_other_places():
    print("Finding config in setting positions")
    source = "/Users/mac/Library/Application Support/ShadowsocksX-NG/ss-local-config.json"
    if os.path.exists(source):
        print("Find one in ", source)
        with open(source) as json_data:
            c = json.load(json_data)
            # del c["local_port"]
            # del c["local_address"]
            write(c)
        return c
    else:
        return None

#
# if __name__ == "__main__":
#     MACHINES = get_machines()
#     ip, port, json_file, args = parse_args()
#     if ip:
#         # If ip is specified, look up it from the whole config file
#         config = parse_config(ip)
#     else:
#         # Single config file may be stored in your shadowsocks software, so
#         # find it directly
#         source = "/Users/mac/Library/Application Support/ShadowsocksX-NG/ss-local-config.json"
#         if os.path.exists(source):
#             print("Find config file in:")
#             print(source)
#             with open(source) as json_data:
#                 c = json.load(json_data)
#                 # del c["local_port"]
#                 # del c["local_address"]
#                 write(c)
#             config = c
#         else:
#             config = None
#     if config:
#         print()
#         write(config)
#         print("SS server node has decided")
#         print("You can also use command below in other platform 🚀\n")
#         print(f'  proxy set \"{config["server"]}:{config["server_port"]}\"')
#     else:
#         print(
#             "Didn't find anyting useful configs in your computer, nothing to do"
#         )
#         exit(1)
#
#     if config and args.remote:
#         excute("scp -o ConnectTimeout=5 ss.json {}:~/.Qdotfiles/ss/ &",
#                MACHINES)
#         if args.docker_restart:
#             excute(
#                 'ssh -o ConnectTimeout=5 {} "cd ~/.Qdotfiles && docker-compose restart " &',
#                 MACHINES,
#             )
