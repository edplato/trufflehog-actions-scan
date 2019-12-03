
# Trufflehog Actions Scan :pig_nose::key:

Scan repository for secrets with basic [trufflehog](https://github.com/dxa4481/truffleHog) defaults in place for easy setup.

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
  args:
    - "--regex --entropy=False --max_depth=5" # Add custom options here*

```

*if custom options argument string is used, it will overwrite default settings

----

[MIT License](LICENSE)
