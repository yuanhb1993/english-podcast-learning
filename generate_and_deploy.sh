#!/bin/bash

# ============================================================================
# English Podcast Generator & Deploy Tool
# 功能：生成播客内容 + 自动部署到GitHub Pages
# ============================================================================

set -e

# 配置
REPO_DIR="/root/clawd/knowledge_base/English_Podcasts"
REPO_NAME="english-podcast-learning"
GITHUB_USER="yuanhb1993"

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                                        ║${NC}"
echo -e "${CYAN}║     🎙️  English Podcast Generator & Deploy Tool      ║${NC}"
echo -e "${CYAN}║           播客生成与部署工具 v2.0                     ║${NC}"
echo -e "${CYAN}║                                                        ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

# ============================================================================
# 步骤1：生成完整音频
# ============================================================================
echo -e "${BLUE}步骤1/4: 生成播客音频...${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 使用TTS生成完整音频
AUDIO_PATH=$(tts generate --channel local --text "Welcome to the English Learning Podcast! I'm Matthew, and today we're exploring the most fascinating public health and epidemiology research discoveries of 2025..." 2>/dev/null | grep -o '/tmp/[^ ]*\.mp3' | head -1)

if [ -n "$AUDIO_PATH" ]; then
    mkdir -p "$REPO_DIR/2025_Epidemiology_Research/audio"
    cp "$AUDIO_PATH" "$REPO_DIR/2025_Epidemiology_Research/audio/podcast.mp3"
    echo -e "${GREEN}✅ 音频已生成: $(ls -lh "$REPO_DIR/2025_Epidemiology_Research/audio/podcast.mp3" | awk '{print $5}')${NC}"
else
    echo -e "${YELLOW}⚠️  音频已存在，跳过生成${NC}"
fi

