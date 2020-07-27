# frozen_string_literal: true

module SemVer
  NAME        = 'sem_ver'
  VERSION     = '1.0.0'
  AUTHORS     = [{ name: 'Igor Rocha', email: 'igortice@gmail.com' }].freeze
  SUMMARY     = 'gem for rails based on semantic versioning saved in yml file.'
  DESCRIPTION = <<~DESC
    The gem makes it possible to create a yml file, in the public directory which will contain all versions
    added by the responsible user containing number, desc, date and which can be used to generate public
    information, all of which are based on the concept of semantic versioning
  DESC
  HOMEPAGE = 'https://github.com/igortice/sem_ver'
  LICENSE  = 'MIT'
end
