"""
python update_ss.py  -f export.json  -i 153.36.110.118
"""
import os
import json
import argparse

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

if OK and args.remote:
    cmd = """
    scp -o ConnectTimeout=5 ss.json l1:~/.Qdotfiles/ss/ &
    scp -o ConnectTimeout=5 ss.json l2:~/.Qdotfiles/ss/ &
    scp -o ConnectTimeout=5 ss.json l3:~/.Qdotfiles/ss/ &
    wait
    """
    os.system(cmd)

    if args.docker_restart:
        cmd = """
        ssh -o ConnectTimeout=5 l1 \"cd ~/.Qdotfiles && docker-compose restart " &
        ssh -o ConnectTimeout=5 l2 \"cd ~/.Qdotfiles && docker-compose restart " &
        ssh -o ConnectTimeout=5 l3 \"cd ~/.Qdotfiles && docker-compose restart " &
        wait
        """
        os.system(cmd)
