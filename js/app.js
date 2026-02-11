const REPO_NAME = "english-podcast-learning";
// English Podcast Learning Platform - Frontend Logic

// Podcast Data Configuration
// Note: All paths include the repository name "english-podcast-learning" for GitHub Pages deployment
const REPO_NAME = "english-podcast-learning";

const podcasts = [
    {
        id: "2025-epidemiology-research",
        title: "2025年公共卫生流行病学研究近况",
        titleEn: "Public Health & Epidemiology Research 2025",
        description: "探索2025年最重要的公共卫生和流行病学发现，包括带状疱疹疫苗与阿尔茨海默病、诺贝尔奖研究、GLP-1药物等五大突破性发现。",
        category: "research",
        duration: "15分钟",
        difficulty: "中级",
        date: "2026-02-11",
        files: {
<<<<<<< HEAD
            audio: REPO_NAME + "/2025_Epidemiology_Research/audio/podcast.mp3",
            script: REPO_NAME + "/2025_Epidemiology_Research/docs/script.md",
            notes: REPO_NAME + "/2025_Epidemiology_Research/docs/notes.md"
=======
    audio: REPO_NAME + "/2025_Epidemiology_Research/audio/podcast.mp3",
    script: REPO_NAME + "/2025_Epidemiology_Research/docs/script.md",
    notes: REPO_NAME + "/2025_Epidemiology_Research/docs/notes.md"
>>>>>>> 185f72d52c72ffbc0a7b7c4ba5933aae98192469
        }
    }
];

// Initialize the application
document.addEventListener('DOMContentLoaded', function() {
    const currentPage = getCurrentPage();
    
    switch(currentPage) {
        case 'home':
            renderHomePage();
            break;
        case 'detail':
            renderDetailPage();
            break;
    }
});

// Get current page type
function getCurrentPage() {
    const path = window.location.pathname;
    if (path.includes('/episode/')) {
        return 'detail';
    }
    return 'home';
}

// Get podcast by ID
function getPodcastById(id) {
    return podcasts.find(p => p.id === id);
}

// Render home page with podcast list
function renderHomePage() {
    const container = document.getElementById('podcast-grid');
    if (!container) return;
    
    // Group podcasts by category
    const categories = {
        research: { title: "Research & Studies", podcasts: [] },
        general: { title: "General English", podcasts: [] },
        business: { title: "Business English", podcasts: [] }
    };
    
    podcasts.forEach(podcast => {
        if (categories[podcast.category]) {
            categories[podcast.category].podcasts.push(podcast);
        }
    });
    
    // Render podcast grid
    container.innerHTML = podcasts.map(podcast => createPodcastCard(podcast)).join('');
}

// Create podcast card HTML
function createPodcastCard(podcast) {
    const categoryLabels = {
        research: "🔬 研究",
        general: "📚 综合",
        business: "💼 商务"
    };
    
    return `
        <a href="episode/${podcast.id}/" class="podcast-card">
            <div class="card-image">
                <span class="card-image-icon">🎙️</span>
                <div class="play-overlay">
                    <div class="play-button"></div>
                </div>
            </div>
            <div class="card-content">
                <h3 class="card-title">${podcast.title}</h3>
                <div class="card-meta">
                    <span>📅 ${podcast.date}</span>
                    <span>⏱️ ${podcast.duration}</span>
                </div>
                <div class="card-tags">
                    <span class="tag">${categoryLabels[podcast.category]}</span>
                    <span class="tag duration">${podcast.difficulty}</span>
                </div>
            </div>
        </a>
    `;
}

// Render detail page
function renderDetailPage() {
    const episodeId = getEpisodeIdFromUrl();
    const podcast = getPodcastById(episodeId);
    
    if (!podcast) {
        showError('Podcast not found');
        return;
    }
    
    // Update page title
    document.title = `${podcast.title} - English Learning Podcast`;
    
    // Render audio player
    renderAudioPlayer(podcast);
    
    // Load and render markdown content
    loadMarkdownContent(podcast.files.script, 'script-content');
    loadMarkdownContent(podcast.files.notes, 'notes-content');
    
    // Setup download buttons
    setupDownloadButtons(podcast);
}

// Get episode ID from URL
function getEpisodeIdFromUrl() {
    const path = window.location.pathname;
    const match = path.match(/\/episode\/([^/]+)\/?/);
    return match ? match[1] : null;
}

