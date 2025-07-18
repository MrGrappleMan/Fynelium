#
# Creating a Minecraft server

## 1.Getting the server files
[Download them here](https://www.minecraft.net/en-us/download/server/bedrock)
Choose the "Ubuntu (Linux)" option for downloading. Choosing the preview option makes it so that only beta/preview edition users of the game can join.
They say it does not work with other distros, but they do due to the reliance only being on the ELF format

Once downloaded, extract the contents to be right beside this file you are seeing right now
In other words, when you extract the file, "bedrock_server" should be put in the same folder(called mcbe-server) as the file you are seeing right here, right now.

## 2.Setting the properties
Edit the file "server.properties" with a text editor

Remove everything in it, then paste the following text:

```
allow-cheats=true
allow-inbound-script-debugging=false
allow-list=false
allow-outbound-script-debugging=false
block-network-ids-are-hashes=true
chat-restriction=None
client-side-chunk-generation-enabled=true
compression-algorithm=snappy
compression-threshold=1
content-log-file-enabled=true
default-player-permission-level=member
diagnostics-capture-auto-start=true
diagnostics-capture-max-files=2
diagnostics-capture-max-file-size
difficulty=normal
disable-client-vibrant-visuals=true
disable-custom-skins=false
disable-persona=false
disable-player-interaction=false
enable-lan-visibility=true
force-gamemode=false
gamemode=survival
level-name=WorldToUse
level-seed=
max-players=262144
max-threads=0
online-mode=true
player-idle-timeout=5
player-movement-action-direction-threshold=0.65
player-position-acceptance-threshold=0.85
script-debugger-auto-attach=disabled
script-watchdog-memory-limit=256
server-authoritative-block-breaking-pick-range-scalar=1.5
server-authoritative-dismount-strict=false
server-authoritative-entity-interactions-strict=false
server-authoritative-movement-strict=false
server-build-radius-ratio=Disabled
server-name=MCBEServer
server-port=19132
server-portv6=19133
texturepack-required=true
tick-distance=4
view-distance=12
```

Use [this guide](https://minecraft.wiki/w/Server.properties#Keys_2) to configure it according to your preferences.

## 3.Creating the world
Make a world in the game.
!!! Make sure the storage is set to external in the game settings, else world exports will NOT work !!!
Worlds generated by the server are minimal in nature any many core files are missing.
While the world is still on your device, activate the resource/behaviour packs that you want. Some world-specific settings may not be considered by the server.

## 4.Move the world to the sever
There are specific paths for each platform.

## 5.Managing the server
By default, your server automatically starts up as a daemon inside tmux when your computer starts. This is triggered by a systemd service which executes the file if it is detected.

Here are some controls for it. Run them in "COSMIC Terminal"

To start:
```
sudo systemctl start fn-mcbe-srv
```

To get access to main console:
```
tmux attach-session -t bedrock
```

To stop:
enter main console first
```
quit
```

#
# Creating a Minecraft: Java Editon server
