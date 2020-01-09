
# Trufflehog Actions Scan :pig_nose::key:

Scan recent commits in repository for secrets with basic [trufflehog](https://github.com/dxa4481/truffleHog) defaults in place for easy setup.

This action is intended as a Continuous Integration secret scan in an already "clean" repository. The default commit scan depth is the last 50 commits and can be adjusted using Custom Arguments (see below).

It is recommended to run a basic trufflehog scan on your entire repository prior to relying on this CI solution (Note: this can be done manually from the command line or by using this action with custom options `"--regex --entropy=False"`).

## Usage

```txt

workflow "Detect Secrets" {
  on = "push"
  resolves = ["edplato/trufflehog-actions-scan"]
}

action "edplato/trufflehog-actions-scan" {
  uses = "edplato/trufflehog-actions-scan@master"
}

```

Default trufflehog options for this tool include:

- regex : Enable high signal regex checks

- entropy disabled: Disabled entropy checks

- max depth is 50: The max commit depth to go back when searching for secrets

Edit your corresponding actions `yml` file or create a new one.

### Basic

```yaml
steps:
- uses: actions/checkout@master
- name: trufflehog-actions-scan
    uses: edplato/trufflehog-actions-scan@master
```

### Custom Arguments

```yaml
steps:
- uses: actions/checkout@master
- name: trufflehog-actions-scan
  uses: edplato/trufflehog-actions-scan@master
  with:
    scanArguments: "--regex --entropy=False --max_depth=5" # Add custom options here*

```

*if custom options argument string is used, it will overwrite default settings

### Private GitHub Repository

Pass a GitHub access token to action to clone from a private GitHub repository.
You can't use the default `GITHUB_TOKEN` as it doesn't have the permission to clone the repository.

```yaml
steps:
- uses: actions/checkout@master
- name: trufflehog-actions-scan
  uses: edplato/trufflehog-actions-scan@master
  with:
    githubToken: ${{ secrets.GITHUB_CLONE_TOKEN }} # You have to create an access token manually

```

----

[MIT License](LICENSE)
