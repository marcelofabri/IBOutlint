# IBOutlint

This Xcode plugin changes the order of the attributes when creating an `IBOutlet` in Xcode. 

<p align="center">
<img src="IBOutlint.gif" alt="IBOutlint demo" />
</p>

|  | IBOutlint
----------------------|----------------------------------
:white_check_mark: | No method swizzling needed
:rocket: | Saves you **hours** of boredom by not having to manually fix the order
:sparkles: | Super easy installation
:older_man: | In Objective-C, for Objective-C
:muscle: | Works for `strong` properties too

# Installation

### Alcatraz
You can install `IBOutlint` using [Alcatraz](http://alcatraz.io/). 

First, install [Alcatraz](http://alcatraz.io/) using

```
curl -fsSL https://raw.githubusercontent.com/supermarin/Alcatraz/deploy/Scripts/install.sh | sh
```

- Restart Xcode
- Click on `Window`
- Select `Package Manager`
- Search and Install `IBOutlint`
- Restart Xcode

### Manually

You can also install the plugin manually by cloning this repository and building the project. It'll be installed on `~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/IBOutlint.xcplugin`.

You should restart Xcode after that.

# What does this do?

The primary goal of this plugin is to change the order of the attributes when creating an `IBOutlet`. By default, Xcode uses `(strong|weak), nonatomic`, but everyone knows that The Right Way™ to declare a propery is `nonatomic, (strong|weak)` and this plugin fixes that. 

You're welcome.

# Thanks

- [@leoformaggio](https://twitter.com/leoformaggio) for naming the plugin
- This README template was shamelessly copied from [@neonacho](https://twitter.com/neonacho)'s [FixCode](https://github.com/neonichu/FixCode)
- [@orta](https://twitter.com/orta) for blogging about [his experience on building a Xcode plugin](http://artsy.github.io/blog/2014/06/17/building-the-xcode-plugin-snapshots/)
- [@kattrali](https://twitter.com/kattrali) for providing a [template for Xcode plugins](https://github.com/kattrali/Xcode-Plugin-Template)

# Need help?
Please submit an issue on GitHub and provide information about your setup.

# License
This project is licensed under the terms of the MIT license. See the LICENSE file.

