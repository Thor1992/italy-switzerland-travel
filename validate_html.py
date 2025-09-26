#!/usr/bin/env python3
"""
验证 HTML 文件的基本结构和 JavaScript 语法
"""

def validate_html():
    try:
        with open('index.html', 'r', encoding='utf-8') as f:
            content = f.read()
        
        print("=== HTML 基本结构检查 ===")
        
        # 检查基本HTML结构
        if '<!DOCTYPE html>' in content:
            print("✅ DOCTYPE 声明存在")
        else:
            print("❌ DOCTYPE 声明缺失")
            
        if '<html' in content and '</html>' in content:
            print("✅ HTML 标签完整")
        else:
            print("❌ HTML 标签不完整")
            
        if '<head>' in content and '</head>' in content:
            print("✅ HEAD 标签完整")
        else:
            print("❌ HEAD 标签不完整")
            
        if '<body' in content and '</body>' in content:
            print("✅ BODY 标签完整")
        else:
            print("❌ BODY 标签不完整")
        
        print("\n=== JavaScript 语法检查 ===")
        
        # 检查JavaScript代码块
        js_start = content.find('<script>')
        js_end = content.rfind('</script>')
        
        if js_start != -1 and js_end != -1:
            js_content = content[js_start+8:js_end]
            print("✅ JavaScript 代码块存在")
            
            # 检查关键对象
            if 'const travelData' in js_content or 'travelData =' in js_content:
                print("✅ travelData 对象存在")
            else:
                print("❌ travelData 对象缺失")
                
            # 检查括号匹配
            open_braces = js_content.count('{')
            close_braces = js_content.count('}')
            
            if open_braces == close_braces:
                print(f"✅ 大括号匹配 ({open_braces} 对)")
            else:
                print(f"❌ 大括号不匹配: 开括号 {open_braces}, 闭括号 {close_braces}")
                
            open_parens = js_content.count('(')
            close_parens = js_content.count(')')
            
            if open_parens == close_parens:
                print(f"✅ 小括号匹配 ({open_parens} 对)")
            else:
                print(f"❌ 小括号不匹配: 开括号 {open_parens}, 闭括号 {close_parens}")
                
            # 检查方括号匹配
            open_brackets = js_content.count('[')
            close_brackets = js_content.count(']')
            
            if open_brackets == close_brackets:
                print(f"✅ 方括号匹配 ({open_brackets} 对)")
            else:
                print(f"❌ 方括号不匹配: 开括号 {open_brackets}, 闭括号 {close_brackets}")
        else:
            print("❌ JavaScript 代码块不完整")
        
        print("\n=== 酒店预订信息检查 ===")
        
        # 检查更新的酒店信息
        if '5340.114.855' in content:
            print("✅ Arham Guesthouse 预订信息已更新")
        else:
            print("❌ Arham Guesthouse 预订信息未更新")
            
        # 检查是否有重复信息
        arham_count = content.count('5340.114.855')
        if arham_count == 1:
            print("✅ 预订信息无重复")
        else:
            print(f"❌ 预订信息重复 {arham_count} 次")
        
        print(f"\n=== 文件信息 ===")
        print(f"文件大小: {len(content):,} 字符")
        print(f"总行数: {content.count(chr(10)) + 1:,} 行")
        
        # 简单的语法检查
        syntax_issues = []
        
        # 检查是否有未闭合的字符串
        if content.count('"') % 2 != 0:
            syntax_issues.append("未闭合的双引号")
            
        if content.count("'") % 2 != 0:
            syntax_issues.append("未闭合的单引号")
            
        if syntax_issues:
            print(f"\n❌ 语法问题: {', '.join(syntax_issues)}")
        else:
            print(f"\n✅ 基本语法检查通过")
            
        return len(syntax_issues) == 0
        
    except Exception as e:
        print(f"❌ 验证过程中出错: {e}")
        return False

if __name__ == "__main__":
    validate_html()