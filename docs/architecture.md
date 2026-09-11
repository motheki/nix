# Architecture

## Ownership

- **flake-parts** owns standard outputs, checks, shells and operational packages.
- **flake-file** generates `flake.nix` from typed declarations. There is no second
  hand-maintained entry point.
- **Den** composes the host, user and feature aspects into nix-darwin/Home Manager.
- **nix-darwin** owns the daemon, system defaults, system launchd jobs and Brewfile.
- **Home Manager** owns user configuration and user launch agents.
- **nix-homebrew** owns Homebrew and immutable taps, including the existing Rosetta
  prefix. Do not let a manual `brew update` fight that ownership.
- **Vendor tools** own Xcode, Android SDKs/emulators and mutable application data.

The system and Home Manager share `pkgs`; NixVim also uses the global package set.
Flake-parts' tooling package set is separate. A shared nixpkgs revision does not
magically memoize every external flake's package-set evaluation.

## Aspect boundaries

Hosts select system capabilities and hardware policy. Users select profiles and
own personal identities/paths. Profiles contain only `includes`. Features contain
related implementation across module classes.

For example, `features.mobile-development` contributes Android Studio/CocoaPods to
the host and SDK paths/fastlane to the user. It does not require duplicated lists
in unrelated shell and Homebrew modules.

With the pinned Den version, user-selected aspects contribute their Darwin class
to the host. A host-selected aspect's Home Manager class does not automatically
configure every user. Maintenance is therefore selected through the workstation
profile so both its user and system jobs are present. Policy checks protect this.

## Feature selection

Edit `modules/aspects/users/motheki.nix` or the profiles it selects:

| Feature/profile | Purpose | Default |
| --- | --- | --- |
| `profiles.workstation` | Applications, shell, VCS, utilities, AI tools, media, maintenance, editor core/navigation | On |
| `profiles.editor-full` | Existing web, systems, data and scripting language-server groups | On |
| `profiles.mobile-developer` | Android Studio, CocoaPods, fastlane, SDK paths | On |
| `features.editor-web` | JSON, HTML, Svelte, Tailwind, Oxlint/Oxfmt | Via editor-full |
| `features.editor-systems` | Go, Rust, Zig language servers | Via editor-full |
| `features.editor-data` | PostgreSQL and SQL servers | Via editor-full |
| `features.editor-scripting` | PHP, Ruby, Python servers | Via editor-full |
| `features.editor-extras` | Telescope, Television, which-key, none-ls alternatives | Off |
| `features.fonts-extra` | Agave, Geist, Blex, JetBrains, Monaspace families | Off |
| `features.linux-builder` | Native ARM Linux builder VM | Off; select in host |

The default navigation setup uses fff for fast file search, mini.pick for generic
pickers, and mini.clue for key hints. The alternative integrations remain defined
but no longer load redundantly. Existing language-server coverage is retained.
Treesitter grammars come from the NixVim build rather than runtime auto-install.
Server-specific root detection replaces the blanket `.git` root override.

Java/Gradle and Rust/Cargo/Go/Zig development tools are accessible through
`devShells.mobile` and `devShells.systems`. Language servers may still retain
compilers in the system closure; removing a global package alone does not remove
all reverse dependencies.

For project-specific, reproducible environments, prefer a project-owned flake or
devenv file with its own lock. The repository shells are convenient shared
starting points. With nix-direnv, an explicitly approved project `.envrc` can use
`use flake /absolute/path/to/this/repo#mobile --impure`; do not mix it with mise for the same
language in the same project. Mise remains available through `mise exec` or a
project's `use mise`, without competing prompt activation.

## Application and font policy

Nix owns Discord, OrbStack, IINA, WebTorrent and Ghostty; Homebrew owns the declared
casks. `zen-browser` was removed because the pinned tap renames it to `zen`, which
was already listed. The canonical-cask check catches future stale aliases.
Home Manager copies Nix applications into `~/Applications/home-manager` for
Spotlight integration, retaining its permission and checksum checks.

CommitMono Nerd Font is installed and used by Ghostty. The former custom
`CommitMonoMotheki` family was not declared by this repo. Add the custom font
explicitly before selecting that name again. The larger font collection can be
restored with `features.fonts-extra`.

Full FFmpeg/ImageMagick capabilities and existing apps are retained. Codec removal,
Rosetta removal and application replacement require workload-specific evidence.

## Dependency policy

Every upstream source is declared directly in `modules/inputs.nix` with a floating
GitHub URL. This includes core APIs, llm-agents, nix-homebrew, Homebrew itself and
all tap sources. No declaration hard-codes a commit or release tag. The generated
`flake.nix` is therefore a complete dependency inventory, and `flake.lock` is the
single reproducibility boundary reviewed in version control.

