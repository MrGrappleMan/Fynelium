This project's intended purpose is to have your system in a great state with files preconfigured for a great user experience,
and by that, a centrallized distribution with the intent of fulfilling consumer/user usage. No need to touch the terminal(pls gentootards, not all people can ascend humanity).
Use [Bazzite](https://bazzite.gg/) GNOME. DO NOT enable Steam Gaming Mode if prompted by the website.
Asahi Linux support not confirmed.

#
# 📜 Key features:
1. 📦 Automatic unattended updates, prevent dependency hell ( RPM-OSTree )
2. ⚡ Better power management ( TLP )
3. ⭐ Modern protocols and programs ( Wayland, PipeWire, WirePlumber )
4. 🛑 AD-Blocking ( AdGuard DNS and internal block list )
5. 🌌 The COSMIC desktop experience, modified for productivity
6. 🚀 All-round system optimization ( sysctl.conf )
7. 🌐 Include a wide range of repositories ( flatpak )
8. ♾️ Autonomous handling of packages and the entire system ( RPM-OSTree )
9. 🛡️ Hardened Security by default by pre-hardened SELinux
10. 🛑 Prevent manual modification of core system parts
11. ⛓️‍💥 Reduced risk of a broken system due to atomic behaviour
12. ✒️ Professional system software support backed by RedHat and the community
13. 🔁 Rollback to a previous system state 
14. ☮️ A peaceful browsing experience with the Zen Browser
15. ✴️ Modern kernel improvements with the CachyOS kernel

Run this script to proceed.
You may encounter errors, which is usually a normal occurence.

```
sudo curl https://raw.githubusercontent.com/MrGrappleMan/Fynelium/refs/heads/main/opt/fn.fish | sudo fish
```

It attempts to greatly enhance your system experience.
Do not dual boot, use any Wine related utilities like Bottles/Proton or BoxBuddy/KVM for using distro specific packages.
I expect that you have read this paragraph carefully and I claim no responsibilty to any damage done to your system, but I can try helping!

In the GNOME Display Manager, change your desktop environment to COSMIC.

Bazzite is used as it has access to a wide range of
### supported hardware
### user friendly software
### community support greater than that of regular atomic Fedora alone

#
# Extra Tips:

### [Tailscale](https://tailscale.com)
Provides a seamless networking experience. You can MoSH, host servers and even access your home network with it.
Best for home-labbing and server hosting.

### [PlayIt.gg](https://playit.gg/)
Playing with your friends, a form of easier port forwarding.
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
Screen sharing + best for remote gaming.

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
