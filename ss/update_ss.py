"""
python update_ss.py  -f export.json  -i 153.36.110.118
"""
import os
import json
import argparse

parser = argparse.ArgumentParser("""
Example:
    python update_ss.py -i "8.8.8.8" -p 1234 -r -d
""")

parser.add_argument("-i","--ip", type=str, default="")
parser.add_argument("-p","--port", type=str, default="")
parser.add_argument("-f","--json_file", type=str, default="export.json")
parser.add_argument("-r","--remote", default=False, action="store_true")
parser.add_argument("-d","--docker_restart", default=False, action="store_true")
args = parser.parse_args()

json_file = args.json_file
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
    wait
    """
    os.system(cmd)

    if args.docker_restart:
        cmd = """
        ssh -o ConnectTimeout=5 l1 \"cd ~/.Qdotfiles && docker-compose restart " &
        ssh -o ConnectTimeout=5 l2 \"cd ~/.Qdotfiles && docker-compose restart " &
        wait
        """
        os.system(cmd)
