#!/usr/bin/env ruby
# encoding: utf-8
require 'yaml'
require 'easy_translate'

APP_CFG = YAML.load_file('config.yaml')
EasyTranslate.api_key = APP_CFG['google_translate_key']

def traverse_tree(object)
  object.each do |key, value|
    if value.class == Hash
      traverse_tree(value)
    else
      puts "#{key}-----#{value}\n"
      puts 
    end
  end
end

translate_yaml = YAML.load_file('sk.yml')
# puts translate_yaml.to_yaml
traverse_tree(translate_yaml)