// Render audio player
function renderAudioPlayer(podcast) {
    const container = document.getElementById('audio-player');
    if (!container) return;
    
    container.innerHTML = `
        <div class="player-info">
            <div class="player-icon">🎙️</div>
            <div class="player-details">
                <h2>${podcast.title}</h2>
                <p>${podcast.titleEn} • ${podcast.date} • ${podcast.duration}</p>
            </div>
        </div>
        <audio controls preload="metadata">
            <source src="${podcast.files.audio}" type="audio/mpeg">
            Your browser does not support the audio element.
        </audio>
    `;
}

// Load markdown content
async function loadMarkdownContent(filePath, containerId) {
    const container = document.getElementById(containerId);
    if (!container) return;
    
    try {
        const response = await fetch(filePath);
        if (!response.ok) {
            throw new Error('Failed to load content');
        }
        const markdown = await response.text();
        container.innerHTML = parseMarkdown(markdown);
    } catch (error) {
        console.error('Error loading markdown:', error);
        container.innerHTML = '<p class="text-secondary">无法加载内容，请稍后重试。</p>';
    }
}

// Simple markdown parser
function parseMarkdown(markdown) {
    // Headers
    markdown = markdown.replace(/^### (.+)$/gm, '<h3 id="$1">$1</h3>');
    markdown = markdown.replace(/^## (.+)$/gm, '<h2 id="$1">$1</h2>');
    markdown = markdown.replace(/^# (.+)$/gm, '<h1 id="$1">$1</h1>');
    
    // Bold
    markdown = markdown.replace(/\*\*(.+?)\*\*/g, '<strong>$1</strong>');
    
    // Italic
    markdown = markdown.replace(/\*(.+?)\*/g, '<em>$1</em>');
    
    // Code blocks
    markdown = markdown.replace(/```(\w+)?\n([\s\S]*?)```/g, '<pre><code>$2</code></pre>');
    markdown = markdown.replace(/`(.+?)`/g, '<code>$1</code>');
    
    // Lists
    markdown = markdown.replace(/^- (.+)$/gm, '<li>$1</li>');
    markdown = markdown.replace(/(<li>.*<\/li>\n?)+/g, '<ul>$&</ul>');
    
    // Tables (basic support)
    markdown = markdown.replace(/\|(.+)\|/g, function(match) {
        const cells = match.split('|').filter(c => c.trim());
        if (cells[0].includes('---')) {
            return '';
        }
        if (cells.every(c => c.trim().startsWith('---'))) {
            return '';
        }
        return '<tr>' + cells.map(c => `<td>${c.trim()}</td>`).join('') + '</tr>';
    });
    
    // Line breaks
    markdown = markdown.replace(/\n\n/g, '</p><p>');
    markdown = markdown.replace(/\n/g, '<br>');
    
    return `<div class="markdown-body"><p>${markdown}</p></div>`;
}

// Setup download buttons
function setupDownloadButtons(podcast) {
    const audioBtn = document.getElementById('download-audio');
    const scriptBtn = document.getElementById('download-script');
    const notesBtn = document.getElementById('download-notes');
    
    if (audioBtn) {
        audioBtn.href = podcast.files.audio;
        audioBtn.download = `${podcast.id}_podcast.mp3`;
    }
    
    if (scriptBtn) {
        scriptBtn.href = podcast.files.script;
        scriptBtn.download = `${podcast.id}_script.md`;
    }
    
    if (notesBtn) {
        scriptBtn.href = podcast.files.notes;
        scriptBtn.download = `${podcast.id}_notes.md`;
    }
}

// Show error message
function showError(message) {
    const container = document.querySelector('.container');
    container.innerHTML = `
        <div class="empty-state">
            <div class="empty-state-icon">⚠️</div>
            <h3>出错了</h3>
            <p>${message}</p>
            <a href="./" class="btn mt-16">返回首页</a>
        </div>
    `;
}

// Utility: Format date
function formatDate(dateStr) {
    const date = new Date(dateStr);
    return date.toLocaleDateString('zh-CN', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
}

// Utility: Get relative time
function getRelativeTime(dateStr) {
    const date = new Date(dateStr);
    const now = new Date();
    const diff = now - date;
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
    
    if (days === 0) return '今天';
    if (days === 1) return '昨天';
    if (days < 7) return `${days}天前`;
    if (days < 30) return `${Math.floor(days / 7)}周前`;
    return formatDate(dateStr);
}
