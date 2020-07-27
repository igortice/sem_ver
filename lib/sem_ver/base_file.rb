# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module SemVer
  # Class Base File
  class BaseFile
    DEFAULT_INITIAL_VERSION = [1, 0, 0].freeze
    DEFAULT_NAME_FILE       = 'semver'
    DEFAULT_FOLDER_FILE     = 'public'

    def initialize(initial_version: DEFAULT_INITIAL_VERSION,
                   name_file: DEFAULT_NAME_FILE,
                   folder_file: DEFAULT_FOLDER_FILE)
      check_params(initial_version, name_file, folder_file)

      @initial_version = initial_version
      @name_file       = name_file
      @folder_file     = folder_file
      @file            = name_file + '.yml'
      @path_to_file    = Rails.root.join(folder_file, @file)
      # @touched_file    = self.touched_file
    end

    def clear_data
      File.open(@path_to_file, 'w') { |file| file.truncate(0) }
    end

    def load_data_array_object
      YAML.load_file(@path_to_file) || []
    end

    protected

    def write_line_data(version, desc)
      data_changed = load_data_array_object
      data_changed.unshift({ number: version.join('.'), date: Time.now.to_s, desc: desc }.as_json)
      File.open(@path_to_file, 'r+') { |file| file.write(data_changed.to_yaml) }
    end

    private

    def check_params(initial_version, name_file, folder_file)
      if initial_version != DEFAULT_INITIAL_VERSION
        not_validate_initial_version =
          !initial_version.is_a?(Array) ||
          initial_version.size != 3 ||
          !(initial_version.all? { |i| i.is_a?(Integer) && i >= 0 })
        raise 'initial_version is not Array with 3 number elements' if not_validate_initial_version
      end

      if name_file != DEFAULT_NAME_FILE
        raise 'name_file is not String with value' if !name_file.is_a?(String) || name_file.strip.blank?
      end

      raise "folder_file #{folder_file} is not exists in directory" if !(Dir.children(File.join(Dir.pwd)).include?(folder_file))
    end

    def touched_file
      FileUtils.touch(@path_to_file)[0] == @path_to_file.to_s
    rescue StandardError => _e
      false
    end
  end
end
