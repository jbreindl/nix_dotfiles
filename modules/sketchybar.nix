{ pkgs, ... }:
let
  sketchybar = "${pkgs.sketchybar}/bin/sketchybar";
  aerospace = "${pkgs.aerospace}/bin/aerospace";

  workspaceScript = pkgs.writeShellScript "workspace.sh" ''
    if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
      ${sketchybar} --set "$NAME" background.drawing=on label.color=0xff1e1e2e
    else
      ${sketchybar} --set "$NAME" background.drawing=off label.color=0xffcdd6f4
    fi
  '';

  frontAppScript = pkgs.writeShellScript "front_app.sh" ''
    if [ "$SENDER" = "front_app_switched" ]; then
      ${sketchybar} --set "$NAME" label="$INFO"
    fi
  '';

  clockScript = pkgs.writeShellScript "clock.sh" ''
    ${sketchybar} --set "$NAME" label="$(date '+%a %d %b  %H:%M')"
  '';

  batteryScript = pkgs.writeShellScript "battery.sh" ''
    BATT="$(/usr/bin/pmset -g batt)"
    PERCENT="$(echo "$BATT" | grep -Eo '[0-9]+%' | head -1)"
    if echo "$BATT" | grep -q 'AC Power'; then
      ${sketchybar} --set "$NAME" label="⚡ $PERCENT"
    else
      ${sketchybar} --set "$NAME" label="$PERCENT"
    fi
  '';
in
{
  services.sketchybar = {
    enable = false;
    config = ''
              #!/usr/bin/env bash

              ${sketchybar} --bar position=top height=32 color=0xff1e1e2e \
                                 padding_left=8 padding_right=8

              ${sketchybar} --default \
                updates=when_shown \
                label.font="Helvetica Neue:Bold:13.0" \
                label.color=0xffcdd6f4 \
                padding_left=4 padding_right=4

              # Workspaces 1-10 (matches your keybindings)
              ${sketchybar} --add event aerospace_workspace_change
              for sid in 1 2 3 4 5; do
                ${sketchybar} --add item "space.$sid" left \
                  --subscribe "space.$sid" aerospace_workspace_change \
                  --set "space.$sid" \
                    label="$sid" \
                    label.padding_left=8 label.padding_right=8 \
                    background.color=0xff89b4fa \
                    background.corner_radius=6 \
                    background.height=22 \
                    background.drawing=off \
                    click_script="${aerospace} workspace $sid" \
                    script="${workspaceScript} $sid"
              done

              ${sketchybar} --add item front_app left \
                --subscribe front_app front_app_switched \
                --set front_app padding_left=12 script="${frontAppScript}"

              # Right side: first added is rightmost
              ${sketchybar} --add item clock right \
                --set clock update_freq=10 script="${clockScript}"

            ${sketchybar} --add alias "Control Center,WiFi" right
            ${sketchybar} --add alias "Control Center,Bluetooth" right
              ${sketchybar} --trigger aerospace_workspace_change \
                FOCUSED_WORKSPACE="$(${aerospace} list-workspaces --focused)"
              ${sketchybar} --update
      ${sketchybar} --set front_app label="$(${aerospace} list-windows --focused --format '%{app-name}')"
    '';
  };
}
