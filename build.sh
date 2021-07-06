#!/bin/bash
echo "installeer git"
sudo apt install git

echo "verwijderen van build.log zodat we een schoon overzicht hebben"
rm ~/build.log

#haal buildscript op
echo "buildscript op halen en starten"
cd ~/
git clone https://github.com/akhilnarang/scripts
cd scripts
echo "script om de environment goed te zetten wordt gestart"
./setup/android_build_env.sh

#maak de benodigde folders
echo "de benodigde folders aanmaken"
mkdir -p ~/bin
mkdir -p ~/android/pe
#Google repo executable ophalen
echo "Google repo script ophalen en verplaatsen naar /bin/"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

#configureer van GIT
echo "Git configureren"
git config --global user.email "jeroen@jeroenvd.nl"
git config --global user.name "Jeroen"

#naar de Androide-PE folder gaan
echo "naar de Android-PE folder gaan"
cd ~/android/pe

#De git repo van Android Pixel Experience ophalen
echo "Repo ini van PixelExperience Repo"
repo init -u https://github.com/PixelExperience/manifest -b eleven-plus

echo "Repo van PixelExperience  ophalen. Dit duurt even......"
repo sync -j$(nproc --all) -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

echo "Repo opgehaald sourcen van de environment"
source build/envsetup.sh

echo "wat anderen dingen goed zetten"
lunch aosp_avicii-userdebug
croot

echo "Het build process wordt nu gestart dit gaat heeeeeeeeeeeeeeeeeeeeeeeeeel lang duren heb geduld!!"
mka bacon -j$(nproc --all) >> ~/build.log




