#!/bin/bash

## nettoyage
if [ -d ../libs/LIB_oven_BENCH ] 
then /bin/rm -rf ../libs/LIB_oven_BENCH
fi

## creation de la librairie de travail
vlib ../libs/LIB_oven_BENCH


## compilation
vcom -work LIB_oven_BENCH test_oven.vhd

