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

MACHINES = ["l{}".format(i) for i in [0, 1, 2, 3, 4, 5, 6]]


parser = argparse.ArgumentParser(description="""
Find ss configure --> Upload to server --> Restart docker on remote
Example:
1. get the config file
    python update_ss.py 116.163.14.9:45472
2. upload ss file to remove Qdotfiles [-r] and restart remote services [-d]
    python update_ss.py 116.163.14.9:45472 -rd
""")

parser.add_argument("ip", type=str, help="Remote ss server ip address with port")
parser.add_argument("-f","--file", type=str, default="export.json", help="Export file,\
        should in ss directory")
parser.add_argument("-r","--remote", default=False, action="store_true",help="Update ss file to remote")
parser.add_argument("-d","--docker_restart", default=False, action="store_true",help="Restart docker after update ss file")
args = parser.parse_args()

json_file = args.file
split = args.ip.split(":")
ip = split[0]
port = split[-1] if ":" in args.ip else ""

def write(c):
    with open('ss.json', 'w') as outfile:
        json.dump(c, outfile, indent=4)
    print("----------------------------------------------------------------------------------")
    print(c)
    print("----------------------------------------------------------------------------------")


def parse_config():
    with open(json_file) as json_data:
        data = json.load(json_data)
    for c in data["configs"]:
        if (port and str(c["server"]) == ip and str(c["server_port"]) == port) \
                or (port == "" and str(c["server"]) == ip):
            write(c)
            return c
    else:
        print("I did't find any configuration in your file")
        return None


def excute(template, machines):
    cmds = [template.format(m) for m in machines] + ["wait"]
    cmd = " \n ".join(cmds)
    os.system(cmd)
    

config = parse_config()
if config and args.remote:
    excute('scp -o ConnectTimeout=5 ss.json {}:~/.Qdotfiles/ss/ &', MACHINES)
    if args.docker_restart:
        excute('ssh -o ConnectTimeout=5 {} \"cd ~/.Qdotfiles && docker-compose restart " &', MACHINES)
