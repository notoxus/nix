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

  buildInputs = with pkgs; [
    stdenv.cc.cc.lib
    perl
    cups
    ghostscript
    a2ps
    file
    coreutils
    gnugrep
    gnused
    gawk
  ];

  unpackPhase = ''
    rpm2cpio "$src" | cpio -idm
  '';

  installPhase = ''
    mkdir -p $out
    cp -r opt $out/
    
    # 1. Sửa hardcoded paths
    substituteInPlace $out/opt/brother/Printers/dcpt430w/cupswrapper/brother_lpdwrapper_dcpt430w \
      --replace-quiet "basedir=\"/opt/brother/Printers/dcpt430w\"" "basedir=\"$out/opt/brother/Printers/dcpt430w\"" \
      --replace-quiet "/opt/brother/Printers/dcpt430w" "$out/opt/brother/Printers/dcpt430w"

    substituteInPlace $out/opt/brother/Printers/dcpt430w/lpd/filter_dcpt430w \
      --replace-quiet "/opt/brother/Printers/dcpt430w" "$out/opt/brother/Printers/dcpt430w"

    # 2. Sửa cứng đường dẫn Perl (cho an toàn tuyệt đối)
    substituteInPlace $out/opt/brother/Printers/dcpt430w/cupswrapper/brother_lpdwrapper_dcpt430w \
      --replace-quiet '#! /usr/bin/perl' '#!${pkgs.perl}/bin/perl'
    substituteInPlace $out/opt/brother/Printers/dcpt430w/lpd/filter_dcpt430w \
      --replace-quiet '#! /usr/bin/perl' '#!${pkgs.perl}/bin/perl'

    # 3. Tạo symlink cho CUPS
    mkdir -p $out/lib/cups/filter
    ln -s $out/opt/brother/Printers/dcpt430w/cupswrapper/brother_lpdwrapper_dcpt430w $out/lib/cups/filter/brother_lpdwrapper_dcpt430w
  '';

  # Dùng postFixup thay vì fixupPhase để không làm mất autoPatchelfHook mặc định
  postFixup = ''
    wrapProgram $out/opt/brother/Printers/dcpt430w/cupswrapper/brother_lpdwrapper_dcpt430w \
      --prefix PATH : ${lib.makeBinPath (with pkgs; [ coreutils gnugrep gnused gawk file ghostscript a2ps ])}

    wrapProgram $out/opt/brother/Printers/dcpt430w/lpd/filter_dcpt430w \
      --prefix PATH : ${lib.makeBinPath (with pkgs; [ coreutils gnugrep gnused gawk file ghostscript a2ps ])}
  '';

  meta = {
    description = "Brother DCP-T430W printer driver";
    homepage = "https://support.brother.com/";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