The llm-agents input supplies fx, Pi, Codex, Herdr, OpenCode and related packages.
It follows this configuration's nixpkgs, flake-parts and treefmt-nix inputs, so one
broad flake update advances the package source and its shared foundations together.
This avoids the stale indirection that occurred when llm-agents was resolved from
an OmniFlake index snapshot. nix-homebrew similarly follows the direct `brew-src`
input. Policy checks verify these shared revisions and reject reintroducing the
OmniFlake indirection.

`update-all` refreshes the entire lock graph. The narrower `update-core`,
`update-tools` and `update-homebrew` commands are review conveniences, not separate
dependency mechanisms. The manifest is evaluated on demand and reports the exact
direct revisions and hashes; it is not checked in as a stale duplicate. New
upstream releases still require a lock update and a reviewed switch—Nix never
silently mutates an activated system.

## Mutable agent profiles

Native Home Manager generators remain the source of declared fx MCP/settings/AGENTS,
Codex config/AGENTS and OpenCode opencode/tui/AGENTS content. Their corresponding
`file.enable = false` settings disable immutable links, not the generators.
`modules/_lib/client-profiles.nix` packages the merger with Nix
`writeShellApplication`: activation validates all configs before `writeBoundary`,
then applies through Home Manager's `run` after `writeBoundary` and before
`linkGeneration`. There are no client wrappers, second homes or manual migration
commands; changes apply only on an explicit switch, never shell entry or build.

The merger combines declared settings, replaces only declared MCP server identities
and preserves other servers/preferences and user text around the marked context
block. Exact FFF permissions are appended last, preserving other rules. Existing
OpenCode `.jsonc` companions are merged too, so they cannot shadow FFF. Runtime
inputs are never read into the Nix store; packaged `yq-go` and `pyjson5` handle
TOML/JSONC. See [operations](operations.md#agent-profiles) for file safety and recovery.

FFF uses `/opt/homebrew/bin/fff-mcp` in the client's workspace, without a fixed cwd
or home/root scanning; global guidance prefers `find_files`, `grep` and `multi_grep`
while retaining direct known-path reads and scoped fallbacks. Permissions are
limited to these search tools, not blanket approval.
[Pi's native FFF extension](https://github.com/dmtrKovalenko/fff/tree/main/packages/pi-fff)
is separate and not installed here; [fx ACP hosts supply MCP](https://fx.sh/docs/capabilities/mcp.md)
rather than inheriting the global profile.

## Nix-native operational tooling

The public interface remains `nix run .#<command>`. Command names, argument policy,
update groups and runtime dependencies are data in `_lib/command-specs.nix`.
`_lib/command-apps.nix` compiles them with `pkgs.writeShellApplication`, which adds
strict Bash settings, pinned tools and automatic ShellCheck. Small amounts of
shell remain necessary to execute CLI tools and handle runtime arguments; there
is no standalone dispatcher or setup script.

`_lib/command-diagram.nix` renders Den's actual trace to deterministic Mermaid
using pure Nix. `tests/commands.nix` uses `lib.runTests` for data/renderer checks
and an isolated Nix derivation for mocked CLI behavior, including negative safety
cases. It cannot call real sudo, Nix cleanup or Homebrew. There is no standalone
Python setup or test code; profile parsing uses packaged dependencies.

`checks.host-policy` forces the complete host derivation and checks evaluated
nix-darwin/Home Manager options, including shell integration and narrow FFF
permissions. `checks.command-wrappers` builds each production application and
runs only its help. `checks.fff-profiles` exercises the entire profile merger,
including preservation, permissions, JSONC companions, backups, idempotence and
unsafe-path/malformed-config rejection, rather than only fx settings; it also
loads the fx result in the pinned CLI. Treefmt and flake-file contribute their own
checks.

## Diagrams and extension

`nix run .#diagram > /tmp/aspects.mmd` renders actual Den resolution parent edges.
It uses the pinned `den.lib.capture` API, not the different `den.lib.diag` API shown
in some live documentation. No browser, Graphviz or extra diagram framework is
needed. View the Mermaid output with your preferred renderer.

Add modules under `modules/`; put raw helper files in underscore-prefixed paths.
Use named module arguments and avoid overlays unless a package really needs to be
changed in the shared `pkgs`. Do not enable advanced Home Manager minimal mode or
replace Nix with the research dnx runtime merely to reduce abstraction count.

## References

- [Home Manager options](https://nix-community.github.io/home-manager/options/home-manager/index.html)
- [Denful](https://denful.dev/) and [Den aspects](https://den.denful.dev/explanation/aspects/)
- [nix-darwin manual](https://nix-darwin.github.io/nix-darwin/manual/)
- [Nix flake lock files](https://nix.dev/manual/nix/latest/command-ref/new-cli/nix3-flake-update)
- [flake-parts](https://flake.parts/) and [treefmt-nix module](https://flake.parts/options/treefmt-nix)
- [devenv with flake-parts](https://devenv.sh/guides/using-with-flake-parts/)
- [nix-direnv caching and file watching](https://github.com/nix-community/nix-direnv#readme)
