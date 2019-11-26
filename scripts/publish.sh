#!/bin/bash

set -e

self_dir="$(dirname "$(readlink -f "${BASH_SOURCE}")")"
repository_dir="$(dirname "${self_dir}")"

cd "${repository_dir}"

if [[ $(git status -s) ]]
then
  echo "The working directory is dirty. Please commit any pending changes."
  exit 1;
fi

echo "Updating gh-pages branch"
(
  cd book &&
  git init &&
  git checkout --orphan gh-pages
  git add --all &&
  git commit -m "Generated website"

  git push git@github.com:azriel91/rust_closures.git gh-pages -f
)

exit 0
