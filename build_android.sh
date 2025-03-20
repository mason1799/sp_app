chmod +x ./pgyer_upload.sh
set -o allexport; source .secret; set +o allexport

printf "请输入想要操作的环境[prod qa dev]:"
read env
while [[ "$env" != "prod" && "$env" != "qa" && "$env" != "dev" ]]
do
  echo "错误!只能输入prod、qa、dev!"
  printf "请输入想要操作的环境[prod qa dev]:"
  read env
done

#KFPS
new_ref="qianfan-release"
if [ $env == "prod" ]; then
    new_ref="qianfan-release"
else
    new_ref="qianfan"
fi
file="./pubspec.yaml"
awk -v new_ref="$new_ref" '
/stickiness_frontend\/kfps\.git$/ {
    print;
    getline;
    if ($0 ~ /^ +ref:/) sub(/ref: .*/, "ref: " new_ref);
}
1' "$file" > temp.yaml && mv temp.yaml "$file"

#清理缓存
#flutter clean
#if [ -f "pubspec.lock" ]; then
#  rm pubspec.lock
#fi

flutter build apk --release -t lib/main_${env}.dart --flavor $env --no-tree-shake-icons --obfuscate --split-debug-info=./build
sh ./pgyer_upload.sh -k "$PGYER_KEY" ./build/app/outputs/flutter-apk/app-${env}-release.apk