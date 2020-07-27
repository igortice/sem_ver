# frozen_string_literal: true

RSpec.describe SemVer::BaseFile do
  describe 'BaseFile check constant variables' do
    it 'const DEFAULT_INITIAL_VERSION = [1, 0, 0]' do
      expect(described_class::DEFAULT_INITIAL_VERSION).to eq([1, 0, 0])
    end

    it 'const DEFAULT_NAME_FILE = "semver"' do
      expect(described_class::DEFAULT_NAME_FILE).to eq('semver')
    end

    it 'const DEFAULT_FOLDER_FILE = "public"' do
      expect(described_class::DEFAULT_FOLDER_FILE).to eq('public')
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
end
