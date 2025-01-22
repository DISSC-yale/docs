# DISSC docs

Website to put general docs for applied research.

## Preview

To preview the site, serve it locally:

```sh
mkdocs serve
```

## Desktop gifs

Created on a mac which creates a mov file

then install

```sh
brew install ffmpeg
brew install gifsicle
```

then i convert with

```sh
ffmpeg -i in.mov -pix_fmt rgb8 -r 10 output.gif && gifsicle -O3 output.gif -o output.gif
```
