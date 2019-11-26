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

echo "Deleting old publication"
rm -rf book
mkdir book
git worktree prune
rm -rf .git/worktrees/book/

echo "Checking out gh-pages branch into book"
git worktree add -B gh-pages book

echo "Removing existing files"
rm -rf book/*

echo "Generating site"
mdbook build

echo "Updating gh-pages branch"
(
  cd book &&
  git add --all &&
  git commit -m "Publishing to gh-pages"

  git push git@github.com:azriel91/rust_closures.git gh-pages -f
)
