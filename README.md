# Fynelium
Ascend your device experience. Greatly enhance your system experience for High Performance Computing and Productivity.


# 📜 Key features:
 1. 📦 Automatic unattended updates, prevent dependency hell ( RPM-OSTree )
 2. ⚡ Better power management ( TLP )
 3. ⭐ Modern protocols and programs ( Wayland, PipeWire, WirePlumber )
 4. 🛑 AD-Blocking ( AdGuard DNS and internal block list )
 5. 🌌 The COSMIC desktop experience, modified for productivity
 6. 🚀 All-round system optimization ( sysctl.conf )
 7. 🌏 Access to a wide range of software
 8. ♾️ Autonomous handling of packages and the entire system ( RPM-OSTree )
 9. 🛡️ Hardened Security by default by pre-hardened SELinux
10. 🛑 Prevent manual modification of core system parts
11. ⛓️‍💥 Reduced risk of a broken system due to atomic behaviour
12. ✒️ Professional system software support backed by RedHat and the community
13. 🔁 Rollback to a previous system state 
14. 🌐 A productive browsing experience with Microsoft Edge
15. ✴️ Modern kernel improvements with the latest kernel

Install [Bazzite GNOME with no Steam Gaming Mode](https://bazzite.gg/)
Write the file ending with ".iso" to a spare USB Drive with a tool like Ventoy.
Back up ALL your data on the disk. In the Bazzite installer, wipe out your entire system disk, encrypt it with LUKS.
After installing and getting to the desktop, run this script in the "Terminal" app to get started.
Getting some errors is normal. Allow inhibiting shortcuts if requested.

```
sudo -A curl https://raw.githubusercontent.com/MrGrappleMan/Fynelium/refs/heads/main/tmp/Fynelium.fish | sudo -A fish
```

Windows environment »→ use Bottles
Linux environments »→ use BoxBuddy/DistroShelf

It expects that you have read this paragraph carefully and it claims no responsibilty to any damage done to your system, but I can try helping!

This project's intended purpose is to have your system in a state with files preconfigured for a great user experience,
For a unified distribution with the intent of fulfilling consumer/user usage without having technical experience or using terminals
Asahi Linux support not confirmed(could use unc work macbook, maybe. defaults is just like gsettings by experience).

In the GNOME Display Manager, change your desktop environment to COSMIC.

Bazzite is used as it has access to a wide range of
### supported hardware
### user friendly software
### community support greater than that of regular atomic Fedora alone

#
# Extra Tips:

### [Tailscale](https://tailscale.com)
Provides a seamless networking experience. You can MoSH, host servers and even access your home network with it.
Best for home-labbing, server hosting and remotely accessing your home internet.
Use it with Sunshine / Moonlight to use your desktop from anywhere as long as you 

### [PlayIt.gg](https://playit.gg/)
Port forwarding made simple for all.
Allows for a public IP that can be accessed/used by anyone on the internet.

Ensure the executable file's location is /opt/playit/playit
There should be no file at /etc/playit/playit.toml prior to execution of the command below.
For first time setup run this:
```
/opt/playit/playit --secret_path /etc/playit/playit.toml start
```
Get an error? Delete /etc/playit/playit.toml and try first time setup again.
The service autostarts at startup if the executable is found.

### Sunshine/Moonlight
Access your device from everywhere with high performance. Pair it with Tailscale and you have an easily accessible desktop!
Best for screen sharing + remote gaming. Better than Steam Remote Play and not restricted to just games.

### Minecraft Server
Host your own Minecraft Server on your PC.

Note: Using Bedrock edition is heavily recommended.
It is faster, scalable, efficient and the language used for it is significantly better.
Want a great vanilla experience? Use this!
You can infact get mods, worlds and skins for free! The marketplace is just an optional way to support Mojang and UGC creators
There are plenty of mods here that can satisfy your needs.
Move the contents inside the server folder to
```
/opt/mc-server/
```
such that the server executable is located at and named as
```
/opt/mc-server/mc-server
```

Want mods only possible to use on Java? Use server software like FabricMC
alongside mods like Lithium, GeyserMC and Floodgate to get started.

### Running other Linux distributions

Use tools like DistroShelf or BoxBuddy to get started with containers

### Running Windows programs

Although not providing a full fledged environment 
