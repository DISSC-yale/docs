# DISSC docs

Website to put general docs for applied research.

## Desktop gifs

Created on a mac which creates a mov file 

then install 

``` sh
brew install ffmpeg
brew install gifsicle
```

then i convert with 

`ffmpeg -i in.mov -pix_fmt rgb8 -r 10 output.gif && gifsicle -O3 output.gif -o output.gif`

`
