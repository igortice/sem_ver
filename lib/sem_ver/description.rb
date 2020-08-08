# frozen_string_literal: true

module SemVer
  NAME        = 'sem_ver'
  VERSION     = '0.1.0'
  AUTHORS     = [{ name: 'Igor Rocha', email: 'igortice@gmail.com' }].freeze
  SUMMARY     = 'gem for rails based on semantic versioning saved in yml file.'
  DESCRIPTION = <<~DESC
    The gem creates a yml file in the public folder in which it can be filled and consumed, at any time, to generate 
    information based on the concept of semantic versioning.
  DESC
  HOMEPAGE = 'https://github.com/igortice/sem_ver'
  LICENSE  = 'MIT'
end
