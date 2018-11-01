#!/usr/bin/python3
import os
import json
import subprocess
from os.path import expanduser

def clone(repo, callback):
    home = expanduser('~')
    if(os.path.isdir(home + "/Documents/" + repo.split('/')[-1].replace('.git',''))):
        print(repo + " Already exists...")
        return
    
    callback = callback.strip().replace('~', home)
    print("Cloning ", repo, " ...")    
    try:
        process = subprocess.Popen(["git", "clone", repo, home + "/Documents/" + repo.split('/')[-1].replace('.git','')])
        process.wait()
        if(process.returncode != 0):
            raise Exception("Error on script " + __file__ + ". Couldn't clone repository " + repo)
    except Exception as e:
        print(e)
        exit()

    if(len(callback) == 0):
        return
        
    print("Execute callback: " + callback)
    try:
        process = subprocess.Popen(callback.split(' '))
        process.wait()
        if(process.returncode != 0):
            raise Exception("Error on script " + __file__ + ". Couldn't run callback \"" + callback + "\"")
    except Exception as e:
        print(e)
        print("Remove cloned repo") 
        process = subprocess.Popen(["rm", "-rf", home + "/Documents/" + repo.split('/')[-1].replace('.git','')])
        process.wait()    
        exit()    

def main():
    with open("config/repositories_list.json") as f:
        data = json.load(f)['repos']

    for el in data:
        print("=============================================")
        clone(el['repo'], el['callback'])
        print("=============================================\n\n")

main()


