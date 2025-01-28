#!/bin/fish
source /etc/fish/config.fish
fyn-functions

listedexec "flatpak install --system --noninteractive --or-update \$crntval" "flathub com.gopeed.Gopeed
flathub io.github.flattool.Warehouse
flathub com.github.rkoesters.xkcd-gtk
flathub org.geogebra.GeoGebra
flathub com.vscodium.codium-insiders
flathub se.sjoerd.Graphs
flathub org.cubocore.CoreStats
flathub net.cozic.joplin_desktop
flathub org.octave.Octave"
