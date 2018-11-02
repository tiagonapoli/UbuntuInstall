import subprocess
import os
import stat
import json

scripts= [ #("scripts/packages_install.sh", ""),
           #("scripts/docker_install.sh", ""),
           ("scripts/git_install.sh", "config/git.conf"),
           #("scripts/clone_repos.py", ""),
        #    ("scripts/nvidia_install_pre_reboot.sh", ""),
        #    ("scripts/nvidia_install_post_reboot0.sh", ""),
        #    ("scripts/nvidia_install_post_reboot1.sh", ""),
        #    ("scripts/cuda_install.sh", ""),
        #    ("scripts/nvidia_docker_install.sh", "")
        ]

def get_config(path):
    if(len(path) == 0):
        return {}
    with open(path) as f:
        data = json.load(f)
    return data

def print_header(text):
    text = text.split('/')[1]
    text = " Run " + text + " "
    a = "=" * len(text)
    b = "=" * 20
    print(b + a + b)
    print(b + text + b)
    print(b + a + b)    

def write_step(step):
    f=open("output/step.info", "w+")
    f.write(str(step))
    f.close() 

def read_step():
    if not os.path.isdir("output"):
        os.mkdir("output")
    if not os.path.exists("output/step.info"):
        write_step(0)
    f=open("output/step.info", "r+")
    last = int(f.read())
    f.close()
    return last

def make_executable(path):
    st = os.stat(path)
    os.chmod(path, st.st_mode | stat.S_IEXEC)

def main():

    last = read_step()
    for i in range(last, len(scripts)):
        print_header(scripts[i][0])
        make_executable(scripts[i][0]) 


        command = ["./" + scripts[i][0]]
        command.extend(list(get_config(scripts[i][1]).values()))
        process = subprocess.Popen(command)
        process.wait()
        print("Fim: {}".format(process.returncode))
        try:
            if(process.returncode != 0):
                raise Exception("Error on script {}".format(scripts[i]))
        except Exception as e:
            print(e)
            exit()
        write_step(i)

main()