OpenJDK 11 for Linux x86 (IA-32)
================================

This repository provides builds of OpenJDK 11 for Linux x86 (aka [IA-32](https://en.wikipedia.org/wiki/IA-32)) created with the build scripts by [AdoptOpenJDK](https://github.com/AdoptOpenJDK/openjdk-build). Compiled binaries are available at the [release page](https://github.com/OpenIndex/openjdk-linux-x86/releases).


Important Notice
----------------

Since version 11.0.3 [Bell Soft](https://www.bell-sw.com/) provides binary packages of OpenJDK 11 for Linux x86. Therefore this repository is not necessary anymore and won't receive any further updates on OpenJDK 11.


Motivation
----------

Unfortunately AdoptOpenJDK does not provide binaries of OpenJDK 11 for Linux x86 yet. It seems to be planned according to [this issue](https://github.com/AdoptOpenJDK/openjdk-build/issues/774) but we don't really know, when the package will become available on [their website](https://adoptopenjdk.net/).

One might ask, if this old architecture is still relevant today on Linux. Of course it's highly recommended to use x86-64, if the system supports it. But x86 is still being used and according to the philosophy of open source software, we should try to keep compatibility to older systems for as long as possible:

> It was a premise of the open source movement to make software accessible to everyone everywhere. It’s unfortunate we forget sometimes it also means people running obsolete hardware. Including that “old computer,” you had thrown away a few years ago. Of course, we can question the merits of running a Pentium- or 80486-based computer in the 21st century. But merely considering the IA-32 architecture as a thing of the past would be ignoring another niche, well alive this one: embedded systems.
>
> [Open Source OS Still supporting 32-bit Architecture and Why it’s Important](https://itsfoss.com/32-bit-os-list/)


How to build
------------

The [provided binaries](https://github.com/OpenIndex/openjdk-linux-x86/releases) were created on a virtual machine using [Debian](https://www.debian.org/) stable for **i386**. Of course you might also use other build environments.

The following packages had to be installed in order to build the OpenJDK packages:

```bash
sudo apt install \
  autoconf \
  curl \
  file \
  git \
  libasound2-dev \
  libcups2-dev \
  libfontconfig1-dev \
  libx11-dev \
  libxext-dev \
  libxrandr-dev \
  libxrender-dev \
  libxt-dev \
  libxtst-dev \
  unzip \
  wget \
  zip
```

OpenJDK is compiled by calling the `build.sh` script. After the script was successfully executed you can find the created packages in the created `package` subfolder.


### Build on x86-64 systems with Docker

You may build OpenJDK for Linux x86 on a x86-64 system with Docker. The [openjdk-linux-x86-docker](https://github.com/OpenIndex/openjdk-linux-x86-docker) repository contains the required files and documentation.


### Build on x86-64 systems natively

You may build OpenJDK for Linux x86 on a x86-64 system natively. On Debian **amd64** the following steps are required:

-   Register the **i386** architecture via:

    ```bash
    sudo dpkg --add-architecture i386
    sudo apt update
    ```

-   Besides the packages mentioned above you need to install some additional packages:

    ```bash
    sudo apt install \
      g++-multilib \
      gcc-6-base:i386 \
      libasound2-dev:i386 \
      libc6:i386 \
      libc6-i386 \
      libc6-dev-i386 \
      libcups2-dev:i386 \
      libgcc1:i386 \
      libfontconfig1-dev:i386 \
      libx11-dev:i386 \
      libxext-dev:i386 \
      libxrandr-dev:i386 \
      libxrender-dev:i386 \
      libxt-dev:i386 \
      libxtst-dev:i386 \
      zlib1g-dev:i386
    ```

-   Start the build script from this repository with:

    ```bash
    /usr/bin/linux32 -- ./build.sh
    ```

    After the script was successfully executed you can find the created packages in the created `package` subfolder.


Word of warning
---------------

We've tested the provided binaries with our applications. Therefore they **should** work. But we can't fully guarantee, that the provided binaries work properly in any use case. Also we can't give any support for the provided binaries.


Third party components
----------------------

- [build scripts](https://github.com/AdoptOpenJDK/openjdk-build) provided by [AdoptOpenJDK](https://adoptopenjdk.net/)
- [OpenJDK 11 source code](https://github.com/AdoptOpenJDK/openjdk-jdk11u) provided by [AdoptOpenJDK](https://adoptopenjdk.net/)
- [OpenJDK 10 package for Linux x86](https://cdn.azul.com/zulu/bin/zulu10.3+5-jdk10.0.2-linux_i686.tar.gz) provided by [Azul Systems](https://www.azul.com/) (used for bootstrapping)


What about OpenJDK 8 for Linux x86?
-----------------------------------

We're not intending to provide OpenJDK 8 for Linux x86 here, because others are already covering this:

- [Liberica JDK](https://www.bell-sw.com/) by BellSoft
- [Zulu Linux](https://www.azul.com/downloads/zulu/zulu-linux/) by Azul Systems
