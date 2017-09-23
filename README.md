# DPM
The Defold Package Manager

Provides transient dependency management for Defold projects. No longer worry about additional dependencies for native extensions and libraries.

# Install
Install from [homebrew](https://brew.sh) ```$ brew install dpm```

Install from ```/bin/``` by adding a PATH reference to **dpm.o**

# Usage
Setup a new project depending on the Debeat library version 1.2.+, where + will be the latest patch version available.
```sh
$ dpm init # requests name and version of project.
$ dpm install debeat 1.2.+ # resolves and updates the game.project dependency line.
```

Update to the latest version, following the lock rule.
```sh
$ dpm update debeat
```

Update version lock to the latest version.
```sh
$ dpm update debeat +
```

## Init
The ```$ dpm init``` command generates a ```dpm.package``` based on the local ```game.project``` if available, or requested user input if not.
```
[package]
name={game.project title}
version={game.project version}
```
## Install
The ```$ dpm install X``` command installs a new dependency to the ```dpm.package``` and outputs the resolved url to ```game.project``` if available. If no game.project is available a new one will be generated.
```
[package]
name=example
version=0.1.0

[dependencies]
debeat=1.2.+
```

```
[project]
title = example
version = 0.1.0
dependencies  = https://github.com/adamwestman/debeat/archive/debeat-1.2.3.zip, https://github.com/Lerg/extension-openal/archive/1.0.1.zip

