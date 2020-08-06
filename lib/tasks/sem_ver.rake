Warning[:deprecated] = false
namespace :sem_ver do
  desc "Make a js file that will have functions that will return restful routes/urls."
  task :terminal do
    ####################################################################################################################
    # IMPORTS
    ####################################################################################################################
    require 'tty-box'
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
    rows            = [[SemVer.load_versions.count, current_version&.number || 'NO DATA', current_version&.date || 'NO DATA', current_version&.desc || 'NO DATA']]
    table           = TTY::Table.new header, rows
    print table.render :ascii, width: TTY::Screen.width, resize: true

    ####################################################################################################################
    # PRINT MENU
    ####################################################################################################################
    prompt  = TTY::Prompt.new
    choices = [
      { name: 'ADD NEW VERSION', value: 1 },
      { name: 'CLEAR ALL VERSIONS', value: 2 },
      { name: 'EXIT', value: 3 },
    ]
    result  = nil
    loop do
      result = prompt.select("CHOOSE AN OPTION:".red, choices, enum: ')')
      case result
      when 1
      when 2
        if prompt.yes?("ARE YOU SURE ABOUT THAT?".yellow)
          SemVer.clear_versions
          break
        end
      when 3
        break
      end
    end
    print TTY::Box.success(choices.select { |choice| choice[:value] == result }[0][:name], width: TTY::Screen.width)
  end
end
