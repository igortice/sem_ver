# frozen_string_literal: true

require 'active_support/core_ext/object/blank'
require 'yaml'

module SemVer
  # Class Base File
  class FileYmlBase
    DEFAULT_INITIAL_VERSION = [1, 0, 0].freeze
    DEFAULT_NAME_FILE       = 'semver'
    DEFAULT_FOLDER_FILE     = 'public'

    def initialize(initial_version: DEFAULT_INITIAL_VERSION,
                   name_file: DEFAULT_NAME_FILE,
                   folder_file: DEFAULT_FOLDER_FILE)
      check_params(initial_version, name_file, folder_file)

      @name_file       = name_file
      @initial_version = initial_version
      @folder_file     = folder_file
      @file            = name_file + '.yml'
      @path_to_file    = File.join(File.expand_path('.'), folder_file, @file)
      @touched_file    = touched_file
    end

    protected

    def load_file_to_array_of_hash
      YAML.load_file(@path_to_file) || []
    end

    def write_file_line(version, desc)
      raise 'version is not Array with 3 number elements' unless validate_version_array(version)
      raise 'desc is not present' unless desc.present?

      begin
        data_changed = load_file_to_array_of_hash
        data_changed.unshift({ 'number' => version.join('.'), 'date' => Time.now.to_s, 'desc' => desc })

        File.open(@path_to_file, 'r+') { |file| file.write(data_changed.to_yaml) }.positive?
      rescue StandardError => _e
        false
      end
    end

    def clear_data
      File.open(@path_to_file, 'w') { |file| file.truncate(0) }.zero?
    rescue StandardError => _e
      false
    end

    private

    def check_params(initial_version, name_file, folder_file)
      if initial_version != DEFAULT_INITIAL_VERSION && !validate_version_array(initial_version)
        raise 'initial_version is not Array with 3 number elements'
      end

      if name_file != DEFAULT_NAME_FILE && (!name_file.is_a?(String) || name_file.strip.blank?)
        raise 'name_file is not String with value'
      end

      return raise "folder_file #{folder_file} is not exists in directory #{File.expand_path('.')}" unless
        Dir.children(File.expand_path('.')).include?(folder_file)
    end

    def validate_version_array(version)
      version.is_a?(Array) && version.size == 3 && version.all? { |i| i.is_a?(Integer) && i >= 0 }
    end

    def touched_file
      FileUtils.touch(@path_to_file)[0] == @path_to_file.to_s
    rescue StandardError => _e
      false
    end
  end
end
