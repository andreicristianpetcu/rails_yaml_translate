#!/usr/bin/env ruby
# encoding: utf-8
require 'yaml'

def traverse_tree(object)
  object.each do |key, value|
    if value.class == Hash
      traverse_tree(value)
    else
      puts "#{key}-----#{value}\n"
    end
  end
end

translate_yaml = YAML.load_file('sk.yml')
# puts translate_yaml.to_yaml
traverse_tree(translate_yaml)
