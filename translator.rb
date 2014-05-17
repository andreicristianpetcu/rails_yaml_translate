#!/usr/bin/env ruby
# encoding: utf-8
require 'yaml'
require 'easy_translate'

APP_CFG = YAML.load_file('config.yaml')
EasyTranslate.api_key = APP_CFG['google_translate_key']

def translate(text_to_translate, lang)
  # translated = EasyTranslate.translate(text_to_translate, :from => :sk, :to => lang)
  translated = text_to_translate + ' translated ' + lang.to_s
  # sleep(1.0/100.0)
  translated
end

def traverse_tree(object, lang)
  object.each do |key, value|
    if value.class == Hash
      value = traverse_tree(value, lang)
      object[key] = value
    else
      # puts "#{key}-----#{value}\n"
      translated = translate(value, lang)
      object[key] = translated
    end
  end
  object
end

def translate_file(file)
  translate_yaml = YAML.load_file(file)
  en = traverse_tree(translate_yaml, :en)
  File.open('ro.yaml', 'w') {|f| f.write en.to_yaml }
  puts en.to_yaml

  translate_yaml = YAML.load_file(file)
  ro = traverse_tree(translate_yaml, :ro)
  File.open('en.yaml', 'w') {|f| f.write ro.to_yaml }
end

def find_files(base_path, flang)
  Dir.glob(base_path + "**/" + flang + ".yml") do |file|
    if !File.directory? file
      puts file
    end
  end
end

find_files("../otvorenesudy/config/locales/", "sk")
# translate_file('sk.yml')
