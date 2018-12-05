#!/bin/bash
tool="todo"
for name in $tool
do
    latest_version="$(curl -sSf https://api.github.com/repos/cn100800/todo/releases | grep "v\.\d\+\.\d\+\.\w\+" | awk 'NR==2 {printf $2"\n"}' | tr -d \",)"
    current_version=$(grep -o "v\.\d\+\.\d\+\.\w\+" "$name.rb" | head -1)
    if [[ "$latest_version" == "$current_version" ]]; then
        printf -- "%s当前版本为最新版本:%s\\n" "$name" "$latest_version"
    else
        sed -i '' "s/$current_version/$latest_version/g" "$name.rb"
    fi
done
