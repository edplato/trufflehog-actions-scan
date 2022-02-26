
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

For custom regex rules:

- rules: Uses custom [regexes.json](regexes/regexes.json)
  - Note: this is similar to the default `trufflehog` version, however this `regexes.json` will catch some additional API keys including any key Encapsulation Boundary that ends in ` PRIVATE KEY-----` or ` PRIVATE KEY BLOCK-----`.

Edit your corresponding actions `yml` file or create a new one.

### Required Actions

`trufflehog-actions-scan` now uses `actions/checkout@v2`. Using a previous version may cause issues with future support of this action.

With `actions/checkout@v2` make sure to include `fetch-depth: 0` as shown below when checking out the repository as it will make the entire git commit history available to be scanned. Alternatively, ensure the value for `fetch-depth` is greater than the `max_depth` flag used by trufflehog to ensure that trufflehog runs at your desired commit history depth. `ref: ${{ github.head_ref }}` is necessary for pull request workflow trigger.


### Basic

```yaml
steps:
- uses: actions/checkout@v2
  with:
    fetch-depth: 0
    ref: ${{ github.head_ref }} // necessary for pull request workflow trigger
- name: trufflehog-actions-scan
  uses: edplato/trufflehog-actions-scan@master
```

### Custom Arguments

```yaml
steps:
- uses: actions/checkout@v2
  with:
    fetch-depth: 0
    ref: ${{ github.head_ref }} // necessary for pull request workflow trigger
- name: trufflehog-actions-scan
  uses: edplato/trufflehog-actions-scan@master
  with:
    scanArguments: "--regex --entropy=False --max_depth=5 --rules /regexes.json" # Add custom options here*

```

* if custom options argument string is used, it will overwrite default settings
* if you want to just run the `trufflehog` command with NO arguments, set as a single spaced string `" "`

### Proxy
Building the docker container requires access to pypi.python.org/pypi. If you are running this action ob a self-hosted runner behind a proxy, you can configure the docker client to [flow proxy info to the container](https://docs.docker.com/network/proxy/#configure-the-docker-client). This action will respect the `HTTP_PROXY`, `HTTPS_PROXY`, and `NO_PROXY` settings in `~/.docker/config.json`, if set.

[MIT License](LICENSE)
