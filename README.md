# Trufflehog Action

Scan recent commits in repository for secrets with trufflehog.

## Usage

```yaml
steps:
- uses: actions/checkout@v2
- uses: UnicornGlobal/trufflehog-actions-scan@master
```

## Upstream

Based on: https://github.com/edplato/trufflehog-actions-scan

## Why the changes?

We don't want to add a special key when we already have
a local copy of the git repo. There is no need to check remotely.

We also don't need special config flags so we removed that
functionality too.

[MIT License](LICENSE)
