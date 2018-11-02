import subprocess
import os
import stat
import json

STEP_PATH = 'output/step.info'
INSTALATION_CONF = 'config/install.conf'

scripts= {'packages':       ("scripts/packages_install.sh", ""),
          'docker':         ("scripts/docker_install.sh", ""),
          'git':            ("scripts/git_install.sh", "config/git.conf"),
          'repos':          ("scripts/clone_repos.py", ""),
          'nvidia0':        ("scripts/nvidia_install_pre_reboot.sh", "config/nvidia.conf"),
          'nvidia1':        ("scripts/nvidia_install_post_reboot0.sh", "config/nvidia.conf"),
          'nvidia2':        ("scripts/nvidia_install_post_reboot1.sh", "config/nvidia.conf"),
          'cuda':           ("scripts/cuda_install.sh", "config/nvidia.conf"),
          'nvidia-docker':  ("scripts/nvidia_docker_install.sh", "")
}

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

def get_options():
    options = {
        "packages": ['packages'],
        "docker": ['docker'],
        "git": ['git'],
        "repos": ['repos'],
        "nvidia-driver": ['nvidia0', 'nvidia1', 'nvidia2'],
        "cuda": ['cuda'],
        "nvidia-docker": ['nvidia-docker']
    }

    ret = []
    opt = get_config(INSTALATION_CONF)
    for key,val in opt.items():
        if val:
            ret.extend(options[key])        
    return ret

def write_list(step_list):
    print("List to write ", step_list)
    f=open(STEP_PATH, "w+")
    for i in step_list:
        f.write(i + " ")
    f.close() 

def read_list():
    if not os.path.isdir(STEP_PATH.split('/')[0]):
        os.mkdir(STEP_PATH.split('/')[0])
    if not os.path.exists(STEP_PATH):
        write_list(get_options())

    with open(STEP_PATH) as f:
        lst = f.read().strip().split(' ') 
    f.close()
    if(lst[0] == ''):
        print("Instalation list empty")
        exit()
    return lst

def make_executable(path):
    st = os.stat(path)
    os.chmod(path, st.st_mode | stat.S_IEXEC)

def main():

    lst = read_list()
    for i in range(len(lst)):
        now = lst[i]
        print_header(scripts[now][0])
        make_executable(scripts[now][0]) 
        
        command = ["./" + scripts[now][0]]
        command.extend(list(get_config(scripts[now][1]).values()))
        print(command)
        process = subprocess.Popen(command)
        process.wait()
        try:
            if(process.returncode != 0):
                raise Exception("Error on script {}".format(scripts[now]))
        except Exception as e:
            print(e)
            exit()
        write_list(lst[i+1:])
    os.remove(STEP_PATH)

    
main()