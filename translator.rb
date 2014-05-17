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

def translate_file(file, folder)
  translate_yaml = YAML.load_file(file)
  en = traverse_tree(translate_yaml, :en)
  File.open(folder + 'en.yml', 'w') {|f| f.write en.to_yaml; puts f.path }
  # puts en.to_yaml

  translate_yaml = YAML.load_file(file)
  ro = traverse_tree(translate_yaml, :ro)
  File.open(folder + 'ro.yml', 'w') {|f| f.write ro.to_yaml; puts f.path }
end

def find_files(base_path, flang)
  Dir.glob(base_path + "**/" + flang + ".yml") do |file|
    if !File.directory? file
      # puts file
      translate_file(flang + ".yml", base_path)
    else
      find_files(file, flang)
    end
  end
end

find_files("../otvorenesudy/config/locales/", "sk")
# translate_file('sk.yml', '../otvorenesudy/config/locales/')
