{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    easyeffects
    ardour
  ];

  xdg.dataFile = {
    "easyeffects/output/Advanced Auto Gain.json".source =
      "${inputs.easyeffects-presets}/Advanced Auto Gain.json";

    "easyeffects/output/Bass Boosted.json".source =
      "${inputs.easyeffects-presets}/Bass Boosted.json";

    "easyeffects/output/Bass Enhancing + Perfect EQ.json".source =
      "${inputs.easyeffects-presets}/Bass Enhancing + Perfect EQ.json";

    "easyeffects/output/Bass Enhancing + Perfect EQ - Low Latency.json".source =
      "${inputs.easyeffects-presets}/Bass Enhancing + Perfect EQ - Low Latency.json";

    "easyeffects/output/Boosted.json".source =
      "${inputs.easyeffects-presets}/Boosted.json";

    "easyeffects/output/Dolby Atmos.json".source =
      "${inputs.easyeffects-presets}/Dolby Atmos.json";

    "easyeffects/output/Loudness+Autogain.json".source =
      "${inputs.easyeffects-presets}/Loudness+Autogain.json";

    "easyeffects/output/Perfect EQ.json".source =
      "${inputs.easyeffects-presets}/Perfect EQ.json";

    "easyeffects/output/Speaker Sync.json".source =
      "${inputs.easyeffects-presets}/Speaker Sync.json";
  };

  xdg.dataFile."easyeffects/irs" = {
    source = "${inputs.easyeffects-presets}/irs";
    recursive = true;
  };
}
