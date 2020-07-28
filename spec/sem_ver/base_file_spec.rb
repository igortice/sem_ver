# frozen_string_literal: true

RSpec.describe SemVer::BaseFile do
  subject(:base_file) { described_class.new }

  let(:hash_base_initial) do
    {
      initial_version: [1, 0, 0],
      name_file:       'semver',
      folder_file:     'public',
      file:            'semver.yml',
      path_to_file:    File.join(Dir.pwd, 'public', 'semver.yml'),
      touched_file:    true
    }
  end

  describe 'BaseFile default constant' do
    it 'DEFAULT_INITIAL_VERSION = [1, 0, 0]' do
      expect(described_class::DEFAULT_INITIAL_VERSION).to eq(hash_base_initial[:initial_version])
    end

    it 'DEFAULT_NAME_FILE = "semver"' do
      expect(described_class::DEFAULT_NAME_FILE).to eq(hash_base_initial[:name_file])
    end

    it 'DEFAULT_FOLDER_FILE = "public"' do
      expect(described_class::DEFAULT_FOLDER_FILE).to eq(hash_base_initial[:folder_file])
    end
  end

  describe 'BaseFile check params construct' do
    context 'when initial_version passed' do
      it 'raise if nil' do
        expect { described_class.new(initial_version: nil) }
          .to raise_error('initial_version is not Array with 3 number elements')
      end

      it 'raise if string' do
        expect { described_class.new(initial_version: '1.0.0') }
          .to raise_error('initial_version is not Array with 3 number elements')
      end

      it 'raise if not array length == 3' do
        expect { described_class.new(initial_version: [1, 1, 1, 1]) }
          .to raise_error('initial_version is not Array with 3 number elements')
      end

      it 'raise if not array of number' do
        expect { described_class.new(initial_version: %w[1 2 3]) }
          .to raise_error('initial_version is not Array with 3 number elements')
      end

      it 'raise if not array of number +' do
        expect { described_class.new(initial_version: [-1, 1, 2]) }
          .to raise_error('initial_version is not Array with 3 number elements')
      end
    end

    context 'when name_file passed' do
      it 'raise if nil' do
        expect { described_class.new(name_file: nil) }
          .to raise_error('name_file is not String with value')
      end

      it 'raise if ""' do
        expect { described_class.new(name_file: '') }
          .to raise_error('name_file is not String with value')
      end
    end

    context 'when folder_file passed' do
      it 'raise if name_folder not exists in directory' do
        name_folder = 'abc'
        expect { described_class.new(folder_file: name_folder) }
          .to raise_error("folder_file #{name_folder} is not exists in directory")
      end
    end
  end

  describe 'BaseFile.new default instance variable' do
    it '@initial_version=[1, 0, 0]' do
      expect(base_file.instance_variable_get(:@initial_version)).to eq(hash_base_initial[:initial_version])
    end

    it '@name_file="semver"' do
      expect(base_file.instance_variable_get(:@name_file)).to eq(hash_base_initial[:name_file])
    end

    it '@folder_file="public"' do
      expect(base_file.instance_variable_get(:@folder_file)).to eq(hash_base_initial[:folder_file])
    end

    it '@file="semver.yml"' do
      expect(base_file.instance_variable_get(:@file)).to eq(hash_base_initial[:file])
    end

    it "@path_to_file='#{File.join(Dir.pwd, 'public', 'semver.yml')}'" do
      expect(base_file.instance_variable_get(:@path_to_file)).to eq(hash_base_initial[:path_to_file])
    end

    it '@touched_file=true' do
      expect(base_file.instance_variable_get(:@touched_file)).to eq(hash_base_initial[:touched_file])
    end
  end
end
