#!/usr/bin/env bash
set -euxo pipefail
cd "$HOME/devops-sst/Linux Fundamentals"
mkdir -p link-demo
cd link-demo
printf 'Linux link exercise\n' >original.txt
ln -f original.txt hard-link.txt
ln -sfn original.txt soft-link.txt
ls -li original.txt hard-link.txt soft-link.txt
rm original.txt
cat hard-link.txt
if cat soft-link.txt; then exit 1; else echo 'Soft link is broken after deleting original'; fi
id devops-student >/dev/null 2>&1 || sudo adduser --disabled-password --gecos 'DevOps homework test user' devops-student
id devops-student
getent passwd devops-student
sudo journalctl -u docker -n 10 --no-pager
whoami
hostname
pwd
ls -la
cat hard-link.txt
df -h /
free -h
ps -ef | sed -n '1,12p'
cd "$HOME/devops-sst/Shell Scripting"
printf 'Ritesh\n' | bash shell_script.sh
cd "$HOME/devops-sst/Networking"
ip -brief addr
ip route
ss -lnt
ping -c 2 example.com || true
dig example.com
nslookup example.com
curl --max-time 15 -I https://example.com
cd "$HOME/devops-sst/Git and GitHub"
mkdir -p git-demo
cd git-demo
git init
git checkout -b main
git config user.name 'Ritesh Prajapati'
git config user.email 'prajapatiritesh381@gmail.com'
printf 'version one\n' > tracked.txt
git add tracked.txt
git commit -m 'Create tracked example file'
printf 'version two\n' > tracked.txt
printf 'untracked file\n' > untracked.txt
git commit -a -m 'Automatically stage changes to tracked file'
git status --short
git add untracked.txt
git commit -m 'Explicitly add the untracked file'
git switch -c feature
printf 'Selected feature change\n' > selected.txt
git add selected.txt
git commit -m 'Add feature selected for cherry-pick'
selected_commit=$(git rev-parse HEAD)
printf 'Other feature change\n' > other.txt
git add other.txt
git commit -m 'Add a separate feature change'
git switch main
git cherry-pick "$selected_commit"
git log --oneline --all --graph
cat selected.txt
test ! -f other.txt
git status --short
