{...}: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
  programs.keychain = {
    enable = true;
    keys = ["trevoropiyo"];
  };
}
