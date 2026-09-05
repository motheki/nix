# Profiles compose capabilities; they contain no program implementation.
{den, ...}: {
  den.aspects.profiles = {
    workstation.includes = with den.aspects.features; [
      applications
      command-line
      development
      fonts
      llm-tools
      maintenance
      media
      shell
      utilities
      version-control
      editor-navigation
    ];
    editor-full.includes = with den.aspects.features; [
      editor-web
      editor-systems
      editor-data
      editor-scripting
    ];
    mobile-developer.includes = [den.aspects.features.mobile-development];
  };
}
