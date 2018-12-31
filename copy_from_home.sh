for i in `ls -ap configs | grep -v /`; do
  cp ~/$i configs/.;
done
