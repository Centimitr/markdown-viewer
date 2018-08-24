window.load = function(content){
    const body = document.querySelector('body')
    const tools = `
    <div id="widgets">
    <div class="widget widget-close" onclick="exitView()"></div>
    </div>
    `
    body.innerHTML = marked(content)
}
window.exitView = function(){
    
}
window.setTheme = function(name){
    const link = document.querySelector('link[rel="stylesheet"]')
    link.href = `theme_${name}.css`
}
window.onPageLoad = function(){
    if (window._cm_cache) {
        window.load(window._cm_cache)
        window._cm_cache = null
    }
}
