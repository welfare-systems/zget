# ZGET

## _WGET Alternative_

<p align="center">
<img src="https://i.ibb.co/7NXb07j/Full-Welfare-Systems.png">
</p>

Zget is an open-source utility written in Zig, designed for the retrieval of web server content. It serves as a contemporary, efficient, and user-friendly alternative to GNU Wget.

> [!CAUTION]
> Zget welcomes user contributions. However, it's essential to note that this project was primarily conceived for educational purposes, and as such, we currently lack a clear vision for its future trajectory. Consequently, the prospect of future updates remains uncertain, given that Zget already fulfills its core objective of facilitating the download and retrieval of online content.

## Features

- **Efficient Content Retrieval**: Zget provides a streamlined process for downloading content from web servers, ensuring optimal efficiency in data retrieval.
- **Modern Alternative**: As a contemporary alternative to GNU Wget, Zget offers a more up-to-date solution for users seeking advanced functionality and improved performance.
- **Simple Command Line Interface**: With its straightforward command line interface, Zget facilitates easy integration into scripts and workflows, making it ideal for automation tasks.
- **Seamless Compatibility**: Zget seamlessly integrates with various web servers and platforms, ensuring compatibility across different environments and systems.
- **Open-Source Foundation**: Zget is built upon open-source principles, fostering collaboration and community contributions to enhance its functionality and reliability.

## Modules

Zget is currently extended with the following modules.
Instructions on how to use them in your own application are linked below.

| Plugin  | README                                                           |
| ------- | ---------------------------------------------------------------- |
| Zig-cli | [src/modules/zig-cli/README.md](./src/modules/zig-cli/README.md) |

## Building from source

### Requirements:

- Zig version 0.12.0

To clone and use this project:

```sh
git clone https://github.com/welfare-systems/zget.git
cd zget
zig build
```

## License

LICENSE-CC-BY-NC-4.0
