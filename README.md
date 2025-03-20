### How to build

在项目根目录下新建.secret文件   
PGYER_KEY=your_pgyer_key  

./build_android.sh   
./build_ios.sh   

### How to run

以Android Studio为例   
1.Dart entrypoint一栏指定入口（main_prod/main_qa/main_dev）；    
2.Build flavor一栏指定环境（prod/qa/dev）；  

### Aside from this
1.Android Studio安装2个插件：FlutterJsonBeanFactory和GetX；    
2.找@zhao xiaokai 开通kfps插件的gitlab仓库read权限；  