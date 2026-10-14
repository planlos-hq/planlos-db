#!/usr/bin/env bash
shopt -s globstar
pg_format -i **/*.sql
