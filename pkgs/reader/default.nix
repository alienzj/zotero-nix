{
  buildNpmPackage,
  fetchFromGitHub,
  callPackage,
}:

buildNpmPackage rec {
  pname = "zotero-reader";
  version = builtins.substring 0 9 src.rev;

  src = fetchFromGitHub {
    owner = "zotero";
    repo = "reader";
    rev = "533ccd38ca0f2f5ab3c5be277516a4dba581629c";
    hash = "sha256-O1GESF75Ag/eaU9+j02lMQMAFXfbnsgI1KEhEfJ4L1U=";
  };

  npmDepsHash = "sha256-zOcXOio2VLzElHf5LtJO4XcBDLV5WGgYAeRjFrbUsNE=";
  npmRebuildFlags = [ "--ignore-scripts" ];

  # Avoid npm install since it is handled by buildNpmPackage
  postPatch = ''
    sed -i pdfjs/build \
      -e 's/npx gulp/#npx gulp/g' \
      -e 's/npm ci/#npm ci/g'
  '';

  buildPhase = ''
    rm -rf pdf.js
    cp -Lr ${callPackage ./pdfjs.nix { }}/lib/node_modules/pdf.js pdfjs
  '';

  preInstall = ''
    mkdir -p $out/lib/node_modules/pdf-reader
    cp -r node_modules $out/lib/node_modules/pdf-reader/node_modules
  '';
}
