#!/bin/bash
export LC_COLLATE=C
shopt -s extglob

ls -F ./DB/ | grep /
. DB_main_menu.sh