"""Run a command in the live SSH browser terminal and capture its real output."""
import pathlib, subprocess, sys, time, re
ROOT=pathlib.Path(__file__).resolve().parents[1]
PW='/Users/riteshprajapati/.codex/skills/playwright/scripts/playwright_cli.sh'
folder, name, command=sys.argv[1:4]
path=ROOT/folder/'output/screenshots'; path.mkdir(parents=True,exist_ok=True)
def pw(*args): return subprocess.run([PW,'--session','devops',*args],check=True,capture_output=True,text=True)
marker='EVIDENCE_DONE_'+name
pw('type','clear; set -o pipefail; '+command+'; echo '+marker+':$?')
pw('press','Enter')
for attempt in range(360):
 output=pw('snapshot').stdout
 result=re.search(re.escape(marker)+r':(\d+)',output)
 if result:
  print(name+' exit='+result.group(1),flush=True);break
 time.sleep(2)
else: raise RuntimeError('Command did not finish: '+name)
pw('screenshot','--filename',str(path/(name+'.png')))

if result.group(1) != "0":
 raise RuntimeError(name+" failed with exit status "+result.group(1))
