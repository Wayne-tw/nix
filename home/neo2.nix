{ config, lib, pkgs, ... }:
with lib; {
  config = {
    system.activationScripts.extraActivation.text = ''
      echo "copying Neo layout"
      cp ${./neo.icns} "/Library/Keyboard Layouts/neo.icns"
      cp ${./neo.keylayout} "/Library/Keyboard Layouts/neo.keylayout"
    '';
  };

  # TODO need additional configuration of karabiner-elements
}
