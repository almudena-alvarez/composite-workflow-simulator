#!/usr/bin/env bash

echo "im in the script and this is '${INPUT_INPUTVAR}'"

prueba='esto es una prueba'

echo "${prueba}"
echo "::set-output name=outputprueba::${prueba}"


