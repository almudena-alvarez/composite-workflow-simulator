#!/usr/bin/env bash
echo "im in the executable script of the composite action"

local prueba="esto es una prueba"
echo "::set-output name=prueba::${prueba}"

