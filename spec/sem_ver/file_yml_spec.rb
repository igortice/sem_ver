# frozen_string_literal: true

RSpec.describe SemVer::FileYml do
  subject(:file_yml) { described_class.new }

  describe 'FileYml methods' do
    context 'when load_versions used' do
      it 'return Array' do
        expect(file_yml.load_versions.is_a?(Array)).to be(true)
      end
    end

    context 'when clear_versions used' do
      it 'return true' do
        expect(file_yml.clear_versions).to be(true)
      end
    end

    context 'when add_version_major used' do
      it 'return ArgumentError if desc not present' do
        expect { file_yml.send(:add_version_major) }.to raise_error(ArgumentError)
      end

      it 'return struct SemVer::Version if desc present' do
        expect(file_yml.add_version_major('this is a test').is_a?(SemVer::Version)).to be(true)
      end
    end

    context 'when add_version_minor used' do
      it 'return ArgumentError if desc not present' do
        expect { file_yml.send(:add_version_minor) }.to raise_error(ArgumentError)
      end

      it 'return struct SemVer::Version if desc present' do
        expect(file_yml.add_version_minor('this is a test').is_a?(SemVer::Version)).to be(true)
      end
    end

    context 'when add_version_patch used' do
      it 'return ArgumentError if desc not present' do
        expect { file_yml.send(:add_version_patch) }.to raise_error(ArgumentError)
      end

      it 'return struct SemVer::Version if desc present' do
        expect(file_yml.add_version_patch('this is a test').is_a?(SemVer::Version)).to be(true)
      end
    end

    context 'when first_version used' do
      it 'return nil if not present' do
        file_yml.clear_versions
        expect(file_yml.first_version).to be(nil)
      end

      it 'return struct SemVer::Version if not params or number == 1' do
        file_yml.add_version_major('bla')
        expect(file_yml.first_version.is_a?(SemVer::Version)).to be(true)
      end

      it 'return Array if params number > 1' do
        file_yml.add_version_major('bla')
        file_yml.add_version_major('bla')
        expect(file_yml.first_version(2).is_a?(Array)).to be(true)
      end
    end

    context 'when last_version used' do
      it 'return nil if not present' do
        file_yml.clear_versions
        expect(file_yml.last_version).to be(nil)
      end

      it 'return struct SemVer::Version if not params or number == 1' do
        file_yml.add_version_major('bla')
        expect(file_yml.last_version.is_a?(SemVer::Version)).to be(true)
      end

      it 'return Array if params number > 1' do
        file_yml.add_version_major('bla')
        file_yml.add_version_major('bla')
        expect(file_yml.last_version(2).is_a?(Array)).to be(true)
      end
    end

    context 'when current_version used' do
      it 'return nil if not present' do
        file_yml.clear_versions
        expect(file_yml.current_version).to be(nil)
      end

      it 'return struct SemVer::Version if not params or number == 1' do
        file_yml.add_version_major('bla')
        expect(file_yml.current_version.is_a?(SemVer::Version)).to be(true)
      end
    end
  end
end
