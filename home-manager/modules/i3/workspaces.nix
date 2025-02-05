let
  esc = n: i: ''"${n}"'';
in
{
  ws0 = esc "0" ""; # discord
  ws1 = esc "1" "󰈹"; # firefox
  ws2 = esc "2" ""; # terminals
  ws3 = esc "3" ""; # editor
  ws4 = esc "4" "";
  ws5 = esc "5" "";
  ws6 = esc "6" "";
  ws7 = esc "7" "";
  ws8 = esc "8" ""; # steam
  ws9 = esc "9" ""; # game
  ws-icons = [
    "󰙯"
    "󰈹"
    ""
    ""
    ""
    ""
    ""
    "󰓇"
    ""
    ""
  ];
}
