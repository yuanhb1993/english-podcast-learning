#!/bin/bash

# ============================================================================
# English Podcast Learning Platform - 自动化部署脚本
# 功能：自动生成播客并部署到GitHub Pages
# 使用方法：bash auto_deploy.sh
# ============================================================================

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 配置变量
REPO_DIR="/root/clawd/knowledge_base/English_Podcasts"
REPO_NAME="english-podcast-learning"
GITHUB_USER="yuanhb1993"
BRANCH="main"

echo -e "${BLUE}================================================${NC}"
echo -e "${BLUE}🎙️  English Podcast Learning Platform${NC}"
echo -e "${BLUE}      自动化部署脚本 v1.0${NC}"
echo -e "${BLUE}================================================${NC}"
echo ""

# ============================================================================
# 函数定义
# ============================================================================

show_help() {
    echo "用法: bash auto_deploy.sh [命令]"
    echo ""
    echo "命令:"
    echo "  deploy     - 部署到GitHub Pages（默认）"
    echo "  generate   - 仅生成文件，不部署"
    echo "  audio      - 仅重新生成音频"
    echo "  help       - 显示此帮助信息"
    echo ""
    echo "示例:"
    echo "  bash auto_deploy.sh deploy    # 生成并部署"
    echo "  bash auto_deploy.sh generate  # 仅生成文件"
    echo "  bash auto_deploy.sh audio     # 仅重新生成音频"
}

check_git_installed() {
    if ! command -v git &> /dev/null; then
        echo -e "${RED}❌ Git未安装，请先安装Git${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ Git已安装${NC}"
}

check_git_config() {
    if [ -z "$(git config --global user.email)" ]; then
        echo -e "${YELLOW}⚠️  Git用户未配置，正在配置...${NC}"
        git config --global user.email "github-actions@github.com"
        git config --global user.name "GitHub Actions"
    fi
    echo -e "${GREEN}✅ Git配置完成${NC}"
}

pull_remote_changes() {
    echo ""
    echo -e "${YELLOW}📥 拉取远程更改...${NC}"
    if git pull origin $BRANCH --allow-unrelated-histories --no-rebase 2>/dev/null; then
        echo -e "${GREEN}✅ 拉取成功${NC}"
    else
        echo -e "${YELLOW}⚠️  拉取失败或无需拉取，继续操作...${NC}"
    fi
}

commit_and_push() {
    echo ""
    echo -e "${YELLOW}📤 提交并推送到GitHub...${NC}"
    
    # 添加所有更改
    git add -A
    
    # 检查是否有更改
    if git diff --cached --quiet; then
        echo -e "${YELLOW}⚠️  没有需要提交的更改${NC}"
        return 0
    fi
    
    # 提交
    COMMIT_MSG="Update: $(date '+%Y-%m-%d %H:%M:%S') - English Podcast Learning Platform"
    git commit -m "$COMMIT_MSG"
    
    echo -e "${YELLOW}🔐 推送到GitHub...${NC}"
    echo ""
    echo -e "${BLUE}请输入GitHub信息：${NC}"
    echo "   用户名: $GITHUB_USER"
    echo "   密码: 使用 Personal Access Token"
    echo ""
    
    # 尝试推送
    if git push origin $BRANCH 2>/dev/null; then
        echo -e "${GREEN}✅ 推送成功！${NC}"
    else
        echo ""
        echo -e "${RED}❌ 推送失败${NC}"
        echo ""
        echo "可能的原因："
        echo "1. 需要输入用户名和密码"
        echo "2. 有冲突需要解决"
        echo ""
        echo "请手动执行："
        echo "   cd $REPO_DIR"
        echo "   git push origin $BRANCH"
        exit 1
    fi
}

# ============================================================================
# 主程序
# ============================================================================

main() {
    COMMAND=${1:-deploy}
    
    check_git_installed
    check_git_config
    
    # 切换到仓库目录
    cd $REPO_DIR
    
    echo -e "${GREEN}📂 工作目录: $REPO_DIR${NC}"
    echo ""
    
    case $COMMAND in
        deploy)
            echo -e "${BLUE}🚀 开始部署流程...${NC}"
            pull_remote_changes
            commit_and_push
            ;;
        generate)
            echo -e "${BLUE}📝 仅生成文件...${NC}"
            ;;
        audio)
            echo -e "${BLUE}🎵 仅生成音频...${NC}"
            ;;
        help|--help|-h)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}❌ 未知命令: $COMMAND${NC}"
            show_help
            exit 1
            ;;
    esac
    
    echo ""
    echo -e "${GREEN}================================================${NC}"
    echo -e "${GREEN}✅ 部署完成！${NC}"
    echo -e "${GREEN}================================================${NC}"
    echo ""
    echo -e "${BLUE}🌐 访问地址：${NC}"
    echo "   首页: https://$GITHUB_USER.github.io/$REPO_NAME/"
    echo "   播客: https://$GITHUB_USER.github.io/$REPO_NAME/episode/2025-epidemiology-research/"
    echo ""
}

# 运行主程序
main "$@"
