"""
A script parse specific config from ss configuration file,
and update config file to remote servers and restart services
on remote servers.

Author: QiangZiBro
Contact: qiangzibro@gmail.com
"""
import os
import json
import shutil
import argparse

def get_machines():
    """stupid way to parse servers"""
    with open("../.env") as f:
        for line in f:
            if line.startswith("SERVERS"):
                line=line.replace('"',"")
                line=line.replace("'","")
                line=line.replace("\n","")
                line=line.split("=")[-1]
                return line.split(" ")[1:]
    return []


def parse_args():
    parser = argparse.ArgumentParser(description="""
    Setting ss configuration based on rules
    """)

    parser.add_argument("ip", nargs="?", type=str, help="Remote ss server ip address with port")
    parser.add_argument("-f","--file", type=str, default="export.json", help="Export file,\
            should in ss directory")
    parser.add_argument("-r","--remote", default=False, action="store_true",help="Update ss file to remote")
    parser.add_argument("-d","--docker_restart", default=False, action="store_true",help="Restart docker after update ss file")
    args = parser.parse_args()
    json_file = args.file
    if args.ip:
        split = args.ip.split(":")
        ip = split[0]
        port = split[-1] if ":" in args.ip else ""
    else:
        ip=port=None
    return ip,port,json_file,args

def write(c):
    PREFIX = os.path.expanduser("~/.Qdotfiles/ss")
    with open(f'{PREFIX}/ss.json', 'w') as outfile:
        json.dump(c, outfile, indent=4)

def print_json(c):
    print("----------------------------------------------------------------------------------")
    print(json.dumps(c, indent=4, sort_keys=True))
    print("----------------------------------------------------------------------------------")


def parse_config():
    with open(json_file) as json_data:
        data = json.load(json_data)
    for c in data["configs"]:
        if (port and str(c["server"]) == ip and str(c["server_port"]) == port) \
                or (port == "" and str(c["server"]) == ip):
            write(c)
            print_json(c)
            return c
    else:
        print("I did't find any configuration in your file")
        return None

def excute(template, machines):
    cmds = [template.format(m) for m in machines] + ["wait"]
    cmd = " \n ".join(cmds)
    os.system(cmd)
    

if __name__ == "__main__":
    MACHINES = get_machines()
    ip,port,json_file,args = parse_args()
    if ip:
        config = parse_config()
    else:
        source="/Users/mac/Library/Application Support/ShadowsocksX-NG/ss-local-config.json"
        if os.path.exists(source):
            print("Find config file in:")
            print(source)
            # TODO: Could be better
            with open(source) as json_data:
                c = json.load(json_data)
                c["local_port"] = 1080
                #del c["local_port"]
                #del c["local_address"]
                write(c)
                print_json(c)
            # TODO: Could be better
            config=True

        else:
            print("Didn't find anyting useful configs in your computer, nothing to do")
            exit(1)

    if config and args.remote:
        excute('scp -o ConnectTimeout=5 ss.json {}:~/.Qdotfiles/ss/ &', MACHINES)
        if args.docker_restart:
            excute('ssh -o ConnectTimeout=5 {} \"cd ~/.Qdotfiles && docker-compose restart " &', MACHINES)
