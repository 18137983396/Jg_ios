#!/bin/sh

#此程序是打普通的独立包程序，有引导页-------------极光202017-06-8

#参数判断  ！= == -ne
if [ $# != 1 ];then
echo "需要一个参数。 参数是游戏包的名子"
exit
fi

echo "极小光开始打包..."

#UNITY程序的路径#
UNITY_PATH=/Applications/Unity/Unity.app/Contents/MacOS/Unity

echo "极小光正在读取UNITY程序的路径..."

#游戏程序路径#
PROJECT_PATH=/Users/jiguang/Desktop/独立包专属自动打包/Brance_DuLiBao_V31

echo "极小光正在读取游戏程序的路径..."

#把Assets资源替换到Brance_DuLiBao_V31空工程中
AssetsPATH=/Users/jiguang/Desktop/独立包专属自动打包/Assets
OrdelGamePATH=${PROJECT_PATH}/Assets/Resources/Game
OrdelGameResourcesPATH=${PROJECT_PATH}/Assets/Resources
OrdelStreamingAssetsPATH=${PROJECT_PATH}/Assets/StreamingAssets
GamePATH=${AssetsPATH}/Resources/Game
StreamingAssetsPATH=${AssetsPATH}/StreamingAssets

#强制删除
rm -r -f $OrdelGamePATH

echo "极小光正在删除OrdelGamePATH..."

#强制拷贝
cp -r -f $GamePATH $OrdelGameResourcesPATH

echo "极小光正在强制拷贝Resources..."


#更新这个步骤
rm -r -f $OrdelStreamingAssetsPATH

cp -r -f $StreamingAssetsPATH $OrdelStreamingAssetsPATH
#循环递归拷贝
#cp -r -f $StreamingAssetsPATH/* $OrdelStreamingAssetsPATH
echo "极小光正在循环递归拷贝StreamingAssets..."

#IOS打包脚本路径#
#BUILD_IOS_PATH=${PROJECT_PATH}/Assets/buildios.sh#

#生成的Xcode工程路径#
XCODE_PATH=${PROJECT_PATH}/$1

#Xcode应用的路径# 打开xcode的方式
XCODE_PATH1=/Applications/Xcode.app/Contents/MacOS/Xcode
# $UNITY_PATH

echo "极小光正在自动启动unity引擎..."

echo "极小光正在Importing Assets..."

#将unity导出成xcode工程#
$UNITY_PATH -projectPath $PROJECT_PATH -executeMethod ProjectBuild.BuildForIPhone project-$1 -quit

echo "极小光正在导出projectPath..."

UnityAppControllerH=${XCODE_PATH}/Classes/UnityAppController.h
UnityAppControllerM=${XCODE_PATH}/Classes/UnityAppController.mm

#删除unity多余产生的本地h、m文件
rm $UnityAppControllerH $UnityAppControllerM
#$XCODE_PATH1 -projectPath $XCODE_PATH
# $XCODE_PATH

echo "极小光正在删除unity多余产生的本地h、m文件..."

#拷贝xcode图片资源
ImagesXcassetsPATH=/Users/jiguang/Desktop/新版独立包配置资源文件/Images.xcassets
OldeImagesXcassetsPATH=${XCODE_PATH}/Unity-iPhone

echo "极小光正在拷贝xcode图片资源..."

cp -r -f $ImagesXcassetsPATH $OldeImagesXcassetsPATH

echo "XCODE工程生成完毕"

echo "极小光打包成功！！！"


