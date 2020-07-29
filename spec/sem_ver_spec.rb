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
      expect(described_class.add_version_major(default_desc).number).to eq('1.0.0')
    end

    it 'add_version_minor' do
      expect(described_class.add_version_minor(default_desc).number).to eq('1.1.0')
    end

    it 'add_version_patch' do
      expect(described_class.add_version_patch(default_desc).number).to eq('1.1.1')
    end
  end
end
