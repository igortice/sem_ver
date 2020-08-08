# frozen_string_literal: true

module SemVer
  module Generators
    # Class Generate File
    class GenerateFileGenerator < Rails::Generators::Base
      desc 'Create file public/semver.yml'
      def create_initializer_file
        create_file 'public/semver.yml'
      end
    end
  end
end
