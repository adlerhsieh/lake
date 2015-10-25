# Lake [![Build Status](https://travis-ci.org/adlerhsieh/lake.svg?branch=master)](https://travis-ci.org/adlerhsieh/lake)

##### `rake` is fast, but `lake` is faster.

Lake is a [rake](http://rake.rubyforge.org/)-inspired tool in Crystal-lang for managing you tasks. Tasks are automatically built & run through the command line interface. It take advantages of the performance of `Crystal` and the utility of `rake `, helping you run recursive tasks in amazing speed.

## Features

- Automatically building & running tasks.
- Managing taks in `Lakefile` or `.lake` directory.
- Use it with `cron` and other automation tools for more efficient workflows.

## Requirement

[Crystal](https://github.com/manastech/crystal) >= 0.9.0. If you're on Mac OS X installing with Homebrew. Lake will install Crystal for you.

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

## Usage

Create a `Lakefile` in any project directory, and write:

```crystal
Task.hello           # This is title
  puts "hello world" # This is code
```

In Lake DSL, all tasks should start with a `Task.` followed by a task name, which is `hello` in this case. Indentation at the second line is not required.

Save the file, and run:

```
lake -t hello
```

It compiles and build a task file for `hello` task. You should see `hello world` on screen and that's it. Write any script you want and run it this way.

## Advanced Techniques

#### Writing mulitple tasks

You can set multiple tasks in a single file.

```crystal
Task.salute
  puts "salute!"

Task.write
  File.write("./story.txt", "Mary has a little lamb.")
```

Each `Task` forms a block that runs the code inside. It is not a Crystal block so it allows defining a class and method in the code as in normal Crystal context.

#### Second time is faster

The first time you run a task is a bit slower, but the second time is blazingly fast. It is because Crystal is a compiled language, so it is necessary to build a task before running it. Lake automatically checks for change in all tasks and only build tasks that have any change. 

#### Work with multiple files

If you have many tasks in a project, separate them in different files. In addition to `Lakefile`, you can add any `.cr` file in `.lake` directory. All `.cr` files in the directory will be considered lake tasks.

## Options

| Short Flag | Long Flag   | Description
|----------- |-------------|----------- |
|`-t TASK`   |`--task TASK`| Runs a specified `TASK` (including build) |
|`-b`        |`--build`    | Builds all tasks |
|`-p`        |`--purge`    | Removes `.lake` directory and `Lakefile` |
|`-h`        |`--help`     | Displays help messages |

## Progress

##### 0.1.0
- [x] Allow processing & executing tasks in `.lake` directory
- [x] Allow processing & executing `Lakefile`
- [x] Allow `Lakefile` and `.lake` directory generation
- [x] Brew installation
- [x] Usage & Instructions

##### 0.2.0
- [ ] Remove failed build task in `tasks` directory
- [ ] Allow checking typo for task definition. e.g. `Task.hello`
- [ ] Allow `shards` support in `.lake`
- [ ] Allow dependency requirement
- [ ] apt-get installation
- [ ] Manual installation
- [ ] Usage & Instructions

##### 0.3.0
- [ ] Argument support
- [ ] Allow executing multiple tasks in one command
- [ ] Allow looking for other `Lakefile`s if not in current directory
- [ ] Allow global Lakefile and `-g` option

##### 1.0.0
- [ ] Performance tuning
- [ ] Refactoring
- [ ] Test coverage 90% up
- [x] Setting up ci service
- [ ] Official website (gh-pages or .org)

##### In the future
- [ ] Remove reduntant `-t` when executing command
- [ ] Automatically install Crystal before installing Lake

## Contributing

1. Fork it ( https://github.com/adlerhsieh/lake/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
