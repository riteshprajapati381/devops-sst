"""Capture live SSH terminal and browser evidence using the Playwright CLI."""
import pathlib, subprocess, time, shlex, re
ROOT = pathlib.Path(__file__).resolve().parents[1]
PW = "/Users/riteshprajapati/.codex/skills/playwright/scripts/playwright_cli.sh"
HOST = "dev.devops-ritesh.riteshprajapati.coder"
def pw(session, *args):
    return subprocess.run([PW, "--session", session, *args], check=True, capture_output=True, text=True)
def ssh(command):
    return subprocess.run(["ssh", HOST, command], text=True, capture_output=True)
for app in ["nodejs-app", "python-app", "java-app", "Apache-app", "React-app", "nginx-app"]:
    print("BUILD", app, flush=True)
    marker = "/tmp/evidence-" + app
    cmd = "clear; set -o pipefail; bash ~/devops-sst/scripts/docker-app.sh " + shlex.quote(app) + " 2>&1 | tee ~/devops-sst/\"Docker Fundamentals\"/output/logs/" + app + ".log; echo EVIDENCE_DOCKER_" + app + ":$?"
    pw("devops", "type", cmd)
    pw("devops", "press", "Enter")
    for attempt in range(180):
        result = re.search(r'- generic[^\n]*: "?EVIDENCE_DOCKER_'+re.escape(app)+r':(\d+)', pw("devops", "snapshot").stdout)
        if result:
            if result.group(1) != "0":
                raise RuntimeError(app + " failed with status " + result.group(1))
            break
        time.sleep(3)
    else:
        raise RuntimeError(app + " build timed out")
    pw("devops", "screenshot", "--filename", str(ROOT / "Docker Fundamentals/output/playwright" / (app + "-terminal.png")))
    pw("app", "goto", "http://127.0.0.1:18080")
    time.sleep(2)
    pw("app", "screenshot", "--filename", str(ROOT / "Docker Fundamentals/output/playwright" / (app + "-browser.png")))
    print("CAPTURED", app, flush=True)
print("All six Docker applications captured", flush=True)
