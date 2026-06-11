{ ... }:
let
  leader = "Ctrl g";
in
{
  xdg.configFile."zellij/layouts/dev.kdl".source = ./dev.kdl;
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-latte";
      default_mode = "locked";
      show_startup_tips = false;
      # TODO set up default layouts
    };
    extraConfig = ''

      // If you'd like to override the default keybindings completely, be sure to change "keybinds" to "keybinds clear-defaults=true"
      keybinds clear-defaults=true{
          normal {
              bind "q" { Quit; }
              bind "p" { SwitchToMode "Pane"; }
              bind "n" { SwitchToMode "Resize"; }
              bind "s" { SwitchToMode "Scroll"; }
              bind "o" { SwitchToMode "Session"; }
              bind "t" { SwitchToMode "Tab"; }
              bind "h" { SwitchToMode "Move"; }
              bind "b" { SwitchToMode "Tmux"; }
          }
          shared_except "normal" {
              bind "Ctrl g" { SwitchToMode "Normal"; }
          }
          resize {
              bind "h" { Resize "Increase Left"; }
              bind "j" { Resize "Increase Down"; }
              bind "k" { Resize "Increase Up"; }
              bind "l" { Resize "Increase Right"; }
              bind "H" { Resize "Decrease Left"; }
              bind "J" { Resize "Decrease Down"; }
              bind "K" { Resize "Decrease Up"; }
              bind "L" { Resize "Decrease Right"; }
              bind "=" "+" { Resize "Increase"; }
              bind "-" { Resize "Decrease"; }
          }
          pane {
              bind "h" { MoveFocus "Left"; }
              bind "l" { MoveFocus "Right"; }
              bind "j" { MoveFocus "Down"; }
              bind "k" { MoveFocus "Up"; }
              bind "p" { SwitchFocus; }
              bind "n" { NewPane; SwitchToMode "Locked"; }
              bind "d" { NewPane "Down"; SwitchToMode "Locked"; }
              bind "r" { NewPane "Right"; SwitchToMode "Locked"; }
              bind "s" { NewPane "stacked"; SwitchToMode "Locked"; }
              bind "x" { CloseFocus; SwitchToMode "Locked"; }
              bind "f" { ToggleFocusFullscreen; SwitchToMode "Locked"; }
              bind "z" { TogglePaneFrames; SwitchToMode "Locked"; }
              bind "w" { ToggleFloatingPanes; SwitchToMode "Locked"; }
              bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Locked"; }
              bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0;}
              bind "i" { TogglePanePinned; SwitchToMode "Normal"; }
              bind "f" { ToggleFloatingPanes; }
          }
          move {
              bind "n" "Tab" { MovePane; }
              bind "p" { MovePaneBackwards; }
              bind "h" "Left" { MovePane "Left"; }
              bind "j" "Down" { MovePane "Down"; }
              bind "k" "Up" { MovePane "Up"; }
              bind "l" "Right" { MovePane "Right"; }
          }
          tab {
              bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
              bind "h" "Left" "Up" "k" { GoToPreviousTab; }
              bind "l" "Right" "Down" "j" { GoToNextTab; }
              bind "n" { NewTab; SwitchToMode "Locked"; }
              bind "x" { CloseTab; SwitchToMode "Locked"; }
              bind "s" { ToggleActiveSyncTab; SwitchToMode "Locked"; }
              bind "b" { BreakPane; SwitchToMode "Locked"; }
              bind "]" { BreakPaneRight; SwitchToMode "Locked"; }
              bind "[" { BreakPaneLeft; SwitchToMode "Locked"; }
              bind "1" { GoToTab 1; SwitchToMode "Locked"; }
              bind "2" { GoToTab 2; SwitchToMode "Locked"; }
              bind "3" { GoToTab 3; SwitchToMode "Locked"; }
              bind "4" { GoToTab 4; SwitchToMode "Locked"; }
              bind "5" { GoToTab 5; SwitchToMode "Locked"; }
              bind "6" { GoToTab 6; SwitchToMode "Locked"; }
              bind "7" { GoToTab 7; SwitchToMode "Locked"; }
              bind "8" { GoToTab 8; SwitchToMode "Locked"; }
              bind "9" { GoToTab 9; SwitchToMode "Locked"; }
              bind "Tab" { ToggleTab; }
          }
          scroll {
              bind "e" { EditScrollback; SwitchToMode "Normal"; }
              bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
              bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
              bind "j" "Down" { ScrollDown; }
              bind "k" "Up" { ScrollUp; }
              bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
              bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
              bind "d" { HalfPageScrollDown; }
              bind "u" { HalfPageScrollUp; }
              // uncomment this and adjust key if using copy_on_select=false
              // bind "Alt c" { Copy; }
          }
          search {
              // bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
              // bind "j" "Down" { ScrollDown; }
              // bind "k" "Up" { ScrollUp; }
              // bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
              // bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
              // bind "d" { HalfPageScrollDown; }
              // bind "u" { HalfPageScrollUp; }
              // bind "n" { Search "down"; }
              // bind "p" { Search "up"; }
              // bind "c" { SearchToggleOption "CaseSensitivity"; }
              // bind "w" { SearchToggleOption "Wrap"; }
              // bind "o" { SearchToggleOption "WholeWord"; }
          }
          entersearch {
              //bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
              //bind "Enter" { SwitchToMode "Search"; }
          }
          renametab {
              //bind "Ctrl c" { SwitchToMode "Normal"; }
              //bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
          }
          renamepane {
              //bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
          }
          session {
              //bind "Ctrl s" { SwitchToMode "Scroll"; }
              bind "d" { Detach; }
              bind "w" {
                  LaunchOrFocusPlugin "session-manager" {
                      floating true
                      move_to_focused_tab true
                  };
                  SwitchToMode "Locked"
              }
              bind "a" {
                  LaunchOrFocusPlugin "zellij:about" {
                      floating true
                      move_to_focused_tab true
                  };
                  SwitchToMode "Normal"
              }
          }
          shared_except "locked" {
              bind "Esc" { SwitchToMode "Locked"; }
              //bind "Alt h" { MoveFocusOrTab "Left"; }
              //bind "Alt l"  { MoveFocusOrTab "Right"; }
              //bind "Alt j" "Alt Down" { MoveFocus "Down"; }
              //bind "Alt k" "Alt Up" { MoveFocus "Up"; }
          }
      }

      // Plugin aliases - can be used to change the implementation of Zellij
      // changing these requires a restart to take effect
      plugins {
          tab-bar location="zellij:tab-bar"
          status-bar location="zellij:status-bar"
          strider location="zellij:strider"
          compact-bar location="zellij:compact-bar"
          session-manager location="zellij:session-manager"
          welcome-screen location="zellij:session-manager" {
              welcome_screen true
          }
          filepicker location="zellij:strider" {
              cwd "/"
          }
          configuration location="zellij:configuration"
          plugin-manager location="zellij:plugin-manager"
          about location="zellij:about"
      }


    '';
  };
}
