#!/usr/bin/env sh

echo 'Setting up your machine...'

if [ -f "/Developer/Library/uninstall-tools" ]; then
  echo -p "Xcode pre-4.3 detected."
elif
  [ -f "/usr/bin/gcc" ]; then
  echo "Xcode 4.3+ detected."
else
  echo "Please install Xcode or Command Line Tools and re-run this script. http://developer.apple.com/downloads/. You will need a *free Apple ID"
  exit 0
fi


if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
  echo "Checking for SSH key, if one doesn't exist a key will be generated."
  echo "Please enter your email: "
  read email
  ssh-keygen -t rsa -C "$email"
  cat $HOME/.ssh/id_rsa.pub
  cat $HOME/.ssh/id_rsa.pub | pbcopy
  echo "Your public ssh key is in your pasteboard. Add it to github.com and hit Return"
fi


echo "Installing Homebrew and updating Formulas."
   ruby <(curl -fsS https://raw.github.com/mxcl/homebrew/go)
   brew update

echo "Putting Homebrew location higher up in PATH."
   echo "export PATH='/usr/local/bin:$PATH'" >> ~/.bash_profile
   source ~/.bash_profile

echo "Installing GNU compiler and dependencies."
   brew tap homebrew/dupes
   brew install autoconf automake apple-gcc42

echo "Installing licksba, this is recommeded for Ruby 1.9.3."
   brew install libksba

echo "Installing MongoDB 2.2 and adding it to Startup."
   brew install mongodb
   ln -s /usr/local/opt/mongodb/*.plist ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
   launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist

echo "Installing MySQL and adding it to Startup."
   brew install mysql

echo "Setting MySQL temp databases and run as YOUR User Account"
   unset TMPDIR
   mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

echo "Setting MySQL to start at boot"
   cp /usr/local/Cellar/mysql/5.5.27/homebrew.mxcl.mysql.plist ~/Library/LaunchAgents/
   launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

echo "Installing RVM (Ruby Version Manager) and Ruby 1.9.3, which becomes the default ..."
   curl -L https://get.rvm.io | bash -s latest-1.16 --auto
   source ~/.bash_profile
   command rvm install ruby -j 3
   command rvm reload

echo "Installing ImageMagick, good for cropping and re-sizing images ..."
   brew install imagemagick

echo "Installing QT, used by Capybara Webkit for headless Javascript integration testing ..."
   brew install qt

echo "Installing Git"
   brew install git

echo "Homebrew is installing ack, ctags-exuberant, macvim, markdown, proctools and wget"
for app in ack ctags-exuberant macvim markdown proctools wget; do
  brew list $app > /dev/null
  if [[ "$?" -eq "1" ]]; then
    brew install $app
  fi
done

echo "Installing tmux, a good way to save project state and switch between projects ..."
   brew install tmux
   curl -s https://raw.github.com/esparkman/PairMeUp/master/.tmux.conf -o ~/.tmux.conf

echo "Installing reattach-to-user-namespace, for copy-paste and RubyMotion compatibility with tmux ..."
   brew install reattach-to-user-namespace

echo "Install Tmuxinator"
   rvm use 1.9.3 --default
   gem install tmuxinator
   mkdir ~/.tmuxinator
   curl -s https://raw.github.com/esparkman/PairMeUp/master/corndog.yml -o ~/.tmuxinator/corndog.yml
   echo 'export EDITOR = /usr/bin/vim' >> ~/.bash_profile

echo 'Checking that your system is ready for tmuxinator'
   tmuxinator doctor
   echo '[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator' >> ~/.bash_profile

echo 'Adding Alias for PairMeup'
   echo "alias pairme='. ~/pair_me_up.sh'" >> ~/.bash_profile

echo 'Your pairing environment should be configured. Launching PairMeUp! (You need to source .bash_profile)'
   curl -s https://raw.github.com/esparkman/PairMeUp/master/pair_me_up.sh -o ~/pair_me_up.sh
   source ~/.bash_profile
