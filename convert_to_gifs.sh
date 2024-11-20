

path=/Users/mad265/git-yale/DISSC/doc_circle1/docs/assets

for f in `ls $path/*.mov `;do
    base="$(echo "$f" | cut  -d '.' -f 1)"
    echo $base;
    ffmpeg -i $f -pix_fmt rgb8 -r 10 ${base}.gif && gifsicle -O3 ${base}.gif -o ${base}.gif
done;
