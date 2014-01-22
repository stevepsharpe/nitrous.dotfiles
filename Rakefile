require 'rubygems'
require 'rake'

desc "Install the dotfiles as symlinks in $HOME directory"
task :install => 'dotfiles:install'
task :default => 'dotfiles:install'

namespace :dotfiles do
  task :install do
    install_oh_my_zsh
    replace_all = false
    files = Dir['*'] - %w[Rakefile README.md LICENSE oh-my-zsh]
    files << "oh-my-zsh/custom/stevepsharpe.zsh"
    files.each do |file|
      next if %w[Rakefile README.markdown oh-my-zsh].include? file
      if File.exist?(File.join(ENV['HOME'], ".#{file}"))
        if replace_all
          replace_file(file)
        else
          print "Overwrite ~/.#{file}? [ynaq] "
          case $stdin.gets.chomp
          when 'a'
            replace_all = true
            replace_file(file)
          when 'y'
            replace_file(file)
          when 'q'
            exit
          else
            puts "Skipping ~/.#{file}"
          end
        end
      else
        link_file(file)
      end
    end

    print "Reload ~/.profile? [yn] "
    if $stdin.gets.chomp == 'y'
      system ". $HOME/.profile"
      system "exec $SHELL"
    end

  end
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "Linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "found ~/.oh-my-zsh"
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing oh-my-zsh"
      system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
    when 'q'
      exit
    else
      puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
end