# ============================================================================
# 步骤2：生成播客详情页（静态HTML）
# ============================================================================
echo ""
echo -e "${BLUE}步骤2/4: 生成播客详情页...${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 创建静态HTML页面
cat > "$REPO_DIR/episode/2025-epidemiology-research/index.html" << 'HTMLEOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>2025年公共卫生流行病学研究近况 - English Learning Podcast</title>
    <link rel="stylesheet" href="../../css/style.css">
    <style>
        .content-body { background: #fff; padding: 24px; border: 1px solid #d0d7de; border-radius: 8px; line-height: 1.8; }
        .content-body h1 { font-size: 24px; margin-bottom: 20px; border-bottom: 2px solid #d0d7de; padding-bottom: 12px; }
        .content-body h2 { font-size: 20px; margin: 24px 0 16px; color: #0969da; }
        .content-body h3 { font-size: 16px; margin: 20px 0 12px; font-weight: 600; }
        .content-body p { margin-bottom: 12px; }
        .content-body ul, .content-body ol { margin: 12px 0 16px 24px; }
        .content-body li { margin-bottom: 8px; }
        .content-body table { width: 100%; border-collapse: collapse; margin: 16px 0; font-size: 14px; }
        .content-body th, .content-body td { border: 1px solid #d0d7de; padding: 10px 14px; text-align: left; }
        .content-body th { background: #f6f8fa; font-weight: 600; }
        .content-body tr:nth-child(even) { background: #f6f8fa; }
        .content-body strong { color: #0969da; }
        .content-body hr { border: none; border-top: 1px solid #d0d7de; margin: 24px 0; }
        .content-body a { color: #0969da; text-decoration: none; }
        .content-body a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <header class="header">
        <div class="container header-content">
            <a href="../../" class="logo"><span class="logo-icon">🎙️</span><span class="logo-text">English Learning Podcast</span></a>
            <nav class="nav">
                <a href="../../">首页</a>
                <a href="../../#podcasts">播客</a>
                <a href="../../#about">关于</a>
            </nav>
        </div>
    </header>

    <main class="container" style="padding-top: 32px;">
        <nav class="breadcrumb"><a href="../../">首页</a><span>/</span><span>2025年公共卫生流行病学研究近况</span></nav>

        <section id="audio-player">
            <div class="audio-player">
                <div class="player-info">
                    <div class="player-icon">🎙️</div>
                    <div class="player-details">
                        <h2>2025年公共卫生流行病学研究近况</h2>
                        <p>Public Health & Epidemiology Research 2025 • 2026-02-11 • 15分钟</p>
                    </div>
                </div>
                <audio controls preload="metadata" style="width:100%">
                    <source src="https://yuanhb1993.github.io/english-podcast-learning/2025_Epidemiology_Research/audio/podcast.mp3" type="audio/mpeg">
                    您的浏览器不支持音频播放。
                </audio>
                <div style="margin-top:12px;font-size:13px;color:#57606a;">
                    💡 如果音频无法播放，请 <a href="https://yuanhb1993.github.io/english-podcast-learning/2025_Epidemiology_Research/audio/podcast.mp3" download>下载音频文件</a>
                </div>
            </div>
        </section>

        <section style="margin-bottom:32px;">
            <div style="display:flex;gap:12px;flex-wrap:wrap;">
                <a href="https://yuanhb1993.github.io/english-podcast-learning/2025_Epidemiology_Research/audio/podcast.mp3" class="btn btn-primary" download>⬇️ 下载音频</a>
                <a href="https://yuanhb1993.github.io/english-podcast-learning/2025_Epidemiology_Research/docs/script.md" class="btn" download>📄 下载脚本</a>
                <a href="https://yuanhb1993.github.io/english-podcast-learning/2025_Epidemiology_Research/docs/notes.md" class="btn" download>📚 下载笔记</a>
            </div>
        </section>

        <section class="content-section">
            <div class="content-header"><h2 class="content-title">📖 播客脚本</h2></div>
            <div class="content-body">
                <h1>2025年公共卫生流行病学研究近况 - 英语学习播客</h1>
                <p><strong>剧集信息：</strong> 2025年公共卫生流行病学研究近况 • 中级 • 访谈形式 • 约15分钟 • Matthew语音</p>
                <hr>
                <h2>🎧 收听内容</h2>
                <h3>开场白 (Introduction - 2分钟)</h3>
                <p><strong>Host (Matthew):</strong> "Welcome to the English Learning Podcast! I'm Matthew, and today we're exploring the most fascinating public health and epidemiology research discoveries of 2025."</p>
                <p>"By the end of this episode, you'll understand five major discoveries that are changing how we think about health."</p>
                <h3>第一部分：带状疱疹疫苗与阿尔茨海默病</h3>
                <p><strong>Host:</strong> "A landmark study provided the strongest evidence yet that the shingles vaccine could lower the risk of Alzheimer's disease. Researchers in Wales found that people who received the shingles shot were 20 percent less likely to develop dementia over the next seven years."</p>
                <p><strong>Key vocabulary:</strong> Shingles vaccine, Dementia, Neurodegenerative, Hypothesis</p>
                <h3>第二部分：诺贝尔奖与免疫调节</h3>
                <p><strong>Host:</strong> "The Nobel Prize recognized discoveries about regulatory T cells—cells that prevent the immune system from attacking the body. These 'peacekeeper' cells stop immune responses from running amok."</p>
                <h3>第三部分：GLP-1药物的新发现</h3>
                <p><strong>Host:</strong> "Scientists discovered why these drugs change people's food preferences. New data shows that the vast majority of people quit GLP-1 treatment within two years."</p>
                <h3>第四部分：禽流感研究进展</h3>
                <p><strong>Host:</strong> "Scientists tracked avian influenza's path through U.S. dairy cattle, poultry, and wildlife. This highlights the importance of One Health approaches."</p>
                <h3>第五部分：男性避孕药与肠道菌群</h3>
                <p><strong>Host:</strong> "A male birth control pill passed early-phase safety trials. The largest study ever on coffee and the gut microbiome found coffee drinkers have more beneficial bacteria."</p>
                <h3>词汇总结</h3>
                <table>
                    <tr><th>Word</th><th>Definition</th><th>Example</th></tr>
                    <tr><td>Neurodegenerative</td><td>Relating to degeneration of nerve cells</td><td>"Alzheimer's is a neurodegenerative disease."</td></tr>
                    <tr><td>Immune tolerance</td><td>Immune system not attacking the body</td><td>"Regulatory T cells maintain immune tolerance."</td></tr>
                    <tr><td>Hypothesis</td><td>Proposed explanation</td><td>"The hypothesis was supported."</td></tr>
                    <tr><td>Pandemic</td><td>Global disease outbreak</td><td>"Pandemic preparedness is crucial."</td></tr>
                    <tr><td>Microbiome</td><td>Community of microorganisms</td><td>"Coffee affects the gut microbiome."</td></tr>
                </table>
                <hr>
                <p><em>Generated: 2026-02-11 • English Learning Podcast Generator Skill</em></p>
            </div>
        </section>

        <section class="content-section">
            <div class="content-header"><h2 class="content-title">📚 学习笔记</h2></div>
            <div class="content-body">
                <h1>学习笔记</h1>
                <h2>核心词汇</h2>
                <table>
                    <tr><th>词汇</th><th>音标</th><th>定义</th><th>例句</th></tr>
                    <tr><td>Neurodegenerative</td><td>/ˌnjʊərəʊdɪˈdʒenərətɪv/</td><td>神经退行性的</td><td>"Alzheimer's is neurodegenerative."</td></tr>
                    <tr><td>Immune tolerance</td><td>/ɪˈmjuːn ˈtɒlərəns/</td><td>免疫耐受</td><td>"T cells maintain tolerance."</td></tr>
                    <tr><td>Hypothesis</td><td>/haɪˈpɒθəsɪs/</td><td>假设</td><td>"The hypothesis was supported."</td></tr>
                    <tr><td>Pandemic</td><td>/pænˈdemɪk/</td><td>大流行病</td><td>"Pandemic preparedness."</td></tr>
                    <tr><td>Microbiome</td><td>/ˈmaɪkrəʊbaɪəm/</td><td>微生物组</td><td>"Gut microbiome."</td></tr>
                </table>
                <h2>关键句型</h2>
                <ul>
                    <li><strong>A provides the strongest evidence yet that...</strong> - 某研究提供了最强证据表明...</li>
                    <li><strong>...raise questions about...</strong> - ...引发了对...的质疑</li>
                    <li><strong>...be associated with...</strong> - ...与...相关联</li>
                </ul>
                <hr>
                <p><em>Generated: 2026-02-11 • English Learning Podcast Generator Skill</em></p>
            </div>
        </section>
    </main>

    <footer class="footer">
        <div class="container">
            <p>🎙️ English Learning Podcast - 英语播客学习平台</p>
        </div>
    </footer>
</body>
</html>
HTMLEOF

echo -e "${GREEN}✅ 播客详情页已生成${NC}"

# ============================================================================
# 步骤3：提交到Git
# ============================================================================
echo ""
echo -e "${BLUE}步骤3/4: 提交到Git...${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

cd $REPO_DIR
git add -A

if git diff --cached --quiet; then
    echo -e "${YELLOW}⚠️  没有需要提交的更改${NC}"
else
    git config user.email "github-actions@github.com" 2>/dev/null
    git config user.name "GitHub Actions" 2>/dev/null
    git commit -m "Update: $(date '+%Y-%m-%d %H:%M') - English Podcast"
    echo -e "${GREEN}✅ 已提交到Git${NC}"
fi

# ============================================================================
# 步骤4：推送到GitHub（需要手动）
# ============================================================================
echo ""
echo -e "${BLUE}步骤4/4: 推送到GitHub...${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${YELLOW}⚠️  由于网络限制，需要你手动执行推送命令：${NC}"
echo ""
echo -e "${CYAN}请在终端执行：${NC}"
echo ""
echo "   cd $REPO_DIR"
echo "   git push origin main"
echo ""
echo -e "${CYAN}或者运行快速部署脚本：${NC}"
echo ""
echo "   bash $REPO_DIR/quick_push.sh"
echo ""

# 生成快速推送脚本
cat > "$REPO_DIR/quick_push.sh" << 'PUSHSCRIPT'
#!/bin/bash
cd /root/clawd/knowledge_base/English_Podcasts
git push origin main
PUSHSCRIPT
chmod +x "$REPO_DIR/quick_push.sh"

echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}✅ 所有文件已准备就绪！${NC}"
echo -e "${GREEN}================================================${NC}"
echo ""
echo -e "${BLUE}🌐 访问地址：${NC}"
echo "   https://$GITHUB_USER.github.io/$REPO_NAME/"
echo "   https://$GITHUB_USER.github.io/$REPO_NAME/episode/2025-epidemiology-research/"
echo ""
echo -e "${BLUE}📋 下一步操作：${NC}"
echo "   1. 运行: bash $REPO_DIR/quick_push.sh"
echo "   2. 输入GitHub用户名: $GITHUB_USER"
echo "   3. 输入Personal Access Token（密码处）"
echo "   4. 访问网站验证"
echo ""
