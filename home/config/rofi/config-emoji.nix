{ ... }:

{
  home.file.".config/rofi/config-emoji.rasi".text = ''
    @import "~/.config/rofi/config.rasi" 
    
    window {
      width: 50%;
    }

    listview {
      columns: 1;
      lines: 8;
      scrollbar: true;
    }

    entry {
      width: 45%;
      placeholder: "🔎 Search Emoji's 👀";
    }
  '';
}