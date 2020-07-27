# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

class SemVer::BaseFile
  DEFAULT_INITIAL_VERSION = [1, 0, 0]
  DEFAULT_NAME_FILE       = 'versions'
  DEFAULT_FOLDER_FILE     = 'public'

  def initialize(initial_version: DEFAULT_INITIAL_VERSION, name_file: DEFAULT_NAME_FILE, folder_file: DEFAULT_FOLDER_FILE)
    check_params(initial_version, name_file, folder_file)

    @initial_version = initial_version
    @name_file       = name_file
    @folder_file     = folder_file
    @file            = name_file + '.yml'
    # @path_to_file    = Rails.root.join(folder_file, @file)
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
      data_changed = self.load_data_array_object
      data_changed.unshift({ number: version.join('.'), date: Time.now.to_s, desc: desc }.as_json)
      File.open(@path_to_file, 'r+') { |file| file.write(data_changed.to_yaml) }
    end

  private
    def check_params(initial_version, name_file, folder_file)
      raise 'initial_version is not Array with 3 number elements' if !(initial_version.is_a?(Array)) ||
        !(initial_version.size == 3) ||
        !(initial_version.all? { |i| i.is_a?(Integer) && i >= 0 })

      raise 'name_file is not String with value' if !(name_file.is_a?(String)) || (name_file.strip.blank?)

      # raise 'folder_file is not exists in rails directory' if !(Dir.children(Rails.root).include?(folder_file))
    end

    def touched_file
      FileUtils.touch(@path_to_file)[0] == @path_to_file.to_s
    rescue => _e
      false
    end
end
