for i in `find configs/ -type f -printf "%P\n"`; do
  cp ~/$i configs/$i;
done
