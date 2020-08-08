# frozen_string_literal: true

Warning[:deprecated] = false
namespace :sem_ver do
  desc 'Sem Ver terminal options'
  task :terminal do
    ####################################################################################################################
    # IMPORTS
    ####################################################################################################################
    require 'tty-box'
    require 'tty-command'
    require 'tty-prompt'
    require 'tty-screen'
    require 'tty-table'
    require 'colorize'
    require 'pry'
    require 'sem_ver'

    ####################################################################################################################
    # PRINT INFO ABOUT RAKE
    ####################################################################################################################
    print TTY::Box.info('SEMVER TERMINAL',
                        border: :light,
                        width:  TTY::Screen.width,
                        title:  { top_left: 'RAKE' })

    ####################################################################################################################
    # PRINT INFO TABLE LOAD VERSIONS
    ####################################################################################################################
    current_version = SemVer.current_version
    header          = ['TOTAL VERSIONS', 'CURRENT VERSION', 'DATE', 'DESC']
    rows            = [[SemVer.load_versions.count,
                        (current_version&.number || 'NO DATA'),
                        (current_version&.date || 'NO DATA'),
                        (current_version&.desc || 'NO DATA')]]

    table = TTY::Table.new header, rows
    print table.render :ascii, width: TTY::Screen.width, resize: true

    ####################################################################################################################
    # PRINT MENU
    ####################################################################################################################
    prompt  = TTY::Prompt.new
    choices = [
      { name: 'ADD NEW VERSION', value: 1 },
      { name: 'CLEAR ALL VERSIONS', value: 2 },
      { name: 'EXIT', value: 3 }
    ]
    loop do
      result = prompt.select('CHOOSE AN OPTION:'.red, choices, enum: ')')
      case result
      when 1
        menu_choose_version_type

        break
      when 2
        if prompt.yes?('ARE YOU SURE ABOUT THAT?'.yellow)
          SemVer.clear_versions
          break
        end
      when 3
        break
      end
    end
  end

  def menu_choose_version_type
    ####################################################################################################################
    # PRINT MENU ADD VERSION
    ####################################################################################################################
    prompt  = TTY::Prompt.new
    choices = [
      { name: 'MAJOR', value: 1 },
      { name: 'MINOR', value: 2 },
      { name: 'PATCH', value: 3 },
      { name: 'EXIT', value: 4 }
    ]
    loop do
      result = prompt.select('CHOOSE ADD VERSION TYPE:'.red, choices, enum: ')')
      break if result == 4

      ##################################################################################################################
      # WRITE ABOUT DESC VERSION
      ##################################################################################################################
      desc = prompt.ask('WRITE ABOUT DESC VERSION:'.red) do |q|
        q.required true
        q.modify :strip
      end

      ##################################################################################################################
      # SHOW ABOUT NEXT VERSION
      ##################################################################################################################
      header        = ['NUMBER VERSION', 'TYPE VERSION', 'DESC VERSION']
      type_selected = choices.select { |choice| choice[:value] == result }[0][:name]
      rows          = [[SemVer.next_version(type_selected.downcase.to_sym), type_selected, desc]]
      table         = TTY::Table.new header, rows
      print table.render :ascii, width: TTY::Screen.width, resize: true

      ##################################################################################################################
      # SAVE FILE?
      ##################################################################################################################
      next unless prompt.yes?('SAVE?'.yellow)

      case result
      when 1
        SemVer.add_version_major(desc)
        commit_and_push?

        break
      when 2
        SemVer.add_version_minor(desc)
        commit_and_push?

        break
      when 3
        SemVer.add_version_patch(desc)
        commit_and_push?

        break
      end
    end
  end

  def commit_and_push?
    prompt = TTY::Prompt.new
    cmd    = TTY::Command.new

    return unless prompt.yes?('COMMIT AND PUSH FILE?'.yellow)

    desc_commit = prompt.ask('MESSAGE COMMIT:'.red) do |q|
      q.required true
      q.modify :strip
    end

    cmd.run("git add #{SemVer.path_file} -f")
    cmd.run("git commit -m '#{desc_commit}' #{SemVer.path_file}")
    cmd.run('git push')
  end
end
