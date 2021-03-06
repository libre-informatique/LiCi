#!/usr/bin/env bash
set -ex

if [ -z ${Project} ]
then
    Project=Platform
fi

# Branch
if [ -z ${Branch} ]
then
    Branch=master
fi

if [ -z ${LIREPOPATH} ]
then
    echo "Env Variable LIREPOPATH is mandatory, please set it"
    exit 42
fi



# WorkDir
workDir=$(mktemp -d) #mkdir ${workDir}
cd ${workDir}

# Target
if [ -z ${Target} ]
then
    Target=/tmp
fi

mkdir -p ${Target}
cd ${Target}
Target=$(pwd) #if previous dir was a relative or symbolic path

# Source
if [ -z ${Source} ]
then
    Source=${LIREPOPATH}/public/${Project}
fi
cd ${Source}
Source=$(pwd) #if previous dir was a relative or symbolic path

#Filename
if [ -z ${Filename} ]
then
    Filename=${Project}_${Branch}.tar.gz
fi

# todo: re-enable (or not)
#sha256sum -c ${Filename}.sha256.txt

cp ${Source}/${Filename} ${workDir}/

cd ${workDir}
tar -xf ${Filename}


# Todo, check if dir already exist or use a deploy tools
#if [ -d ${Target} ]
#then
#    mv ${Target} ${Target}$(date +'%Y%m%d%H%M%S')
#fi
mkdir -p ${Target}
cp -r ${workDir}/* ${Target}/

rm -rf ${workDir}
