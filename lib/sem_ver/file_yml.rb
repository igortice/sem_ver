# frozen_string_literal: true

module SemVer
  Version = Struct.new(:number, :date, :desc)

  # Class Base File
  class FileYml < SemVer::FileYmlBase
    def load_versions
      data = load_file_to_array_of_hash

      data ? (data.map { |item| Version.new(item['number'], item['date'], item['desc']) }) : []
    end

    def clear_versions
      clear_data
    end

    def first_version(count = 1)
      data = load_versions.last(count.abs)

      count == 1 ? data[0] : data
    end

    def last_version(count = 1)
      data = load_versions.first(count.abs)

      count == 1 ? data[0] : data
    end

    def current_version
      last_version
    end

    def add_version_major(desc)
      add_version(type: :major, desc: desc)
    end

    def add_version_minor(desc)
      add_version(type: :minor, desc: desc)
    end

    def add_version_patch(desc)
      add_version(type: :patch, desc: desc)
    end

    def next_version(type)
      if current_version.present?
        version_array = current_version.number.split('.').map(&:to_i)
        case type
        when :major
          [version_array[0].next, 0, 0]
        when :minor
          [version_array[0], version_array[1].next, 0]
        when :patch
          [version_array[0], version_array[1], version_array[2].next]
        end
      else
        @initial_version
      end
    end

    private

    def add_version(type: nil, desc: nil)
      raise 'type is not symbol (:major|:minor|:patch)' unless %i[major minor patch].include?(type)
      raise 'desc is not defined' unless desc.present?

      add_version_to_file(next_version(type), desc)
    end

    def add_version_to_file(version = nil, desc = nil)
      raise 'version is not defined' unless version.present?
      raise 'desc is not defined' unless desc.present?

      write_file_line(version, desc)

      current_version
    rescue StandardError => e
      raise e.message
    end
  end
end
