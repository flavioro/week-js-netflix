MPEG=/C/Users/Flavio/Documents/app/ffmpeg-2020-10-21/bin/ffmpeg
ASSETSFOLDER=assets/timeline
for mediaFile in `ls $ASSETSFOLDER | grep .mp4`; do
  # echo $mediaFile
  # cut extension and file resolution
  FILENAME=$(echo $mediaFile | sed -n 's/.mp4//p' | sed -n 's/-1920x1080//p')
  # echo $FILENAME
  INPUT=$ASSETSFOLDER/$mediaFile
  FORLDER_TARGET=$ASSETSFOLDER/$FILENAME
  mkdir -p $FORLDER_TARGET

  # create files resolutions differents in folder
  OUTPUT=$ASSETSFOLDER/$FILENAME/$FILENAME
  DURATION=$(/C/Users/Flavio/Documents/app/ffmpeg-2020-10-21/bin/ffprobe -i $INPUT -show_format -v quiet | sed -n 's/duration=//p')

  OUTPUT144=$OUTPUT-$DURATION-144
  OUTPUT360=$OUTPUT-$DURATION-360
  OUTPUT720=$OUTPUT-$DURATION-720

  echo 'rendering in 720p'
  $MPEG -y -i $INPUT \
    -c:a aac -ac 2 \
    -vcodec h264 -acodec aac \
    -ab 128k \
    -movflags frag_keyframe+empty_moov+default_base_moof \
    -b:v 1500k \
    -maxrate 1500k \
    -bufsize 1000k \
    -vf "scale=-1:720" \
    $OUTPUT720.mp4
    -v quiet \

  echo 'rendering in 360p'
  $MPEG -y -i $INPUT \
    -c:a aac -ac 2 \
    -vcodec h264 -acodec aac \
    -ab 128k \
    -movflags frag_keyframe+empty_moov+default_base_moof \
    -b:v 400k \
    -maxrate 400k \
    -bufsize 400k \
    -vf "scale=-1:360" \
    $OUTPUT360.mp4
    -v quiet \

  echo 'rendering in 144p'
  $MPEG -y -i $INPUT \
    -c:a aac -ac 2 \
    -vcodec h264 -acodec aac \
    -ab 128k \
    -movflags frag_keyframe+empty_moov+default_base_moof \
    -b:v 300k \
    -maxrate 300k \
    -bufsize 300k \
    -vf "scale=256:144" \
    $OUTPUT144.mp4
    -v quiet \

  echo $OUTPUT144.mp4
  echo $OUTPUT360.mp4
  echo $OUTPUT720.mp4
done

  # /C/Users/Flavio/Documents/node/week-js-expert/scripts.sh

  # sh script.sh

# /C/Users/Flavio/Documents/app/ffmpeg-2020-10-21/bin/ffmpeg --help

# /C/Users/Flavio/Documents/app/ffmpeg-2020-10-21/bin/ffprobe --help

#  /C/Users/Flavio/Documents/app/ffmpeg-2020-10-21/bin/ffprobe -i assets/timeline/01.intro-1920x1080.mp4 -show_format

# open assets/timeline/01.intro/01.intro-12.733333-720.mp4