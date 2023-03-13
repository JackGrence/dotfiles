#!/usr/bin/env python3
import tomllib
import platform
import subprocess
import argparse


# setup.py --platform=xxx
parser = argparse.ArgumentParser(description='Manage dotfiles.')
parser.add_argument('-m', '--mode', choices=['install', 'update', 'diff'],
                    default='install', help='''
                    install: Install the config for first setup (default) |
                    update: Copy the config files to home directory |
                    diff: Copy the config files back from home directory
                    ''')
parser.add_argument('-p', '--platform',
                    help='platform name (default: host platform)')
parser.add_argument('-c', '--config', required=False,
                    help='config folder (default: all from config.toml)')
args = parser.parse_args()

with open('config.toml', 'rb') as f:
    config = tomllib.load(f)

plat = platform.system() if not args.platform else args.platform
config = config[plat]

result = ''
if not args.config:
    for conf in config['configs']:
        proc = subprocess.run(f'{conf}/{config["setup"]} {args.mode}',
                              shell=True)
        result += '[O]' if proc.returncode == 0 else '[X]'
        result += f' {conf}\n'
else:
    proc = subprocess.run(f'{args.config}/{config["setup"]} {args.mode}',
                          shell=True)
    result += '[O]' if proc.returncode == 0 else '[X]'
    result += f' {args.config}\n'
print(result)
