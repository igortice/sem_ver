# frozen_string_literal: true

RSpec.describe SemVer::FileYml do
  subject(:file_yml) { described_class.new }
  let(:default_desc) { 'this is a test' }

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
        expect(file_yml.add_version_major(default_desc).is_a?(SemVer::Version)).to be(true)
      end
    end

    context 'when add_version_minor used' do
      it 'return ArgumentError if desc not present' do
        expect { file_yml.send(:add_version_minor) }.to raise_error(ArgumentError)
      end

      it 'return struct SemVer::Version if desc present' do
        expect(file_yml.add_version_minor(default_desc).is_a?(SemVer::Version)).to be(true)
      end
    end

    context 'when add_version_patch used' do
      it 'return ArgumentError if desc not present' do
        expect { file_yml.send(:add_version_patch) }.to raise_error(ArgumentError)
      end

      it 'return struct SemVer::Version if desc present' do
        expect(file_yml.add_version_patch(default_desc).is_a?(SemVer::Version)).to be(true)
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

  describe 'FileYml check order versions number is correct' do
    it '1) clear_version' do
      expect(file_yml.clear_versions).to be(true)
    end

    it '2) (add_version_major|add_version_minor|add_version_patch).number == "1.0.0"' do
      expect(file_yml.add_version_minor(default_desc).number).to eq('1.0.0')
    end

    it '3) add_version_major.number == "2.0.0"' do
      expect(file_yml.add_version_major(default_desc).number).to eq('2.0.0')
    end

    it '4) add_version_minor.number == "2.1.0"' do
      expect(file_yml.add_version_minor(default_desc).number).to eq('2.1.0')
    end

    it '5) add_version_minor.number == "2.2.0"' do
      expect(file_yml.add_version_minor(default_desc).number).to eq('2.2.0')
    end

    it '5) add_version_minor.number == "2.3.0"' do
      expect(file_yml.add_version_minor(default_desc).number).to eq('2.3.0')
    end

    it '6) add_version_patch.number == "2.3.1"' do
      expect(file_yml.add_version_patch(default_desc).number).to eq('2.3.1')
    end

    it '7) add_version_patch.number == "2.3.2"' do
      expect(file_yml.add_version_patch(default_desc).number).to eq('2.3.2')
    end

    it '8) add_version_minor.number == "2.4.0"' do
      expect(file_yml.add_version_minor(default_desc).number).to eq('2.4.0')
    end

    it '9) add_version_major.number == "3.0.0"' do
      expect(file_yml.add_version_major(default_desc).number).to eq('3.0.0')
    end

    it '10) add_version_patch.number == "3.0.1"' do
      expect(file_yml.add_version_patch(default_desc).number).to eq('3.0.1')
    end
  end
end
