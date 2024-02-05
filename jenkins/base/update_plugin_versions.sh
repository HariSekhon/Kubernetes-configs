#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2024-01-31 02:19:25 +0000 (Wed, 31 Jan 2024)
#
#  https://github.com/HariSekhon/Kubernetes-configs
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# DEPRECATED: let plugins install the latest version of compatible plugins to avoid breaking the system
#             see comments in values.yaml above the plugin list for more details

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ $# -eq 1 ]; then
    values_yaml_file="$1"
elif [ $# -gt 1 ]; then
    echo "usage: ${0##*/} [values.yaml]" >&2
    exit 3
elif [ -f "$PWD/values.yaml" ]; then
    values_yaml_file="$PWD/values.yaml"
else
    values_yaml_file="$srcdir/values.yaml"
fi

if ! [ -f "$values_yaml_file" ]; then
    echo "File not found: $values_yaml_file" >&2
    exit 1
fi

if [ "$(uname -s)" = Darwin ]; then
    # standardize on GNU sed for in-place editing - requires installing core-utils package in homebrew so that GNU sed is in the path as 'gsed'
    sed(){
        command gsed "$@"
    }
fi

echo "* Updating plugins in file '$values_yaml_file"

plugin_versions="$(
    grep -Eo '^[[:space:]#]+- [[:alnum:]_-]+:[[:alnum:]]+([.[:alnum:]_-]+)*' "$values_yaml_file" |
    sed '
        s/^[[:space:]#]*//;
        s/^-//;
        s/^[[:space:]]*//;
        s/:/ /;
    '
)"

latest_versions="$(
    awk '{print $1}' <<< "$plugin_versions" |
    # jenkins_plugins_latest_versions.sh is in https://github.com/HariSekhon/DevOps-Bash-tools which should be cloned and put in \$PATH
    xargs jenkins_plugins_latest_versions.sh
)"

exitcode=0

while read -r plugin version; do
    plugin_latest_version="$(
        if ! grep -m1 "^$plugin:" <<< "$latest_versions"; then
            echo "WARNING: failed to find '$plugin' in the outout" >&2
        fi
    )"
    if [ -z "$plugin_latest_version" ]; then
        continue
    fi
    latest_version="${plugin_latest_version##*:}"
    if [ "$plugin:$version" != "$plugin:$latest_version" ]; then
        echo "* updating plugin '$plugin' version '$version' to latest version '$latest_version'"
        sed -i "s/$plugin:$version/$plugin_latest_version/" "$values_yaml_file"
    fi
done <<< "$plugin_versions"

exit $exitcode
