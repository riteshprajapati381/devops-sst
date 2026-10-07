# Linux Fundamentals

## Hard and soft links

A hard link shares the original file's inode and still works after the original filename is deleted. A soft link points to a path and breaks when its target is deleted.

```bash
echo 'Linux link exercise' > original.txt
ln original.txt hard-link.txt
ln -s original.txt soft-link.txt
ls -li original.txt hard-link.txt soft-link.txt
rm original.txt
cat hard-link.txt
cat soft-link.txt
```

## User creation

`adduser` sets up a user interactively. `useradd` uses options such as `-m` for a home directory and `-s` for the shell.

```bash
sudo adduser --disabled-password --gecos 'DevOps homework test user' devops-student
id devops-student
getent passwd devops-student
```

## Logs and basic commands

`journalctl` reads systemd logs. `-u` selects a service, `-n` limits entries and `-f` follows new logs.

```bash
sudo journalctl -u docker -n 10 --no-pager
```

| Command | Purpose |
|---|---|
| whoami, hostname, pwd | Show user, host and current directory |
| ls -la, ls -li | Show files, permissions and inodes |
| mkdir, touch | Create directories and files |
| cat, rm | Read or remove files |
| df -h, free -h | Check disk and memory |
| ps -ef | List processes |

Result: link behavior verified, test user created and Docker logs checked.

## Screenshots

![Linux links user](output/screenshots/linux-links-user.png)

![Linux system logs](output/screenshots/linux-system-logs.png)

## Command output

- [session02 05](output/logs/session02-05.log)
