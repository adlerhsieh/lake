# Contributing

Thanks for thinking about contributing to this project!

## Preparation

1. [Fork it](https://github.com/adlerhsieh/lake/fork)
2. Create your feature branch (git checkout -b my-new-feature)

Before you start to make any change, run `shards` to install dependencies, they are used for ensure every test case is covered.

## Running tests

After you make some changes, run tests and make sure they all passed. 

Note that acceptance tests actually run the commands, so there will be a lot of output messages, but only those with `Failure`, `Error`, and `Task ignored` are failed tests.

## Pull Requests

As contributing to any project, after changes are made:

1. Commit your changes (git commit -am 'Add some feature')
2. Push to the branch (git push origin my-new-feature)
3. Create a new Pull Request
4. Make sure all tests are passed on Travis CI.

