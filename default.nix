with import <nixpkgs> {};

stdenv.mkDerivation rec {
    name = "shadow-cljs-electron-example";
    env = buildEnv {
        name = name;
        paths = buildInputs;
    };

    buildInputs = [
        electron_8
        nodejs-10_x
        yarn
    ];

    shellHook = ''
      unset name
      export PATH=$PATH:$(yarn bin):$(npm bin)
      if $(which shadow-cljs 2> /dev/null); then
          echo "shadow-cljs is in $(which shadow-cljs)"
      else
          yarn add shadow-cljs
      fi

      alias watch='shadow-cljs watch main renderer'
      alias launch='electron .'

      cat default.nix | grep '^ \+\(function\|alias\) .\+'
    '';
}

