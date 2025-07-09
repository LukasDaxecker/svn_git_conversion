# Table of contents
1. [How to use](#usage)
   1. [Linux](#linux)
   2. [Windows](#windows)
2. [Known Issues](#issues)

# How to use <a name="usage"></a>

## Linux  <a name="linux"></a>

**Setup** <br>
chmod u+x ./convert.sh <br>
./conver.sh [svn-url] [repo-name]

**Needed libs**
```bash
sudo apt-get update
sudo apt upgrade
sudp apt install git
sudo apt-get install subversion
```

## Windows  <a name="windows"></a>

in progress...

# Known Issues   <a name="issues"></a>

1. Tags are often converted to branches
2. Problems finding the subversion equivalent to a .gitignore
3. There is not yet an option to convert the svn usernames to git usernames
