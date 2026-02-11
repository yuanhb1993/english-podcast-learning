# English Podcast Learning Platform - 自动化部署指南

## 🎯 快速开始

### 1. 部署到GitHub Pages（一键推送）

```bash
bash /root/clawd/knowledge_base/English_Podcasts/quick_push.sh
```

这将自动推送到GitHub，无需手动输入用户名和密码。

---

## 📁 脚本说明

| 脚本 | 功能 | 使用场景 |
|------|------|---------|
| `quick_push.sh` | ⭐ **最常用** - 一键推送 | 日常更新播客后推送 |
| `auto_deploy.sh` | 完整部署脚本 | 检查Git配置 |
| `generate_and_deploy.sh` | 生成+部署一体化 | 添加新播客时使用 |
| `deploy.sh` | 手动部署指南 | 参考用 |

---

## 🔧 配置

### Token已配置
- ✅ Token已保存到: `/root/.config/english-podcast/github_token`
- ✅ 权限: 600 (仅root可读)

### 仓库信息
- 用户: `yuanhb1993`
- 仓库: `english-podcast-learning`
- 分支: `main`

---

## 📖 使用流程

### 日常更新流程

1. **更新播客内容**（如果需要生成新内容）
```bash
bash /root/clawd/knowledge_base/English_Podcasts/generate_and_deploy.sh
```

2. **推送到GitHub**
```bash
bash /root/clawd/knowledge_base/English_Podcasts/quick_push.sh
```

3. **访问网站**（1-2分钟后生效）
```
https://yuanhb1993.github.io/english-podcast-learning/
```

---

## 🎙️ 添加新播客流程

1. 创建播客内容（使用English Learning Podcast Generator Skill）
2. 复制文件到对应目录
3. 运行生成脚本
4. 推送

---

## 🔒 安全说明

- Token保存在: `/root/.config/english-podcast/github_token`
- 文件权限: 600（仅root可读）
- Token格式: `ghp_xxxxxxxxxxxxxxxxxxxx`
- Token权限: repo (完全访问仓库)

---

## ❓ 常见问题

### Q: Token过期怎么办？
A: 在GitHub设置中生成新token，然后：
```bash
echo "新token" > /root/.config/english-podcast/github_token
```

### Q: 推送失败怎么办？
A: 检查网络连接，或手动推送：
```bash
cd /root/clawd/knowledge_base/English_Podcasts
git push origin main
```

### Q: 如何查看当前token状态？
A:
```bash
cat /root/.config/english-podcast/github_token | cut -c1-10
# 显示前10位，确认存在
```

---

## 🌐 访问地址

- **首页**: https://yuanhb1993.github.io/english-podcast-learning/
- **播客**: https://yuanhb1993.github.io/english-podcast-learning/episode/2025-epidemiology-research/

---

*Generated: 2026-02-11*
*English Learning Podcast Generator Skill*
