{ ... }:
{
  programs.opencode = {
    enable = true;
  };
  xdg.configFile."opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    provider.ollama = {
      npm = "@ai-sdk/openai-compatible";
      name = "Ollama (local)";
      options.baseURL = "http://127.0.0.1:11434/v1";
      models = {
        "qwen3.5:9b".name = "Qwen 3.5 9b";
        "qwen3-coder:30b".name = "Qwen Coder 30b";
      };

      agent = {
        general.disable = true;
        explore.disable = true;
        scout.disable = true;
      };
    };
  };
}
