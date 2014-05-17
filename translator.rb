#!/usr/bin/env ruby
# encoding: utf-8
require 'yaml'
translate_yaml = YAML.load_file('sk.yml')
puts translate_yaml.to_yaml
