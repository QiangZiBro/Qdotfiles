"""
python update_ss.py  -f export.json  -i 153.36.110.118
"""
import os
import json
import argparse

MACHINES = ["l{}".format(i) for i in range(6)]


parser = argparse.ArgumentParser(description="""
Find ss configure --> Upload to server --> Restart docker on remote
""")

parser.add_argument("-i","--ip", type=str, required=True,help="Remote ss server ip address")
parser.add_argument("-p","--port", type=str, default="", help="Remote ss server ip Port")
parser.add_argument("-f","--file", type=str, default="export.json", help="Export file,\
        should in ss directory")
parser.add_argument("-r","--remote", default=False, action="store_true",help="Update ss file to remote")
parser.add_argument("-d","--docker_restart", default=False, action="store_true",help="Restart docker after update ss file")
args = parser.parse_args()

json_file = args.file
ip = args.ip
port = args.port

def write(c):
    with open('ss.json', 'w') as outfile:
        json.dump(c, outfile, indent=4)
    print("I get it:")
    print(c)

with open(json_file) as json_data:
    data = json.load(json_data)

OK = False
for c in data["configs"]:
    if c["server"] == ip:
        if port != "":
            if str(c["server_port"]) == port:
                OK = True
                write(c)
                break
        else:
            OK = True
            write(c)
            break
if not OK:
    print("I did't find any configuration in your file")


def excute(template, machines):
    cmds = [template.format(m) for m in machines] + ["wait"]
    cmd = " \n ".join(cmds)
    os.system(cmd)

if OK and args.remote:
    excute('scp -o ConnectTimeout=5 ss.json {}:~/.Qdotfiles/ss/ &', MACHINES)

    if args.docker_restart:
        excute('ssh -o ConnectTimeout=5 l0 \"cd ~/.Qdotfiles && docker-compose restart " &', MACHINES)
