{ stdenv, fetchFromGitHub, pkgconfig, xfce4-dev-tools
, gtk
, thunar-bare
, exo, libxfce4util, libxfce4ui
, xfconf, udev, libnotify, hicolor-icon-theme
, nilfs-utils
}:

stdenv.mkDerivation rec {
  version = "0.1";
  name = "thunar-nilfs2-plugin-${version}";

  src = fetchFromGitHub {
    owner = "bartoszek";
    repo = "thunar-nilfs2-plugin";
    # thunarx-3 doesn't work
    #rev = "257b2685ca8d0319ed485fc845ba968ea078bcfa";
    #sha256 = "0a5j22f1sqy626ha1b4dr3i9hh9142wjna5g3y4wydy1nw746cfl";
    # use older thunarx-2 code
    rev = "1566c875b588927bccb610d04d61bade96d94684";
    sha256 = "0vvkm2qiyh1z46hwl2hxvdch5mblj5cigcd3b5dh8b0jg071l5qq";
  };

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [
    xfce4-dev-tools
    thunar-bare
    exo gtk libxfce4util libxfce4ui
    xfconf udev libnotify hicolor-icon-theme
    nilfs-utils
  ];

  preConfigure = ''
    ./autogen.sh
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    homepage = https://github.com/bartoszek/thunar-nilfs2-plugin;
    description = "You can see a list of checkpoints created by NILFS2 in Thunar";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ tohl ];
  };
}
