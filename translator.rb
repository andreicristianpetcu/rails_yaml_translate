#!/usr/bin/env ruby
# encoding: utf-8
require 'yaml'
require 'easy_translate'

APP_CFG = YAML.load_file('config.yaml')
EasyTranslate.api_key = APP_CFG['google_translate_key']

def translate(text_to_translate)
  translated = EasyTranslate.translate(text_to_translate, :from => :sk, :to => :en)
  # translated = text_to_translate + 'translated'
  translated
end

def traverse_tree(object)
  object.each do |key, value|
    if value.class == Hash
      value = traverse_tree(value)
      object[key] = value
    else
      # puts "#{key}-----#{value}\n"
      translated = translate(value)
      object[key] = translated
    end
  end
  object
end

translate_yaml = YAML.load_file('sk.yml')
traverse_tree(translate_yaml)
puts translate_yaml.to_yaml
File.open('en.yaml', 'w') {|f| f.write translate_yaml.to_yaml }
