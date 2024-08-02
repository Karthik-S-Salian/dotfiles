/* Rofi Config for Google Search */
{ ... }:

{
  home.file.".config/rofi/config-search.rasi".text = ''
    
    @import "~/.config/rofi/config.rasi" 

    /* ---- Window ---- */
    window {
        width: 40%;
        y-offset: 6px;
        location: north;
    }

    /* ---- Inputbar ---- */
    inputbar {
        enabled: true;
    }

    /* ---- Mainbox ---- */
    mainbox {
        padding: 0px;
        children: [ "entry"];
    }

    /* ---- Entry ---- */ 
    entry {
        padding: 5px 10px;
        placeholder: "🔎 Google Search";
        text-color: #FFFFFFFF;
        background:     #1E1F29FF;
    }

  '';
}

