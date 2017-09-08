# DPM
The Defold Package Manager

# Usage

Setup a new project named Example, which depends on the Debeat library version 1.2.+, where + will be the latest patch version available.

```sh
$ dpm init "Example"
$ dpm install debeat:1.2.+
$ dpm start
```

Install or Update to the latest version of a library dependency.

```sh
$ dpm install debeat:+
$ dpm update debeat:+
$ dpm install github.com/adamwestman/debeat:+
```

# Init
When initializing a new project through DPM a game.project will be generated. Unless -y flag is passed along a library folder will be generated as well.

```
[project]
title = {NAME}
version = 0.0.1
dependencies = {resolved dependencies}

[dpm]
repository = github.com/adamwestman/DPM
dependencies = {installed dependencies}
```

# Publish
Publishes the current state of the project to DPM.
