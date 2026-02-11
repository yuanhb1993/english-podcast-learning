# English Learning Podcast - 英语播客学习平台

基于纯HTML/CSS/JavaScript构建的英语播客学习网站。

## 📁 目录结构

```
English_Podcasts/
├── index.html                      # 主页（播客列表）
├── css/
│   └── style.css                   # GitHub风格样式
├── js/
│   └── app.js                      # 前端交互逻辑
├── assets/                         # 资源文件（可选）
├── episode/                        # 播客详情页
│   └── [播客ID]/
│       └── index.html             # 播客详情页面
├── [播客目录]/                     # 每个播客的资源
│   ├── audio/
│   │   └── podcast.mp3            # 音频文件
│   └── docs/
│       ├── script.md              # 播客脚本
│       └── notes.md               # 学习笔记
└── README.md                       # 本文件
```

## 🚀 如何使用

### 本地查看

1. **直接打开**：
   ```bash
   # 在浏览器中打开
   open English_Podcasts/index.html
   # 或双击 index.html 文件
   ```

2. **启动本地服务器**（推荐，支持完整功能）：
   ```bash
   cd English_Podcasts
   python3 -m http.server 8080
   # 然后访问 http://localhost:8080
   ```

### 添加新播客

#### 步骤1：创建目录结构
```bash
cd English_Podcasts
mkdir -p [播客ID]/audio
mkdir -p [播客ID]/docs
```

#### 步骤2：添加资源文件
- 将MP3文件放入 `audio/podcast.mp3`
- 将脚本保存为 `docs/script.md`
- 将学习笔记保存为 `docs/notes.md`

#### 步骤3：更新配置
编辑 `js/app.js`，在 `podcasts` 数组中添加新播客：

```javascript
const podcasts = [
    {
        id: "[播客ID]",
        title: "播客标题",
        titleEn: "English Title",
        description: "播客简介",
        category: "research", // research | general | business
        duration: "15分钟",
        difficulty: "中级",
        date: "2026-02-11",
        files: {
            audio: "[播客ID]/audio/podcast.mp3",
            script: "[播客ID]/docs/script.md",
            notes: "[播客ID]/docs/notes.md"
        }
    }
];
```

## 🎨 设计风格

- **GitHub风格**：简洁、白色/灰色配色
- **响应式设计**：支持桌面和移动设备
- **无需后端**：纯静态文件，可直接部署

## 🌐 部署选项

### GitHub Pages（免费，推荐）

1. 创建GitHub仓库
2. 上传所有文件
3. 在仓库设置中启用GitHub Pages
4. 访问 `https://[用户名].github.io/[仓库名]/`

### Vercel（免费）

```bash
npm install -g vercel
cd English_Podcasts
vercel --prod
```

### Nginx服务器

```nginx
server {
    listen 80;
    server_name your-domain.com;
    root /path/to/English_Podcasts;
    index index.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
    
    # 支持MP3和Markdown文件下载
    location ~* \.(mp3|md)$ {
        add_header Content-Disposition attachment;
    }
}
```

## 📱 功能特性

- ✅ 播客列表展示
- ✅ 在线音频播放
- ✅ 播客脚本阅读
- ✅ 学习笔记查看
- ✅ 文件下载
- ✅ 响应式设计
- ✅ GitHub风格界面

## 🔧 技术栈

- **HTML5** - 语义化标记
- **CSS3** - GitHub风格样式
- **JavaScript (ES6+)** - 前端交互
- **无框架依赖** - 纯原生实现

## 📝 文件格式要求

### 音频文件
- 格式：MP3
- 编码：AAC或MP3
- 采样率：44.1 kHz

### Markdown文件
- 编码：UTF-8
- 扩展名：.md
- 语法：标准Markdown

## 🤝 贡献指南

1. Fork本项目
2. 创建特性分支
3. 提交更改
4. 发起Pull Request

## 📄 许可证

MIT License

---

**Built with OpenClaw AI Assistant**
**Generated with English Learning Podcast Generator Skill**
