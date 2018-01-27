#!/bin/bash

#Clone the COSSIM sub-parts
mkdir $HOME/COSSIM
cd $HOME/COSSIM
git clone https://github.com/H2020-COSSIM/cgem5
git clone https://github.com/H2020-COSSIM/cCERTI
git clone https://github.com/H2020-COSSIM/OMNETPP_COSSIM_workspace
git clone https://github.com/H2020-COSSIM/cMcPAT
git clone https://github.com/H2020-COSSIM/COSSIM_GUI
mv -f $HOME/COSSIM/cMcPAT/ $HOME/COSSIM/cgem5/McPat

# Installing cCERTI & Our SynchServer
cd $HOME/COSSIM/cCERTI
mkdir build_certi
cd build_certi
cmake -DCMAKE_INSTALL_PREFIX=$HOME/COSSIM/cCERTI/build_certi $HOME/COSSIM/cCERTI
make
make install

cd $HOME/COSSIM/cCERTI/SynchServer
./build.sh
cd $HOME/COSSIM/cCERTI
cp Federation.fed $HOME/COSSIM/cCERTI/build_certi/share/federations

echo "#cCERTI exports" >> ~/.bashrc
echo "export CERTI_HOME=$HOME/COSSIM/cCERTI/build_certi" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/COSSIM/cCERTI/build_certi/lib" >> ~/.bashrc
echo "export PATH=$HOME/COSSIM/cCERTI/build_certi:$PATH" >> ~/.bashrc
echo "export PATH=$HOME/COSSIM/cCERTI/build_certi/bin:$PATH" >> ~/.bashrc
echo "export CERTI_SOURCE_DIRECTORY=$HOME/COSSIM/cCERTI" >> ~/.bashrc
echo "export CERTI_BINARY_DIRECTORY=$HOME/COSSIM/cCERTI/build_certi" >> ~/.bashrc
echo "#change CERTI_HOST if you want to use HLA Server (rtig) and SynchServer from another machine" >> ~/.bashrc
echo "export CERTI_HOST=127.0.0.1" >> ~/.bashrc

export CERTI_HOME=$HOME/COSSIM/cCERTI/build_certi
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/COSSIM/cCERTI/build_certi/lib
export PATH=$HOME/COSSIM/cCERTI/build_certi:$PATH
export PATH=$HOME/COSSIM/cCERTI/build_certi/bin:$PATH
export CERTI_SOURCE_DIRECTORY=$HOME/COSSIM/cCERTI
export CERTI_BINARY_DIRECTORY=$HOME/COSSIM/cCERTI/build_certi
export CERTI_HOST=127.0.0.1

# Installing cgem5
export GEM5=$HOME/COSSIM/cgem5
export M5_PATH=$HOME/COSSIM/kernels

echo "#GEM5 exports" >> ~/.bashrc
echo "export GEM5=$HOME/COSSIM/cgem5" >> ~/.bashrc
echo "export M5_PATH=$HOME/COSSIM/kernels" >> ~/.bashrc
cd $HOME/COSSIM/cgem5
source ~/.bashrc
scons build/ARM/gem5.opt -j4
scons build/X86/gem5.opt -j4

mv $HOME/kernels.tar.gz $HOME/COSSIM
cd $HOME/COSSIM
tar -zxvf kernels.tar.gz

# Installing cMcPat
cd $HOME/COSSIM/cgem5/McPat/mcpat
make all
cd $HOME/COSSIM/cgem5/McPat/Scripts
chmod +x GEM5ToMcPAT.py
chmod +x print_energy.py


# Installing cOMNET++
cd $HOME
tar xvfz omnetpp-5.0-src.tgz
cd omnetpp-5.0
export PATH=$PATH:$HOME/omnetpp-5.0/bin
export OMNETWP=$HOME/COSSIM/OMNETPP_COSSIM_workspace/OMNET_WORKSPACE

./configure && make

cp -R $HOME/COSSIM/COSSIM_GUI/* $HOME/omnetpp-5.0/ide/dropins

mkdir $HOME/COSSIM/OMNETPP_COSSIM_workspace/OMNET_WORKSPACE/HLANode/simulations
echo "export PATH=$PATH:$HOME/omnetpp-5.0/bin" >> ~/.bashrc
echo "export OMNETWP=$HOME/COSSIM/OMNETPP_COSSIM_workspace/OMNET_WORKSPACE" >> ~/.bashrc
source ~/.bashrc
