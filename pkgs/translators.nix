{ buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "zotero-translators";
  version = builtins.substring 0 9 src.rev;

  src = fetchFromGitHub {
    owner = "zotero";
    repo = "translators";
    rev = "4cadb3e1455e6438b0b7c530d509cddca5f3e1c6";
    hash = "sha256-ZUHJmHMCcmasWr3ZTNGRrwhDZhbNt+7nyQQgZnZSmvc=";
  };

  npmDepsHash = "sha256-bC4HO492c+MSR2+LtyM4qTxZz1LwqPuYjqNgVuCVHYE=";

  # Avoid downloading binary in sandbox
  postPatch = ''
    echo "chromedriver_skip_download=true" >> .npmrc
  '';

  dontNpmBuild = true;
}
