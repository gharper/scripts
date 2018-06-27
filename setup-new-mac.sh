#!/usr/bin/env bash
echo "Creating SSH key..."
ssh-keygen -t rsa

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"
read -p "Press [Enter] key after this..."

echo "Installing xcode..."
xcode-select --install

# Install Homebrew if not already present
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing git..."
brew install git
brew install git-extras
brew install git-flow
brew install legit

echo "Configuring git..."
git config --global user.name "Geromy Harper"
git config --global user.email geromy+github@gmail.com

echo "Installing personalization packages..."
brew install lastpass-cli
brew install trash

echo "Installing shell utilities..."
brew install bash
brew install binutils
brew install gawk
brew install gnupg
brew install gnu-sed --with-default-names
brew install grep --with-default-names
brew install mtr
brew install openssl
brew install pstree
brew install the_silver_searcher
brew install wget
brew install yubikey-personalization
brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting

echo "Installing dev tools..."
brew install bats
brew install gist
brew install imagemagick
brew install jq
brew install node
brew install python
brew install python3
brew install pip-completion
brew install shellcheck

echo "Installing misc fun stuff..."
brew install cowsay
brew install fortune
brew install lolcat
brew install thefuck

echo "Cleaning up brew..."
brew cleanup

echo "Installing homebrew cask..."
brew install caskroom/cask/brew-cask

echo "Installing dotfiles from Github..."
cd ~
git clone --recursive git@github.com:gharper/.dotfiles.git ./.dotfiles
cd ~/.dotfiles
./install

#Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
sh ~/.dotfiles/oh-my-zsh/tools/install.sh

echo "Setting ZSH as shell..."
chsh -s /bin/zsh

# Apps
apps=(
 atom
 bartender
 firefox
 google-chrome
 hipchat
 iterm2
 vagrant
 virtualbox
 minikube
 sequel-pro
 skype
 vlc
 hermes
 sourcetree
 meld
 dropbox
 macdown
 macvim
 slack
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

echo "Cleaning up brew..."
brew cask cleanup
brew cleanup

echo "Customizing OSX settings..."
#"Disabling system-wide resume"
#defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

#"Disabling automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

#"Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

#"Disabling OS X Gate Keeper"
#"(You'll be able to install any app you want from here on, not just Mac App Store apps)"
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
defaults write com.apple.LaunchServices LSQuarantine -bool false

#"Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

#"Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

#"Saving to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

#"Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

#"Disable smart quotes and smart dashes as they are annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

#"Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

#"Disabling press-and-hold for keys in favor of a key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

#"Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

#"Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

#"Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

#"Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#"Show hidden files in Finder by default"
defaults write com.apple.finder AppleShowAllFiles YES

#"Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#"Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

#"Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#"Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

#"Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

#"Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

#"Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

#"Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

#"Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

#"Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#"Disable the sudden motion sensor as its not useful for SSDs"
sudo pmset -a sms 0

#"Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

#"Disable annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

#"Setting screenshots location to ~/Desktop"
defaults write com.apple.screencapture location -string "$HOME/Desktop"

#"Setting screenshot format to PNG"
defaults write com.apple.screencapture type -string "png"

#"Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

#"Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

#"Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Ignore rich text when pasting into Terminal
defaults write com.apple.Terminal CopyAttributesProfile com.apple.Terminal.no-attributes

# Use POSIX style home/end behavior
mkdir ~/Library/KeyBindings
echo '{
"\\UF729" = "moveToBeginningOfLine:";                            /* Home */
"\\UF72B" = "moveToEndOfLine:";                                  /* End */
"$\\UF729" = "moveToBeginningOfLineAndModifySelection:";         /* Shift + Home */
"$\\UF72B" = "moveToEndOfLineAndModifySelection:";               /* Shift + End */
"@\\UF729" = "moveToBeginningOfDocument:";                       /* Cmd + Home */
"@\\UF72B" = "moveToEndOfDocument:";                             /* Cmd + End */
"@$\\UF729" = "moveToBeginningOfDocumentAndModifySelection:";    /* Shift + Cmd + Home */
"@$\\UF72B" = "moveToEndOfDocumentAndModifySelection:";          /* Shift + Cmd + End */
"@\\Uf702" = "moveWordLeft:";                                    /* Cmd + Left */
"@\\Uf703" = "moveWordRight:";                                   /* Cmd + Right */
"@$\\Uf702" = "moveWordLeftAndModifySelection:";                 /* Shift + Cmd + Left */
"@$\\Uf703" = "moveWordRightAndModifySelection:";                /* Shift + Cmd + Right */
}' > ~/Library/KeyBindings/DefaultKeyBinding.dict

echo "Restarting Finder to apply settings..."
killall Finder

echo "Done!"
