{ ... }:
{
  services.ollama = {
    enable = true;
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "32768";
      OLLAMA_KEEP_ALIVE = "15m";
    };
  };
}
