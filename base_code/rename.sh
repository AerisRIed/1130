#!/bin/bash
 
# === 参数检查 ===
if [ "$#" -ne 3 ]; then
    echo "用法: $0 <目录路径> <原始字符串> <替换字符串>"
    echo "例如: $0 /path/to/dir A B"
    exit 1
fi
 
TARGET_DIR="$1"
FROM="$2"
TO="$3"
 
# === 检查目标目录是否存在 ===
if [ ! -d "$TARGET_DIR" ]; then
    echo "错误：目录 $TARGET_DIR 不存在"
    exit 1
fi
 
echo "开始替换：内容和文件名中的 '$FROM' → '$TO'，路径：$TARGET_DIR"
 
# === 替换文件内容 ===
find "$TARGET_DIR"/* -type f -exec sed -i "s/${FROM}/${TO}/g" {} +
 
# === 替换文件名（不含目录名） ===
find "$TARGET_DIR"/* -depth -type f -name "*${FROM}*" | while read file; do
    newname="$(dirname "$file")/$(basename "$file" | sed "s/${FROM}/${TO}/g")"
    mv "$file" "$newname"
done
 
echo "替换完成 ✅"
