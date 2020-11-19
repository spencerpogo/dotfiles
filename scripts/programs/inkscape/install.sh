#!/bin/bash

if [ ! $(command -v inkscape) ]; then
  aptinst inkscape
fi
