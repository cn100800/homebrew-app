#!/bin/bash

src_file=${1:-pic.png}
dst_file=${2:-Icon.icns}

init () {
    mkdir -p /tmp/icons.iconset
}

end () {
    rm -rf /tmp/icons.iconset
}

icon () {
    for (( i = 4; i < 10; i++ )); do
        let "v=2**$i"
        vv=$[$v*2]
        sips -z $v $v $src_file --out /tmp/icons.iconset/icon_${v}x${v}.png
        sips -z $vv $vv $src_file --out /tmp/icons.iconset/icon_${v}x${v}@2x.png
    done
    iconutil -c icns /tmp/icons.iconset -o $dst_file
}

main () {
    init
    icon
    end
}

main
