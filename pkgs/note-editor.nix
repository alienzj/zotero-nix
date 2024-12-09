{ buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "zotero-note-editor";
  version = builtins.substring 0 9 src.rev;

  src = fetchFromGitHub {
    owner = "zotero";
    repo = "note-editor";
    rev = "0f4f218980ceed99639ae887b084c9b059ebd4d0";
    hash = "sha256-iLPllP55FUgmaM/mnSo6Q02dkUJeQacZj7ObjMvuIvE=";
  };

  npmDepsHash = "sha256-GjISb8XzW1ZxHwHG3ybhv0/ZUTcY99LsGslQ+9/iDBw=";

  postInstall = ''
    cp -r build $out/lib/node_modules/zotero-note-editor/build
  '';
}
