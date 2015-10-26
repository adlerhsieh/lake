# Lake [![Build Status](https://travis-ci.org/adlerhsieh/lake.svg?branch=master)](https://travis-ci.org/adlerhsieh/lake)

#### Rake is productive, but we want it faster.

Lake is a [rake](http://rake.rubyforge.org/)-inspired tool in Crystal-lang for managing you tasks. Tasks are automatically built & run through the command line interface. It take advantages of the performance of `Crystal` and the utility of `rake`, helping you run recursive tasks in amazing speed.

## Features

- Automatically building & running tasks.
- Managing taks in `Lakefile` or `.lake` directory.
- Use it with `cron` and other automation tools for more efficient workflows.

## Requirement

[Crystal](https://github.com/manastech/crystal) >= 0.9.0. If you're on Mac OS X installing with Homebrew, Lake will install Crystal for you.

## Installtion

| System         |  Available Methods  |
| --------       | ------------------- |
| OSX            | [Homebrew](https://github.com/adlerhsieh/lake#mac-os-x) |
| Ubuntu / Debian | Work in progress    |
| Windows        | Not Supported       |

#### Mac OS X

```
brew tap adlerhsieh/lake
brew update
brew install lake
```

[Installtion details](https://github.com/adlerhsieh/homebrew-lake)

#### Manual Installation

If you decide to install it manually:

1. [Install Crystal](http://crystal-lang.org/docs/installation/from_source_repository.html).
2. Download lake [executable](https://github.com/adlerhsieh/lake/raw/master/lake).
3. Move the executable to one of your `PATH` directory, `/usr/local/bin` for example.

Once done, run `lake -v` or `lake -h` and it should display something other than `Command not found`. Crystal is not required at this stage, but once you start running a task, you will see `Command not found: crystal` if Crystal is not successfully installed.

## Usage

Create a `Lakefile` in any project directory, and write:

```crystal
Task.hello           # This is title
  puts "hello world" # This is code
```

In Lake DSL, all tasks should start with a `Task.` followed by a task name, which is `hello` in this case. Indentation is not required.

Save the file, and run:

```
lake hello
```

It compiles and build a task file for `hello` task. You should see `hello world` on screen and that's it. Write any script you want and run it this way.

## Other Techniques

#### Writing mulitple tasks in a single file

```crystal
Task.salute
  puts "salute!"

Task.write
  File.write("./story.txt", "Mary has a little lamb.")
```

Each `Task` forms a block that runs the code inside. It is not a Crystal block so it allows defining a class and method in the code as in normal Crystal context.

#### Dependencies

If you're using dependencies, require them in the task block like:

```crystal
Task.query
  require "crystal-mysql"
```

Lake shares dependencies with your project, so run `lake` command in the project root directory where `libs` and `.shards` directory exist.

#### Second time is faster

The first time you run a task is a bit slower, but the second time is blazingly fast. It is because Crystal is a compiled language, so it is necessary to build a task before running it. Lake automatically checks for change in all tasks and only build tasks that have any change. 

#### Work with multiple files

If you have many tasks in a project, separate them in different files. In addition to `Lakefile`, you can add any `.cr` file in `.lake` directory. All `.cr` files in the directory will be considered lake tasks.

## Options

| Short Flag | Long Flag   | Description
|----------- |-------------|----------- |
|`-b`        |`--build`    | Builds all tasks |
|`-r`        |`--rebuild`  | Rebuilds all tasks |
|`-h`        |`--help`     | Displays help messages |
|`-v`        |`--version`  | Displays current version |

## Progress

##### 0.1.0
- [x] Allow processing & executing tasks in `.lake` directory
- [x] Allow processing & executing `Lakefile`
- [x] Allow `Lakefile` and `.lake` directory generation
- [x] Brew installation
- [x] Usage & Instructions

##### 0.2.0
- [x] Remove failed build task in `tasks` directory
- [x] Allow executing multiple tasks in one command
- [x] Remove reduntant `-t` when executing command
- [x] Setting up ci service
- [x] Automatically install Crystal before installing Lake
- [x] Allow `shards` support in `.lake`
- [x] Allow dependency requirement
- [x] Manual installation

##### 0.3.0
- [ ] Argument support for tasks
- [ ] DSL support that allows putting multiple tasks in a single task
- [ ] Allow looking for other `Lakefile`s if not in current directory
- [ ] Allow global Lakefile and `-g` option
- [ ] apt-get installation

##### 1.0.0
- [ ] Unit Test
- [ ] Acceptance Test
- [ ] Official website or something better than README as introduction (gh-pages or .org)

##### In the future
- [ ] Auto-detect non-character in task name and send warning
- [ ] Allow checking if `pwd` is in a git repo, crystal project, and has a Lakefile.

## Contributing

Read the [Contributing guide](contributing.md)

