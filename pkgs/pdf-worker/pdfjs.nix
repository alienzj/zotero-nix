{
  buildNpmPackage,
  fetchFromGitHub,
  writeScriptBin,
}:

buildNpmPackage rec {
  pname = "zotero-pdf-worker-pdfjs";
  version = builtins.substring 0 9 src.rev;

  src = fetchFromGitHub {
    owner = "zotero";
    repo = "pdf.js";
    rev = "95d08fe7707553c23ce9f9c90371622a7aeb591f";
    hash = "sha256-KlKAIMENBxV73ikjJe6G8eFQ6t0pHZoc7VbhCVK5T0Y=";
  };

  npmDepsHash = "sha256-NsS6odvDBWXWXtDmmV3YqT8gtcwTqYtZwxawQWYMxbM=";
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
    node_modules/.bin/gulp lib-legacy
  '';

  postInstall = ''
    cp -r build $out/lib/node_modules/pdf.js/build
  '';
}
