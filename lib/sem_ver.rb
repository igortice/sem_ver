# frozen_string_literal: true

require 'sem_ver/description'
require 'sem_ver/file_yml_base'
require 'sem_ver/file_yml'

# SemVer static module
module SemVer
  module_function

  @sem_ver_file_yml = SemVer::FileYml.new

  def load_versions
    @sem_ver_file_yml.load_versions
  end

  def clear_versions
    @sem_ver_file_yml.clear_versions
  end

  def first_version(count = 1)
    @sem_ver_file_yml.first_version(count)
  end

  def last_version(count = 1)
    @sem_ver_file_yml.first_version(count)
  end

  def current_version
    @sem_ver_file_yml.current_version
  end

  def next_version(type)
    @sem_ver_file_yml.next_version(type).join('.')
  end

  def add_version_major(desc)
    @sem_ver_file_yml.add_version_major(desc)
  end

  def add_version_minor(desc)
    @sem_ver_file_yml.add_version_minor(desc)
  end

  def add_version_patch(desc)
    @sem_ver_file_yml.add_version_patch(desc)
  end

  def path_file
    @sem_ver_file_yml.path_to_file
  end
end
