#!/bin/bash

# 快速推送到GitHub - 自动处理冲突
# 自动化执行，无需手动输入

TOKEN_FILE="/root/.config/english-podcast/github_token"
REPO_DIR="/root/clawd/knowledge_base/English_Podcasts"
GITHUB_USER="yuanhb1993"
REPO_NAME="english-podcast-learning"

cd "$REPO_DIR"

# 检查token是否存在
if [ ! -f "$TOKEN_FILE" ]; then
    echo "❌ Token未找到，请先配置GitHub Token"
    exit 1
fi

# 读取token
TOKEN=$(cat "$TOKEN_FILE")

echo "🚀 推送到GitHub Pages..."
echo "📦 仓库: $GITHUB_USER/$REPO_NAME"
echo ""

# 拉取远程更改（自动合并）
echo "📥 拉取远程更改..."
git pull https://${GITHUB_USER}:${TOKEN}@github.com/${GITHUB_USER}/${REPO_NAME}.git main --allow-unrelated-histories --no-rebase

if [ $? -ne 0 ]; then
    echo ""
    echo "⚠️  拉取失败，尝试强制推送..."
    echo "   如果你确定要覆盖远程，请运行:"
    echo "   git push https://${GITHUB_USER}:TOKEN@github.com/${GITHUB_USER}/${REPO_NAME}.git main --force"
    exit 1
fi

echo ""
echo "📤 推送到GitHub..."
git push https://${GITHUB_USER}:${TOKEN}@github.com/${GITHUB_USER}/${REPO_NAME}.git main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 推送成功！"
    echo ""
    echo "🌐 访问网站（1-2分钟后生效）:"
    echo "   https://$GITHUB_USER.github.io/$REPO_NAME/"
    echo "   https://$GITHUB_USER.github.io/$REPO_NAME/episode/2025-epidemiology-research/"
else
    echo ""
    echo "❌ 推送失败"
    exit 1
fi
