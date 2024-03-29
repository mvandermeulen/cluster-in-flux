#!/usr/bin/env bash
set -e
pushd ansible >/dev/null
for host in $(ls ./host_vars); do
  echo $host
  [ -f "host_vars/$host/${host}_vault.yml" ] && ansible-vault encrypt "host_vars/$host/${host}_vault.yml" >/dev/null || true
done
popd >/dev/null

pushd ansible >/dev/null
for group in $(ls ./group_vars); do
  [ -f "group_vars/$group/${group}_vault.yml" ] && ansible-vault encrypt "group_vars/$group/${group}_vault.yml" >/dev/null || true
done
popd >/dev/null

echo "[38;5;208mEncrypted all vaults![0m"

