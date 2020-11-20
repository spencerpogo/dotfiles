#!/bin/bash

set -euo pipefail
shopt -s inherit_errexit

toss () {
  <&0 grep -v "$1"
}

<&0 cut -d ' ' -f 1 | 
  toss afgagenmapfioajbcjjfeodnaapeckhc | # Remove brave extensions: greaselion-7
  toss ahfgeienlihckogmohjhadlkjgocpleb | # Web Store
  toss ficffphkednpmhjngkiljamkalhjmclj | # greaselion-4
  toss kmendfapggjehodndflmmgagdbamhnfd | # CryptoTokenExtension
  toss mfehgcgbbipciphmccgaenjidiccnmng | # Cloud Print
  toss mhjfbmdgcfjbbpaeojofohoefgiehjai | # Chrome PDF Viewer
  toss mnojpmjdmbbfmejpflffifhffcmidifd | # Brave
  toss nkeimhogjdpnpccoofpliimaahmaaome | # Google Handgouts
  sed '/[^a-z]/d' | # Remove non-alphanumeric lines
  tee extensions.txt
