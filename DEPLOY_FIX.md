# 部署修复补丁

## 问题
GitHub Pages存在跨域问题(CORS)，导致：
- 音频无法在线播放
- 脚本和笔记无法加载

## 解决方案
修改 `episode/2025-epidemiology-research/index.html`：
- 直接嵌入播客脚本和学习笔记内容
- 使用完整GitHub Pages URL加载音频

## 文件修改

### 修改前的问题代码
```html
<script src="../../js/app.js"></script>
<!-- JavaScript通过fetch加载内容，跨域被阻止 -->
```

### 修改后的解决方案
- HTML中直接包含所有内容
- 使用完整URL: `https://yuanhb1993.github.io/english-podcast-learning/...`
- 不依赖JavaScript动态加载

## 在本地执行以下命令

```bash
cd /root/clawd/knowledge_base/English_Podcasts

# 1. 拉取远程更改
git pull origin main --allow-unrelated-histories --no-rebase

# 2. 如果有冲突，手动解决（用本地版本覆盖远程版本）
# 直接复制新版本
cp episode/2025-epidemiology-research/index.html episode/2025-epidemiology-research/index.html.bak
cp episode/2025-epidemiology-research/index-static.html episode/2025-epidemiology-research/index.html

# 3. 提交并推送
git add -A
git commit -m "Fix CORS: Embed content directly in HTML"
git push origin main
```

## 或者使用GitHub网页操作

1. 访问：https://github.com/yuanhb1993/english-podcast-learning/tree/main/episode/2025-epidemiology-research

2. 删除原来的 `index.html`

3. 重命名 `index-static.html` 为 `index.html`

4. 提交更改

## 验证修复

访问：https://yuanhb1993.github.io/english-podcast-learning/episode/2025-epidemiology-research/

应该能正常：
- ✅ 播放音频
- ✅ 查看播客脚本
- ✅ 查看学习笔记
