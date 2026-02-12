{pkgs, ...}: {
  services.ollama = {
    enable = true;
  };
  programs.claude-code = {
    enable = true;
    package = pkgs.claude-code-bin;
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
