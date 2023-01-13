#!/bin/bash

PUC=$(pacman -Qu | wc -l)
AUC=$(yay -Qu | wc -l)

ADD=$(($PUC+$AUC))
echo $ADD
