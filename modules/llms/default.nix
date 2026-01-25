{pkgs, ...}: {
  services.ollama = {
    enable = true;
  };
  programs.opencode = {
    enable = true;
		settings = {
			theme = "system";
			autoupdate = true;
			autoshare = false;
		};
  };
}
