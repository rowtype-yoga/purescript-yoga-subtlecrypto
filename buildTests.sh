#!/bin/bash

spago build
echo "Bundling..."
spago bundle --module Test.Main --outfile test.browser.js
echo "Bundled."
