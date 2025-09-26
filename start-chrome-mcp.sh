#!/bin/bash

# Chrome MCP 启动脚本 - 意大利瑞士旅行项目
# 作者: AI进化论-花生

echo "🇮🇹🇨🇭 启动 Chrome MCP 测试环境"
echo "=================================="

# 检查 Node.js 是否安装
if ! command -v node &> /dev/null; then
    echo "❌ 错误: 未找到 Node.js，请先安装 Node.js"
    echo "   下载地址: https://nodejs.org/"
    exit 1
fi

# 检查 npm 是否安装
if ! command -v npm &> /dev/null; then
    echo "❌ 错误: 未找到 npm，请先安装 npm"
    exit 1
fi

# 检查 Chrome 是否安装
if ! command -v google-chrome &> /dev/null && ! command -v chrome &> /dev/null && ! command -v chromium &> /dev/null; then
    echo "⚠️  警告: 未找到 Chrome 浏览器，某些功能可能无法使用"
    echo "   请安装 Chrome 浏览器: https://www.google.com/chrome/"
fi

# 获取项目目录
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "📁 项目目录: $PROJECT_DIR"

# 启动本地服务器
echo "🚀 启动本地服务器..."
cd "$PROJECT_DIR"

# 检查端口 8080 是否被占用
if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null ; then
    echo "⚠️  端口 8080 已被占用，尝试使用端口 8081"
    PORT=8081
else
    PORT=8080
fi

# 启动 Python HTTP 服务器
echo "🌐 在端口 $PORT 启动 HTTP 服务器..."
python3 -m http.server $PORT &
SERVER_PID=$!

# 等待服务器启动
sleep 2

# 检查服务器是否启动成功
if curl -s "http://localhost:$PORT" > /dev/null; then
    echo "✅ 服务器启动成功: http://localhost:$PORT"
else
    echo "❌ 服务器启动失败"
    kill $SERVER_PID 2>/dev/null
    exit 1
fi

# 打开浏览器
echo "🌍 打开浏览器..."
if command -v open &> /dev/null; then
    # macOS
    open "http://localhost:$PORT/test-with-chrome-mcp.html"
elif command -v xdg-open &> /dev/null; then
    # Linux
    xdg-open "http://localhost:$PORT/test-with-chrome-mcp.html"
elif command -v start &> /dev/null; then
    # Windows
    start "http://localhost:$PORT/test-with-chrome-mcp.html"
else
    echo "请手动打开浏览器访问: http://localhost:$PORT/test-with-chrome-mcp.html"
fi

echo ""
echo "🎯 Chrome MCP 测试命令示例:"
echo "================================"
echo ""
echo "1. 基础功能测试:"
echo "   Verify in the browser that the page loads correctly on localhost:$PORT"
echo ""
echo "2. 地图功能测试:"
echo "   Test the Leaflet map functionality on localhost:$PORT/test-with-chrome-mcp.html"
echo ""
echo "3. 性能测试:"
echo "   Check the LCP of localhost:$PORT and identify performance issues"
echo ""
echo "4. 移动端测试:"
echo "   Test the responsive design on mobile viewport for localhost:$PORT"
echo ""
echo "5. 网络测试:"
echo "   Check network requests and identify any failed resources on localhost:$PORT"
echo ""
echo "6. 调试控制台:"
echo "   Check the browser console for any errors on localhost:$PORT"
echo ""
echo "📋 可用的测试页面:"
echo "   - 主页面: http://localhost:$PORT/index.html"
echo "   - 测试页面: http://localhost:$PORT/test-with-chrome-mcp.html"
echo ""
echo "🛑 停止服务器: 按 Ctrl+C"
echo ""

# 等待用户中断
trap 'echo ""; echo "🛑 正在停止服务器..."; kill $SERVER_PID 2>/dev/null; echo "✅ 服务器已停止"; exit 0' INT

# 保持脚本运行
wait $SERVER_PID

