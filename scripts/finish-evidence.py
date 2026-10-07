"""Collect remaining SSH and browser homework evidence, sequentially."""
import pathlib,subprocess,time
ROOT=pathlib.Path(__file__).resolve().parents[1]
PW='/Users/riteshprajapati/.codex/skills/playwright/scripts/playwright_cli.sh'
def terminal(folder,name,cmd):
 subprocess.run(['python3','scripts/capture-terminal.py',folder,name,cmd],check=True)
def browser(folder,name,url):
 subprocess.run([PW,'--session','app','goto',url],check=True,stdout=subprocess.DEVNULL)
 time.sleep(2)
 path=ROOT/folder/'output/playwright'/name;path.parent.mkdir(parents=True,exist_ok=True)
 subprocess.run([PW,'--session','app','screenshot','--filename',str(path)],check=True,stdout=subprocess.DEVNULL)
terminal('Kubernetes Fundamentals','cluster-stopped','minikube stop')
log='~/devops-sst/"Linux Fundamentals"/output/logs/session02-05.log'
for folder,name,start,end in [('Linux Fundamentals','linux-links-user',1,38),('Linux Fundamentals','linux-system-logs',39,69),('Shell Scripting','system-info-script',70,101),('Networking','interfaces-routing',102,145),('Networking','dns-http',146,193),('Git and GitHub','tracked-untracked',194,230),('Git and GitHub','cherry-pick',231,255)]:
 terminal(folder,name,f'echo "Actual recorded SSH run: {folder}"; sed -n "{start},{end}p" {log}')
subprocess.run(['python3','scripts/collect-docker-evidence.py'],check=True)
for folder,name,script,url in [('Docker Images','multi-stage','session07.sh','http://127.0.0.1:18080'),('Docker Networking','network-volume','session08.sh','http://127.0.0.1:18080'),('Complete CICD & DevSecOps','remote-tests','session16-17.sh','http://127.0.0.1:18081')]:
 terminal(folder,name,'docker rm -f homework-bind 2>/dev/null || true; bash ~/devops-sst/scripts/'+script+' 2>&1 | tee ~/devops-sst/"'+folder+'"/output/logs/'+name+'.log')
 browser(folder,name+'-browser.png',url)
terminal('Monitoring, Observability & GitOps','monitoring','docker rm -f homework-devsecops homework-bind homework-app 2>/dev/null || true; bash ~/devops-sst/scripts/session20.sh 2>&1 | tee ~/devops-sst/"Monitoring, Observability & GitOps"/output/logs/monitoring.log')
print('Remaining Docker and monitoring command evidence captured',flush=True)
