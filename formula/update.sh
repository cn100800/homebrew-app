#!/bin/bash
tool="news watermark"

for name in $tool
do
    latest_version="$(curl -sSf https://api.github.com/repos/cn100800/$name/releases | grep "v\.\d\+\.\d\+\.\w\+\.zip" | awk 'NR==1 {printf $2"\n"}' | tr -d \",)"
    latest_version=${latest_version:0:23}
    current_version=$(grep -o "v\.\d\+\.\d\+\.\w\+" "$name.rb" | head -1)
    echo $name

    if [[ "$latest_version" == "$current_version" ]]; then
        printf -- "%s当前版本为最新版本:%s\\n" "$name" "$latest_version"
    elif [[ "$latest_version" != "" ]]; then
        #statements
        sed -i '' "s/$current_version/$latest_version/g" "$name.rb"
        printf -- "%s历史版本:%s,替换后版本:%s\\n" "$name.rb" "$current_version" "$latest_version"
    fi
done

# 新版本号规则
tool="todo"

for name in $tool
do
    latest_version="$(curl -sSf https://api.github.com/repos/cn100800/"$name"/releases | grep "v\.\d\+\.\d\+\.\d\+\.zip" | awk 'NR==1 {printf $2"\n"}' | tr -d \",)"
    latest_version=${latest_version:0:16}
    current_version=$(grep -o "v\.\d\+\.\d\+\.\d\+" "$name.rb" | head -1)
    echo $name

    if [[ "$latest_version" == "$current_version" ]]; then
        printf -- "%s当前版本为最新版本:%s\\n" "$name" "$latest_version"
    elif [[ "$latest_version" != "" ]]; then
        #statements
        sed -i '' "s/$current_version/$latest_version/g" "$name.rb"
        printf -- "%s历史版本:%s,替换后版本:%s\\n" "$name.rb" "$current_version" "$latest_version"
    fi
done

