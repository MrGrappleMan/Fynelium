This project's intended purpose is to have your system in a great state with files preconfigured for the best possible experience,
and by that, unify all distros with the intent of consumer/user usage.
This is compatible with multiple distributions, which all boils down to the core package managers used in them.
Your distribution MUST use systemd. Professionals have standards. Be polite, be efficient. Have a plan to excel at every situation you see.
#
# 📜 Key features and tweaks:
1. 📦 Automatic unattended updates, prevent dependency hell(depends on package manager)
2. ⚡ Better power management
3. ⭐ Use modern protocols and programs
4. 🛑 Advertisement( and potentially, trackers) blocking
5. 🌟 Install modern alternatives to pre-existing applications
6. 🌌 The COSMIC desktop experience
7. 🚀 All-round system optimization
8. 🌐 Distro-agnostic, include a wide range of repositories(with the intention of all content being available in a single one, e.g The AUR)
9. 🛠️ Distro-specific maintenance

### The above applies to most distros, but using Bazzite GNOME, Bluefin, Silverblue or any other rpm-ostree based distro is heavily recommended if you intend to use your computer normally for cases like productivity, work, gaming, etc. Even if you want to host a server, using CoreOS is recommended.
#
# ⚛️ For Atomic-Distros:
You can have all the above features, but when compared to any other type of distro...you will not get the following advantages
1. ♾️ Autonomous handling of packages and the entire system
2. 🛡️ Hardened Security by default by SELinux
3. 🛑 Prevent manual modification of core system parts(ricing is allowed, proceed to perform with caution)
4. ⛓️‍💥 Reduced risk of a broken system
5. ✒️ Professional system software support backed by the community and RedHat
6. 🔁 The integrated ability to rollback to a previous system state

Run this script. You will be asked questions depending on what your distribution type/base is.
You may encounter errors, which is normal. Most of them are usually expected.

sudo curl https://raw.githubusercontent.com/MrGrappleMan/Fynelium/refs/heads/main/etc/fn-components/prep.bash | sudo bash

It attempts to greatly enhance your system experience. Use COSMIC as the desktop environment with the display manager shipped by your distribution.
For rpm-ostree distribution users: Do not dual boot, use any Wine related utilities like Bottles/Proton or BoxBuddy/KVM for using distro specific packages.
To refresh your experience and potentialy introduce new tweaks, re-run the above given script.
I expect that you have read this paragraph carefully and I claim no responsibilty to any damage done to your system, but I can try helping!
