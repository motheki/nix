# Performance evidence and further tuning

## Measured during this refactor

Machine: Apple M1 Pro, 8 cores, 16 GiB RAM, macOS 27.0, Nix 2.34.8.

| Measurement | Before | Candidate |
| --- | --- | --- |
| Fully evaluated host derivation, warm sources | 13.5 s observed | 9.40–9.82 s, three serial runs |
| Same candidate with evaluation cache disabled | Not a controlled baseline | 9.40–9.64 s, three serial runs |
| Evaluation maximum RSS, cache enabled | Approximately 1.8 GiB | Approximately 1.76 GiB |
| System closure, `nix path-info -Sh` | 13.1 GiB active system | 11.4 GiB built candidate |
| Copied user applications | Approximately 1.7 GB | Copying retained; activation not measured |

The initial 29.9-second evaluation included source downloads and is not comparable
with the warm measurements. Earlier overlapping probes produced SQLite cache-busy
messages, so the candidate benchmark ran serially. The timing comparison is
indicative, not a controlled causal attribution or a guaranteed speedup.
Evaluation caching remains enabled: the true/false results are effectively equal,
and disabling the cache slightly increased measured memory consumption.

The closure is roughly 1.7 GiB smaller. This is a logical dependency-closure
comparison, not an APFS physical-space measurement. Old system generations,
project roots, and opt-in development shells can retain the same store objects.
No garbage collection or activation is needed to compare closure sizes, and no
space-saving claim should imply that rollback generations were deleted.

## Changes with direct effects

- Local build scheduling is bounded to two jobs and four cores per cooperative
  job, rather than eight jobs each potentially using eight cores. This is a
  conservative responsiveness setting, not a benchmark-proven throughput optimum.
- Java/Gradle moved out of the global profile into the mobile shell. Gradle's
  runtime is explicitly JDK 17 and project workers are capped at four. Both
  `java -version` and `gradle --version` were verified inside the shell.
- The systems shell provides project-scoped Rust/Cargo, Go and Zig. Rust-related
  language servers can still retain a compiler in the desktop closure.
- Only the everyday CommitMono font is selected; the large font collection is
  opt-in. Ghostty now references the declared font family.
- Redundant alternative editor integrations are opt-in. Existing language-server
  groups remain selected, with server-specific project-root detection. The built
  NixVim package passed a headless startup smoke test with isolated XDG directories.
- Direct core inputs and one shared flake-parts revision remove dependency-version
  divergence. No claim is made that every external `pkgs` evaluation is shared.
- Additional binary cache trust is limited to Numtide and nix-community, retaining
  the default NixOS cache. The full candidate host built successfully with the
  existing daemon; CI uses this reduced cache set. Per-cache hit rates were not
  benchmarked, so revisit this policy if real missing substitutes appear.
- Brew upgrades and destructive cleanup are absent from routine activation.
  Activation-time savings have not been measured because the candidate was not
  switched during implementation.

## Reproduce the measurements

```console
nix run .#benchmark
nix run .#build -- --max-jobs 2 --cores 4
nix path-info -Sh .#darwinConfigurations.mothekis-macbook-pro.system
nix path-info -Sh /run/current-system
```

For shell startup, after deliberately activating the candidate:

```console
hyperfine --warmup 3 --runs 10 'zsh -i -c exit'
```

Record whether a command uses the active system or the candidate, whether sources
were already downloaded, whether builds were substituted, and what else was
running. Do not run multiple evaluators against the same checkout while collecting
timings. Do not delete caches or rollback roots merely to manufacture a cold run.

To attribute large dependencies, use `nix why-depends` and `nix-tree`. Inspect
individual store-object sizes separately from transitive closure size; sums of
package closures double-count shared objects. Both JDK 17 and JDK 25 appeared in
the original system closure, so changing `JAVA_HOME` alone was not enough to remove
the second runtime.

## Remaining workload-dependent decisions

These are intentionally not guessed or applied indiscriminately:

- Remove `profiles.editor-full` and select only needed language groups to reduce
  editor dependencies further. Each group imports the editor core as required.
- Remove the media feature or narrow codecs only after checking actual FFmpeg and
  ImageMagick usage. Full codecs and all distinct desktop applications are retained.
- Remove Rosetta/Homebrew's Intel prefix only after identifying Intel-only tools.
- Enable a Linux builder only for real Linux build workloads, and account for its
  memory budget alongside Android emulators and OrbStack.
- Compare cache hits and derivation paths after llm-agents or its shared nixpkgs
  input changes; direct input tracking improves freshness but can change substitutes.
- Raise build concurrency only with a representative uncached workload while
  observing memory pressure, swap and interactive responsiveness. A cached rebuild
  does not meaningfully benchmark compiler parallelism.

The validation checks are built, not just evaluated. They cover formatting,
generated-flake consistency, host-policy invariants and isolated command behavior.
The GitHub workflow additionally builds the host on an ARM64 macOS runner. Its
remote execution, launchd activation, GUI app permissions and complete interactive
editor behavior still require their respective runtime environments.
