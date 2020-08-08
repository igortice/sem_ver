# frozen_string_literal: true

RSpec.describe SemVer do
  describe 'Description of gem' do
    it 'has name: sem_ver' do
      expect(SemVer::NAME).to be 'sem_ver'
    end

    it 'has version number: 0.1.0' do
      expect(SemVer::VERSION).to be '0.1.0'
    end

    it 'has author: Igor Rocha <igortice@gmail.com>' do
      expect(SemVer::AUTHORS[0]).to eq({ name: 'Igor Rocha', email: 'igortice@gmail.com' })
    end

    it 'has a summary' do
      expect(SemVer::SUMMARY).not_to be nil
    end

    it 'has a description' do
      expect(SemVer::DESCRIPTION).not_to be nil
    end

    it 'has home page: https://github.com/igortice/sem_ver' do
      expect(SemVer::HOMEPAGE).to be 'https://github.com/igortice/sem_ver'
    end

    it 'has license: MIT' do
      expect(SemVer::LICENSE).to be 'MIT'
    end
  end
end
