# doc_circle1-onboard
Static website for onboarding people to circle1

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
