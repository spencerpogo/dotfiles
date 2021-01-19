#!/bin/bash

# This script isn't part of the installation. It's just a utility that cleans up the
#  extensions copied from brave://system into the extensions.txt format, and removes
#  the stuff that isn't from the webstore

set -euo pipefail
shopt -s inherit_errexit

toss () {
  <&0 grep -v "$1"
}

<&0 cut -d ' ' -f 1 | 
  toss afgagenmapfioajbcjjfeodnaapeckhc | # Remove brave extensions: greaselion-7
  toss ahfgeienlihckogmohjhadlkjgocpleb | # Web Store
  toss eoceebklhjepohnakemchinmkdpbolgh | # greaselion-0
  toss bpkoijdaibakhfgahdfknbdcankhidoa | # greaselion-3
  toss ficffphkednpmhjngkiljamkalhjmclj | # greaselion-4
  toss gajhkmnhhoadjcfchafgbekhgigglnkp | # greaselion-8
  toss mjkjompjknhcipamakpfliebpggggpga | # greaselion-11
  toss feipjgjfhmnfhhmbkclfopokbcgnpnnd | # greaselion-13
  toss kmendfapggjehodndflmmgagdbamhnfd | # CryptoTokenExtension
  toss mfehgcgbbipciphmccgaenjidiccnmng | # Cloud Print
  toss mhjfbmdgcfjbbpaeojofohoefgiehjai | # Chrome PDF Viewer
  toss mnojpmjdmbbfmejpflffifhffcmidifd | # Brave
  toss nkeimhogjdpnpccoofpliimaahmaaome | # Google Handgouts
  sed '/[^a-z]/d' | # Remove non-alphanumeric lines
  tee extensions.txt
