#!/bin/bash

set -euo pipefail
shopt -s inherit_errexit

oldpwd=$(pwd)
mkdir -p ~/code
cd ~/code
set +e
<$oldpwd/ghrepos.txt xargs -n1 git clone
cd $oldpwd
