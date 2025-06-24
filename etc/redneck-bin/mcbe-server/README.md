#
# Creating a Minecraft: Bedrock Edition server

## 1.Getting the server files
[Download them here](https://www.minecraft.net/en-us/download/server/bedrock)
Choose the "Ubuntu (Linux)" option for downloading. Choosing the preview option makes it so that only beta/preview edition users of the game can join.

Once downloaded, extract the contents to be right beside this file you are seeing right now
In other words, when you extract the file, "bedrock_server" should be put in the same folder(called mcbe-server) as the file you are seeing right here, right now.

## 2.Setting the properties
Edit the file "server.properties" with a text editor

Remove all contents inside and paste the following text in it:

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
level-name=Template
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
server-name=Template
server-port=19132
server-portv6=19133
texturepack-required=true
tick-distance=4
view-distance=12
```

