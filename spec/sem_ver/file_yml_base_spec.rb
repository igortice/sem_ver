# frozen_string_literal: true

RSpec.describe SemVer::FileYmlBase do
  subject(:base_file) { described_class.new }

  let(:hash_base_initial) do
    {
      initial_version: [0, 1, 0],
      name_file:       'semver',
      folder_file:     'public',
      file:            'semver.yml',
      path_to_file:    File.join(Dir.pwd, 'public', 'semver.yml'),
      touched_file:    true
    }
  end

  describe 'Default constants' do
    it 'DEFAULT_INITIAL_VERSION = [0, 1, 0]' do
      expect(described_class::DEFAULT_INITIAL_VERSION).to eq(hash_base_initial[:initial_version])
    end

    it 'DEFAULT_NAME_FILE = "semver"' do
      expect(described_class::DEFAULT_NAME_FILE).to eq(hash_base_initial[:name_file])
    end

    it 'DEFAULT_FOLDER_FILE = "public"' do
      expect(described_class::DEFAULT_FOLDER_FILE).to eq(hash_base_initial[:folder_file])
    end
  end

  describe 'Check params construct' do
    context 'when initial_version passed' do
      it 'raise if nil' do
        expect { described_class.new(initial_version: nil) }
          .to raise_error('initial_version is not Array with 3 number elements')
      end

      it 'raise if string' do
        expect { described_class.new(initial_version: '0.1.0') }
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
          .to raise_error("folder_file #{name_folder} is not exists in directory #{File.expand_path('.')}")
      end
    end
  end

  describe 'Default instance variable' do
    it '@initial_version=[0, 1, 0]' do
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

  describe 'Protected methods' do
    context 'when load_file_to_array_of_hash used' do
      it 'return Array' do
        expect(base_file.send(:load_file_to_array_of_hash).is_a?(Array)).to be(true)
      end
    end

    context 'when clear_data used' do
      it 'return true' do
        expect(base_file.send(:clear_data)).to be(true)
      end
    end

    context 'when write_file_line used' do
      it 'raise if not two params used' do
        expect { base_file.send(:write_file_line) }.to raise_error(ArgumentError)
      end

      it 'raise if not desc present' do
        expect { base_file.send(:write_file_line, [0, 1, 0], nil) }.to raise_error('desc is not present')
      end

      it 'raise if not version present' do
        expect { base_file.send(:write_file_line, nil, 'bla') }
          .to raise_error('version is not Array with 3 number elements')
      end

      it 'raise if not version is array' do
        expect { base_file.send(:write_file_line, '0.1.0', 'bla') }
          .to raise_error('version is not Array with 3 number elements')
      end

      it 'raise if not version is array with == 3 elements' do
        expect { base_file.send(:write_file_line, [1, 0], 'bla') }
          .to raise_error('version is not Array with 3 number elements')
      end

      it 'raise if not version is array with == 3 elements numbers' do
        expect { base_file.send(:write_file_line, [1, 0, '0'], 'bla') }
          .to raise_error('version is not Array with 3 number elements')
      end

      it 'return true if version is Array with 3 number elements' do
        expect(base_file.send(:write_file_line, [1, 0, 1], 'bla')).to be true
      end
    end
  end
end
