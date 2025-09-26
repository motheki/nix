{...}: {
  programs.tiny = {
    enable = true;
    settings = {
      servers = [
        {
          addr = "irc.libera.chat";
          port = 6697;
          tls = true;
          realname = "motheki";
          nicks = ["motheki"];
          alias = "LIBERA";
          join = ["##chat"];
        }
        {
          addr = "irc.oftc.net";
          port = 6697;
          tls = true;
          realname = "motheki";
          nicks = ["motheki"];
          alias = "OFTC";
          join = ["#tiny" "#asahi"];
        }
      ];
      defaults = {
        nicks = ["motheki"];
        realname = "motheki";
        join = [];
        tls = true;
      };
    };
  };
}
