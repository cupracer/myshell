# myshell
my shell configuration and scripts

## Installation
```
export MYSHELL=/opt/myshell
git clone git@github.com:cupracer/myshell.git ${MYSHELL}
git -C ${MYSHELL} submodule update --init
```

```
export MYSHELL=/opt/myshell

echo "test -d /opt/myshell && export MYSHELL=/opt/myshell || true" >> ${HOME}/.bashrc
echo "test -d ${MYSHELL}/scripts && export PATH=\${MYSHELL}/scripts:\$PATH || true" >> ${HOME}/.bashrc
echo "test -s ${MYSHELL}/functions && . ${MYSHELL}/functions || true" >> ${HOME}/.bashrc
```

## configs
```
ln -sf /opt/myshell/configs/toprc ~/.toprc
ln -sf /opt/myshell/configs/vimrc ~/.vimrc
```

## vendor/imapsync
- required OpenSUSE repository (+ version directory): 
```
http://download.opensuse.org/repositories/devel:/languages:/perl/
```
- required OpenSUSE packages:
```
zypper in \
    perl-File-Copy-Recursive \
    perl-IO-Tee \
    perl-Mail-IMAPClient \
    perl-Term-ReadKey \
    perl-Unicode-String
```

Example:
```
/opt/myshell/vendor/imapsync/imapsync --host1 $SRCHOST --ssl1 --user1 $SRCUSER --passfile1 passfile1.txt --host2 $DSTHOST --ssl2 --user2 $DSTUSER --passfile2 passfile2.txt --delete2 --delete2duplicates
```

## vendor/MySQL-Tuner
Usage:
```
/opt/myshell/scripts/docker-run-MySQL-Tuner.sh <container> <name> <docker-network>
```
