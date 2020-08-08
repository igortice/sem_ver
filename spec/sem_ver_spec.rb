# frozen_string_literal: true

RSpec.describe SemVer do
  let(:default_desc) { 'this is a test' }

  describe 'Check module static methods' do
    it 'load_versions' do
      expect(described_class.load_versions.is_a?(Array)).to be(true)
    end

    it 'clear_versions' do
      expect(described_class.clear_versions).to be(true)
    end

    it 'first_version' do
      expect(described_class.first_version).to be(nil)
    end

    it 'last_version' do
      expect(described_class.last_version).to be(nil)
    end

    it 'current_version' do
      expect(described_class.current_version).to be(nil)
    end

    it 'add_version_major' do
      expect(described_class.add_version_major(default_desc).number).to eq('0.1.0')
    end

    it 'add_version_minor' do
      expect(described_class.add_version_minor(default_desc).number).to eq('0.2.0')
    end

    it 'add_version_patch' do
      expect(described_class.add_version_patch(default_desc).number).to eq('0.2.1')
    end

    it 'next_version(:major)' do
      next_from_major   = described_class.next_version(:major).split('.')[0].to_i
      next_from_current = described_class.current_version.number.split('.')[0].to_i + 1

      expect(next_from_major).to be(next_from_current)
    end

    it 'next_version(:minor)' do
      next_from_minor   = described_class.next_version(:minor).split('.')[1].to_i
      next_from_current = described_class.current_version.number.split('.')[1].to_i + 1

      expect(next_from_minor).to be(next_from_current)
    end

    it 'next_version(:patch)' do
      next_from_patch   = described_class.next_version(:patch).split('.')[2].to_i
      next_from_current = described_class.current_version.number.split('.')[2].to_i + 1

      expect(next_from_patch).to be(next_from_current)
    end
  end
end
