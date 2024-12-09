{ buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "zotero-reader-epubjs";
  version = builtins.substring 0 9 src.rev;

  src = fetchFromGitHub {
    owner = "zotero";
    repo = "epub.js";
    rev = "93a4ea402ab36a5406bee699468d0bca691966f5";
    hash = "sha256-2ZqjJdcfK1AcBPiSx6QlU1HOF4A3doJqIQbiFHt4R20=";
  };

  npmDepsHash = "sha256-JYOEDX6SxB4Epwq5PZ5Y+EJO6UGKsOBIm2XIAqOwDO8=";
  npmRebuildFlags = [ "--ignore-scripts" ];
}
