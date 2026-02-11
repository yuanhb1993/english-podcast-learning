#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Generate podcasts for both research topics using the new Skill
"""

import sys
sys.path.insert(0, '/root/.openclaw/skills/english-learning-podcast-generator')

from src import ContentAnalyzer, ScriptGenerator, LearningNotesGenerator, PodcastConfig

def generate_podcast(content: str, topic: str, style: str = "interview", level: str = "advanced"):
    """Generate complete podcast for given content"""
    print(f"\n{'='*60}")
    print(f"Generating podcast for: {topic}")
    print(f"{'='*60}")
    
    # 配置
    config = PodcastConfig()
    config.script.style = style
    config.script.level = level
    
    # Stage 1: 内容分析
    print(f"\n📊 Stage 1: Analyzing content...")
    analyzer = ContentAnalyzer(config)
    analysis = analyzer.analyze(content[:15000])  # Limit to 15k chars
    print(f"  ✅ Topic: {analysis.topic}")
    print(f"  ✅ Key points: {len(analysis.key_points)}")
    print(f"  ✅ Vocabulary: {len(analysis.vocabulary)} terms")
    print(f"  ✅ Difficulty: {analysis.difficulty_level}")
    
    # Stage 2: 脚本生成
    print(f"\n📝 Stage 2: Generating script...")
    script_gen = ScriptGenerator(config)
    script = script_gen.generate(analysis)
    print(f"  ✅ Words: {script.estimated_word_count}")
    print(f"  ✅ Duration: {script.estimated_duration_minutes} minutes")
    print(f"  ✅ Sections: {len(script.sections)}")
    
    # Stage 3: 学习笔记
    print(f"\n📚 Stage 3: Creating learning notes...")
    notes_gen = LearningNotesGenerator(config)
    notes = notes_gen.generate(script, analysis)
    print(f"  ✅ Vocabulary: {len(notes.vocabulary)} terms")
    print(f"  ✅ Phrases: {len(notes.phrases)}")
    print(f"  ✅ Comprehension questions: {len(notes.comprehension['questions'])}")
    
    return {
        'analysis': analysis,
        'script': script,
        'notes': notes
    }

# 主程序
if __name__ == "__main__":
    import os
    
    # 1. 流行病学研究报告
    print("\n" + "="*60)
    print("🎙️ GENERATING EPIDEMIOLOGY PODCAST")
    print("="*60)
    
    epi_file = '/root/clawd/knowledge_base/Epidemiology_Research/Epidemiology_Paradigms_Report.md'
    if os.path.exists(epi_file):
        with open(epi_file, 'r', encoding='utf-8') as f:
            epi_content = f.read()
        
        epi_result = generate_podcast(
            content=epi_content,
            topic="流行病学研究范式",
            style="interview",
            level="advanced"
        )
        
        # 保存脚本
        with open('/root/clawd/knowledge_base/English_Podcasts/epidemiology_script_v3.md', 'w', encoding='utf-8') as f:
            f.write(f"# 流行病学研究范式 - 英语学习播客 v3.0\n\n")
            f.write(f"## 剧集信息\n- **时长**: {epi_result['script'].estimated_duration_minutes}分钟\n")
            f.write(f"- **难度**: 高级\n- **风格**: 访谈形式\n- **词汇**: {len(epi_result['notes'].vocabulary)}个术语\n\n")
            f.write(f"## 摘要\n{epi_result['analysis'].thesis}\n\n")
            f.write(f"## 关键要点 ({len(epi_result['analysis'].key_points)})\n")
            for i, point in enumerate(epi_result['analysis'].key_points, 1):
                f.write(f"{i}. {point[:100]}...\n")
            f.write("\n## 词汇表\n")
            for vocab in epi_result['notes'].vocabulary[:10]:
                f.write(f"- **{vocab['word']}**: {vocab.get('chinese', 'N/A')}\n")
        
        print(f"\n✅ Saved: epidemiology_script_v3.md")
    else:
        print(f"❌ File not found: {epi_file}")
    
    # 2. AI研究报告
    print("\n" + "="*60)
    print("🎙️ GENERATING AI PODCAST")
    print("="*60)
    
    ai_file = '/root/clawd/knowledge_base/English_Podcasts/2024_2025_AI_Developments_Research_Report.md'
    if os.path.exists(ai_file):
        with open(ai_file, 'r', encoding='utf-8') as f:
            ai_content = f.read()
        
        ai_result = generate_podcast(
            content=ai_content,
            topic="AI领域主要进展",
            style="interview", 
            level="advanced"
        )
        
        # 保存脚本
        with open('/root/clawd/knowledge_base/English_Podcasts/ai_script_v3.md', 'w', encoding='utf-8') as f:
            f.write(f"# 2024-2025年AI领域主要进展 - 英语学习播客 v3.0\n\n")
            f.write(f"## 剧集信息\n- **时长**: {ai_result['script'].estimated_duration_minutes}分钟\n")
            f.write(f"- **难度**: 高级\n- **风格**: 访谈形式\n- **词汇**: {len(ai_result['notes'].vocabulary)}个术语\n\n")
            f.write(f"## 摘要\n{ai_result['analysis'].thesis}\n\n")
            f.write(f"## 关键要点 ({len(ai_result['analysis'].key_points)})\n")
            for i, point in enumerate(ai_result['analysis'].key_points, 1):
                f.write(f"{i}. {point[:100]}...\n")
            f.write("\n## 词汇表\n")
            for vocab in ai_result['notes'].vocabulary[:10]:
                f.write(f"- **{vocab['word']}**: {vocab.get('chinese', 'N/A')}\n")
        
        print(f"\n✅ Saved: ai_script_v3.md")
    else:
        print(f"❌ File not found: {ai_file}")
    
    print("\n" + "="*60)
    print("🎉 BOTH PODCASTS GENERATED SUCCESSFULLY!")
    print("="*60)

