#!/usr/local/bin/bash

# Check if rbenv is installed
which rbenv > /dev/null 2>&1 && if [ $? -ne 0 ]; then echo -e 'rbenv is need\nPlease install rbenv: https://github.com/rbenv/rbenv'; exit 1; fi

declare -a all_support_ruby=(
  '2.3.3'
  '2.4.2'
  '2.5.8'
  '2.6.6'
  '2.7.1'
)
declare -a target_ruby

if [ $# -ne 0 ]; then
  target_ruby=("$@")
else
  target_ruby=("${all_support_ruby[@]}")
fi

# Bundle install each All Support Ruby
declare -a report
for version in "${target_ruby[@]}"; do
  echo "== Bundle install for Ruby Version: ${version} =="
  
  # Remove gemfile.lock
  lockfile="./gemfiles/ruby_${version}.gemfile.lock"
  if [[ -f $lockfile ]]; then rm $lockfile; fi
  
  # Change Ruby Version
  echo ${version} > ./.ruby-version && rbenv rehash
  
  # Bundle install
  if [[ $version == "2.3.3" ]]; then
    BUNDLE_GEMFILE=./gemfiles/ruby_${version}.gemfile bundle _1.17.3_ install --path vendor/bundle && report+=("ruby-${version}: $?")
  else
    BUNDLE_GEMFILE=./gemfiles/ruby_${version}.gemfile bundle install --path vendor/bundle && report+=("ruby-${version}: $?")
  fi 
  if [ $? -ne 0 ]; then report+=("ruby-${version}: 1 (failed)");fi

  echo "== End for Ruby Version: ${version} =="
done

#  Display report
echo "===== Bundle install for All Support Ruby Result ====="
for result in "${report[@]}"; do
  echo $result
done
echo "======================================================"
