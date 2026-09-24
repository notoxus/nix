{ pkgs, lib, ... }:

pkgs.stdenv.mkDerivation {
  pname = "brother-dcp-t430w-driver";
  version = "3.6.1-2";

  src = ./dcpt430wpdrv-3.6.1-2.x86_64.rpm;

  nativeBuildInputs = with pkgs; [
    rpm
    cpio
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [
    pkgs.stdenv.cc.cc.lib
  ];

  unpackPhase = ''
    rpm2cpio "$src" | cpio -id
  '';

  installPhase = ''
    mkdir -p "$out"

    # Keep Brother's original directory layout.
    cp -r opt "$out/"

    # The RPM's post-install script creates these architecture-independent
    # symlinks. Reproduce them inside the Nix store.
    ln -s \
      "$out/opt/brother/Printers/dcpt430w/lpd/x86_64/brdcpt430wfilter" \
      "$out/opt/brother/Printers/dcpt430w/lpd/brdcpt430wfilter"

    ln -s \
      "$out/opt/brother/Printers/dcpt430w/lpd/x86_64/brprintconf_dcpt430w" \
      "$out/opt/brother/Printers/dcpt430w/lpd/brprintconf_dcpt430w"

    # CUPS expects filters in its filter directory.
    mkdir -p "$out/lib/cups/filter"
    ln -s \
      "$out/opt/brother/Printers/dcpt430w/cupswrapper/brother_lpdwrapper_dcpt430w" \
      "$out/lib/cups/filter/brother_lpdwrapper_dcpt430w"

    # CUPS model/PPD.
    mkdir -p "$out/share/cups/model"
    ln -s \
      "$out/opt/brother/Printers/dcpt430w/cupswrapper/brother_dcpt430w_printer_en.ppd" \
      "$out/share/cups/model/brother_dcpt430w_printer_en.ppd"
  '';

  postInstall = ''
    patchShebangs "$out/opt/brother/Printers/dcpt430w"
  '';

  meta = {
    description = "Brother DCP-T430W printer driver";
    homepage = "https://support.brother.com/";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
