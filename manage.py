#!/usr/bin/env python3
import os
import sys
import tomllib
import argparse
import subprocess
import shutil
import platform
from pathlib import Path

CONFIG_FILE = 'dotfiles.toml'

def load_config():
    with open(CONFIG_FILE, 'rb') as f:
        return tomllib.load(f)

def run_shell(command):
    print(f"Running: {command}")
    try:
        subprocess.check_call(command, shell=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running command: {command}")
        print(e)

def backup_file(path):
    if os.path.exists(path) or os.path.islink(path):
        backup_path = path + '.bak'
        print(f"Backing up {path} to {backup_path}")
        if os.path.exists(backup_path):
            if os.path.isdir(backup_path):
                shutil.rmtree(backup_path)
            else:
                os.remove(backup_path)
        os.rename(path, backup_path)

def link_file(source, target):
    source = os.path.abspath(source)
    target = os.path.expanduser(target)
    
    if os.path.islink(target):
        current_link = os.readlink(target)
        if current_link == source:
            print(f"Already linked: {target} -> {source}")
            return
        else:
            print(f"Incorrect link found: {target} -> {current_link}")
            backup_file(target)
    elif os.path.exists(target):
        backup_file(target)

    os.makedirs(os.path.dirname(target), exist_ok=True)
    os.symlink(source, target)
    print(f"Linked: {target} -> {source}")

def install_package(name, pkg_config, current_platform, only_link=False):
    if not only_link:
        print(f"Installing {name}...")
        install_cmd = pkg_config.get('install', {}).get(current_platform)
        if install_cmd:
            run_shell(install_cmd)
    
    print(f"Linking {name}...")
    links = pkg_config.get('links', {})
    for src, dst in links.items():
        link_file(src, dst)

def main():
    parser = argparse.ArgumentParser(description='Manage dotfiles')
    parser.add_argument('command', choices=['install', 'link', 'status'], default='install', nargs='?')
    parser.add_argument('packages', nargs='*', help='Specific packages to process')
    args = parser.parse_args()

    if not os.path.exists(CONFIG_FILE):
        print(f"Config file {CONFIG_FILE} not found.")
        sys.exit(1)

    config = load_config()
    current_platform = platform.system().lower()
    
    all_packages = config.get('packages', {})
    
    # Determine which packages to process
    if args.packages:
        selected_names = set(args.packages)
    else:
        selected_names = set(config.get('config', {}).get('enabled', all_packages.keys()))

    # Resolve dependencies for selected packages
    final_packages = set()
    
    def add_package_and_deps(name):
        if name in final_packages:
            return
        if name not in all_packages:
            print(f"Warning: Package '{name}' not found in configuration.")
            return
            
        final_packages.add(name)
        pkg = all_packages.get(name)
        for dep in pkg.get('depends_on', []):
            add_package_and_deps(dep)

    for name in selected_names:
        add_package_and_deps(name)

    # Sort final list topologically
    sorted_packages = []
    visited = set()
    
    def visit(name):
        if name in visited:
            return
        visited.add(name)
        pkg = all_packages.get(name)
        if not pkg:
            return
        for dep in pkg.get('depends_on', []):
            visit(dep)
        sorted_packages.append(name)

    for name in final_packages:
        visit(name)

    if args.command == 'install':
        for name in sorted_packages:
            install_package(name, all_packages[name], current_platform)
    elif args.command == 'link':
        for name in sorted_packages:
            install_package(name, all_packages[name], current_platform, only_link=True)
    elif args.command == 'status':
        print("Status check not implemented yet.")

if __name__ == '__main__':
    main()
