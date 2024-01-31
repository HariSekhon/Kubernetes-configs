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

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$(uname -s)" = Darwin ]; then
    # standardize on GNU sed for in-place editing - requires installing core-utils package in homebrew so that GNU sed is in the path as 'gsed'
    sed(){
        command gsed "$@"
    }
fi

echo "* Updating plugins in file '$srcdir/values.yaml"
grep -Eo '^[[:space:]#]+- [[:alnum:]-]+:[[:digit:]]+(\.[[:digit:]]+)+' "$srcdir/values.yaml" |
sed '
    s/^[[:space:]#]*//;
    s/^-//;
    s/^[[:space:]]*//;
    s/:/ /;
' |
while read -r plugin version; do
    echo "$plugin $version"
    # jenkins_plugin_latest_version.sh is in https://github.com/HariSekhon/DevOps-Bash-tools which should be cloned and put in $PATH
    latest_version="$(jenkins_plugin_latest_version.sh "$plugin")"
    echo "* updating plugin '$plugin' from version '$version' to latest version '$latest_version'"
    sed -i "s/$plugin:$version/$plugin:$latest_version/" "$srcdir/values.yaml"
done
