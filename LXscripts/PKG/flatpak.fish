#!/bin/fish
source /etc/fish/config.fish

listedexec "flatpak install --system --noninteractive --or-update \$crntval" "flathub com.gopeed.Gopeed
flathub io.github.flattool.Warehouse
flathub com.vscodium.codium-insiders
flathub org.cubocore.CoreStats
flathub org.octave.Octave"
