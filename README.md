# swiftmon
Swiftmon will watch your project directory and automatically rebuild and restart your application on file changes.  Inspired by Nodemon and written entirely in Swift.

## Installation

1. `git clone git@github.com:ChrisChares/swiftmon.git && cd swiftmon`
2. `swift build`
3. Symlink swiftmon to `/usr/local/bin` with `ln -s $(pwd)/.build/debug/Swiftmon /usr/local/bin/swiftmon`
4. Symlink swift to `/usr/local/bin` with `ln -s $(which swift) /usr/local/bin/swift`
5. Create a new project in a new directory, i.e. `mkdir ~/SampleProject && cd ~/SampleProject && swift package init --type executable`
6. Start watching it with `swiftmon`
7. ???
8. Profit

## Current Limitations

These would all make excellent pull requests ;)

+ Supports default directory structure by watching the ./Sources directory and optionally ./main.swift.  This is the structure created by `swift package init --type executable`
+ Does not currently run tests when they change
+ Requires some awkward symlinking (no `npm install -g` with spm yet)
+ Unable to choose files to ignore
+ (Probably) Mac OS only.  Haven't tested Linux yet.

## Contributing

Knock out some of the limitations or write some tests and I'll love you forever
