#!/bin/bash
echo 'Setting up your machine...'

successfully() {
  $* || (echo "failed" 1>&2 && exit 1)
}

echo "Checking for SSH key, if one doesn't exist a key will be generated."
  [[ -f ~/.ssh/id_rsa.pub ]] || ssh-keygen -t rsa

echo "Copying public key to clipboard. Add this to your github account. You can also provide this to your pair for remote pairing purposes."
  [[ -f ~/.ssh/id_rsa.pub ]] && cat ~/.ssh/id_rsa.pub | pbcopy
  successfully open https://github.com/account/ssh

echo "Fixing permissions on /usr/local."
  successully sudo chown -R `whoami` /usr/local

echo "Installing Homebrew and updating Formulas."
  successfully ruby <(curl -fsS https://raw.github.com/mxcl/homebrew/go)
  successfully brew update

echo "Putting Homebrew location higher up in PATH."
  successfully echo "export PATH='/usr/local/bin:$PATH'" >> ~/.bash_profile
  successfully echo source ~/.bash_profile

echo "Installing GNU compiler and dependencies."
  successfully brew tap homebrew/dupes
  successfully brew install autoconf automake apple-gcc42

echo "Installing licksba, this is recommeded for Ruby 1.9.3."
  successfully brew install libksba

echo "Installing MongoDB 2.2 and adding it to Startup."
  successfully brew install mongodb

echo "Installing MySQL and adding it to Startup."
  successfully brew install mysql

echo "Installing RVM (Ruby Version Manager) and Ruby 1.9.3, which becomes the default ..."
  successfully curl -L https://get.rvm.io | bash -s -- --version 1.15.10 --ruby
  successfully echo "
# RVM
[[ -s '/Users/`whoami`/.rvm/scripts/rvm' ]] && source '/Users/`whoami`/.rvm/scripts/rvm'" >> ~/.bash_profile
  successfully source ~/.bash_profile







# mkdir ~/.tmuxinator
# gem install tmuxinator
# echo 'Checking that your system is ready for tmuxinator'
# tmuxinator doctor
# while true; do
#   read -p 'Is your editor set up? (y|n)' yn
#   case $yn in
#     [Yy]* ) break;;
#     [Nn]* ) echo '[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator' >> ~/.bash_profile;;
#     * ) echo 'Please enter y or n'
#   esac
# done
# echo 'Adding Alias for PairMeup'
# echo 'alias pairme='sh ~/pair_me_up.sh'' >> ~/.bash_profile
# cp corndog.yml ~/.tmuxinator/
# cp .tmux.conf ~/
# cp pair_me_up.sh ~/
echo 'Your pairing environment should be configured. Launching PairMeUp! (You need to source .bash_profile)'
