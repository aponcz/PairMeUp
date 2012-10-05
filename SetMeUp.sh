#!/bin/bash
echo 'Setting up your machine...'
mkdir ~/.tmuxinator
gem install tmuxinator
echo 'Checking that your system is ready for tmuxinator'
tmuxinator doctor
while true; do
  read -p 'Is your editor set up? (y|n)' yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) echo '[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator' >> ~/.bash_profile;;
    * ) echo 'Please enter y or n'
  esac
done
echo 'Adding Alias for PairMeup'
echo 'alias pairme='sh ~/pair_me_up.sh'' >> ~/.bash_profile
cp corndog.yml ~/.tmuxinator/
cp .tmux.conf ~/
cp pair_me_up.sh ~/
echo 'Your pairing environment should be configured. Launching PairMeUp! (You need to source .bash_profile)'
