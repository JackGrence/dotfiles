read -p "Sync UltiSnips?" yn
case $yn in
    [Yy]* ) cp -r ./.vim/UltiSnips/. ~/.vim/UltiSnips/. && echo "success" || echo "fail";;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
esac
