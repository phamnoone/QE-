#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
echo "${green}Start install${reset}"
apt-get update
echo "${green}apt-get update complete${reset}"

echo y | apt-get install build-essential fftw3-dev gfortran
echo y | apt-get install xcrysden
# need select region
echo y | apt-get install gnuplot
echo "${green}apt-get install build-essential fftw3-dev gfortran xcrysden gnuplot complete${reset}"

echo "${green}Install open-mpi${reset}"

tar xf openmpi.tar.gz
# change name of folder for update version
mv openmpi-* openmpi

cd openmpi/
./configure --prefix=/usr/local/openmpi
make install
cd ..

echo 'PATH=$PATH:/usr/local/openmpi/bin' >> ~/.bashrc
echo 'export PATH' >> ~/.bashrc

echo "${green}Install lapack${reset}"
tar xf lapack.tar.gz
mv lapack-* lapack

cd lapack
pwd
echo "${green}make.inc.example make.inc${reset}"
cp make.inc.example make.inc

echo "${green}blaslib${reset}"
make blaslib
echo "${green}lapacklib${reset}"
make lapacklib
echo "${green}tmglib${reset}"
make tmglib

cp librefblas.a /usr/local/lib/libblas.a
cp liblapack.a /usr/local/lib/liblapack.a
cp libtmglib.a /usr/local/lib/libtmg.a

cd ..

echo "${green}Install Quantum Espresso${reset}"
tar -xzf qe.tgz

mv qe-* qe
cd qe
./configure --enable-parallel=no --enable-openmp=yes
make all

echo 'export PATH=$PATH:$(pwd)/bin/' >> ~/.bashrc

cd ..


echo "${green}Install Wannier90${reset}"
tar -xzf wannier.tar.gz
mv wannier90-* wannier
cd wannier
cp ./config/make.inc.gfort ./make.inc
make
cd ..


echo "${green}Complete${reset}"
