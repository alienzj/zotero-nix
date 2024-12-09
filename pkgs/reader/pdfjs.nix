{
  buildNpmPackage,
  fetchFromGitHub,
  writeScriptBin,
}:

buildNpmPackage rec {
  pname = "zotero-reader-pdfjs";
  version = builtins.substring 0 9 src.rev;

  src = fetchFromGitHub {
    owner = "zotero";
    repo = "pdf.js";
    rev = "cb447cb9182cc027e536893535e73ad1bc0816b1";
    hash = "sha256-/oNmVW8vGnKHUSbFSERQXvFnirVyY0aLEwLbBDGgA4w=";
  };

  npmDepsHash = "sha256-3a0lNwUxlHOnANq7MyefFCxDkc7PbWfXhUY6lf8U2Pc=";
  makeCacheWritable = true;

  nativeBuildInputs = [
    (writeScriptBin "prebuild" ''
      echo "Skip prebuild step."
    '')
  ];

  # Add a version number
  postPatch = ''
    sed -i package*.json -e '/"name": "pdf.js"/a "version": "1.0.0",'
  '';

  buildPhase = ''
    node_modules/.bin/gulp generic-legacy
    node_modules/.bin/gulp minified-legacy
  '';

  postInstall = ''
    cp -r build $out/lib/node_modules/pdf.js/build
  '';
}
