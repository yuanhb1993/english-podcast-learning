#!/bin/bash

# English Podcast Learning Platform - 部署脚本
# 用途：修复跨域问题，更新GitHub Pages

echo "================================================"
echo "🎙️ English Podcast Learning Platform - 部署脚本"
echo "================================================"

# 检查是否在正确的目录
if [ ! -f "index.html" ]; then
    echo "❌ 错误：请在 English_Podcasts 目录下运行此脚本"
    echo "   cd /root/clawd/knowledge_base/English_Podcasts"
    echo "   然后运行：bash deploy.sh"
    exit 1
fi

echo ""
echo "📋 部署步骤："
echo ""
echo "1️⃣ 备份当前文件..."
cp episode/2025-epidemiology-research/index.html episode/2025-epidemiology-research/index.html.backup 2>/dev/null
echo "   ✅ 备份完成"

echo ""
echo "2️⃣ 复制修复版本..."
cp episode/2025-epidemiology-research/index-static.html episode/2025-epidemiology-research/index.html
echo "   ✅ 复制完成"

echo ""
echo "3️⃣ 提交更改..."
git add -A
git commit -m "Fix CORS issue: Embed content directly in HTML for GitHub Pages"
echo "   ✅ 提交完成"

echo ""
echo "4️⃣ 推送到GitHub..."
echo ""
echo "📝 请输入以下命令（需要GitHub用户名和Personal Access Token）："
echo ""
echo "   git push origin main"
echo ""
echo "💡 如果遇到冲突，请先运行："
echo "   git pull origin main --allow-unrelated-histories --no-rebase"
echo "   然后再运行：git push origin main"
echo ""

echo "================================================"
echo "✅ 部署准备完成！"
echo "================================================"
echo ""
echo "🌐 访问地址：https://yuanhb1993.github.io/english-podcast-learning/"
echo ""
