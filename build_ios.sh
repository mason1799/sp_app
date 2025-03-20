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
    sed -i '' 's/v2.3\/main/v2.3\/release/' ./ios/Podfile
else
    new_ref="qianfan"
    sed -i '' 's/v2.3\/release/v2.3\/main/' ./ios/Podfile
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
#for file in "pubspec.lock" "./ios/Podfile.lock"; do
#  if [ -f "$file" ]; then
#    rm "$file"
#  fi
#done

if [ $env == "prod" ]; then
  flutter build ipa --export-options-plist=./ios/exportAppstore.plist --release -t lib/main_prod.dart --flavor prod --no-tree-shake-icons
else
  flutter build ipa --export-options-plist=./ios/exportTest.plist --release -t lib/main_${env}.dart --flavor $env --no-tree-shake-icons
  sh ./pgyer_upload.sh -k "$PGYER_KEY" ./build/ios/ipa/*.ipa
fi