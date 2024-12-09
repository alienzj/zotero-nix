{ buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "zotero-xpcom-utilities";
  version = builtins.substring 0 9 src.rev;

  src = fetchFromGitHub {
    owner = "zotero";
    repo = "utilities";
    rev = "c879fa18113646c18abc951ed86481bfc2b2d134";
    hash = "sha256-pwcPuyyUmTU4JlEknJt+OQybTNHfn/iUEkbH6hW1NVA=";
  };

  npmDepsHash = "sha256-tWDADhAeXG0HSvFnpdGOya3CjSb0i2aR3E1Y3r1J81o=";
  dontNpmBuild = true;
}
