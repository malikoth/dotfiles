function shiftWin(win, dir) {
    var srcScreen = win.screen();
    var dstScreenId = (srcScreen.id() - dir + S.screenCount()) % S.screenCount();
    var dstScreen = S.screenForRef(dstScreenId);
    
    var srcRect = srcScreen.visibleRect();
    var dstRect = dstScreen.visibleRect();
    var winRect = win.rect();
    winRect.x -= srcRect.x;
    winRect.y -= srcRect.y;

    var newRect = {};
    newRect.x = winRect.x / srcRect.width * dstRect.width;
    newRect.y = winRect.y / srcRect.height * dstRect.height;
    newRect.width = winRect.width / srcRect.width * dstRect.width;
    newRect.height = winRect.height / srcRect.height * dstRect.height;
    newRect.screen = dstScreenId;
    newRect.x += dstRect.x;
    newRect.y += dstRect.y

    win.doOperation(S.operation("move", newRect)); 
}

S.bind(".:ctrl;cmd;alt", function(win) { shiftWin(win, -1); });
S.bind(",:ctrl;cmd;alt", function(win) { shiftWin(win, 1); });
