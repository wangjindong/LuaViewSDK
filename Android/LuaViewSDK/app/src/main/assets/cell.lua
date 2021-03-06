--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/1/23
-- Time: 16:18
-- To change this template use File | Settings | File Templates.
--
require("constant");

local lb;
local btn;

function success(result)
    LuaConsole.log(result);
end
function fail(result)
    print(result);
end
function click(btn)
    LuaConsole.log(btn);
    --LuaRequest.post("url",{aa=11},success);
    local name = btn:text();
    LuaConsole.log(name);
    name = string.lower(name);
    this:pushLuaView(name);
end
function loadView(contentView)
    lb = LuaLabel.create();
    lb:setText("线性布局");
    lb:setFrame({10,0,-1,-1});
    lb:setBackgroundColor("#cecece");
    lb:setLayout_gravity(LuaView.Layout.PARENT_LEFT_CENTER);
    lb:setTextColor("#ff0000");
    lb:setTag("1");
    this:addSubView(lb);

    btn = LuaButton.create();
    btn:setText("按钮点击");
    btn:setLeftView(lb);
    btn:setFrame({10,0,100,-1});
    btn:setLayout_gravity(LuaView.Layout.PARENT_RIGHT_CENTER);
    btn:setTextColor("#ff0000");
    btn:setTag("2");
    btn:setFocusable(false);
    btn:click(click);
    this:addSubView(btn);
end

function loadData(obj)
        lb:setText(obj);
        btn:setText(obj);
end