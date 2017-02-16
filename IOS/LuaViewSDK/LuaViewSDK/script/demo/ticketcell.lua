--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2017/2/13
-- Time: 15:59
-- To change this template use File | Settings | File Templates.
--
require("constant");
w,h = LuaSystem.screenSize();
local timeLable;
local startCityNameLabel;
local endCityNameLable;
local priceLable;
local typeLable;
local buyButton;

function click(btn)
    local text = LuaBundle.getLuaScript("demo/ticketcell");
    this:pushLuaView("source",{text=text});
end
function loadView(contentView)
    timeLable = LuaLabel.create();
    timeLable:setFrame({10,0,-1,-1});
    timeLable:setBackgroundColor("#cecece");
    timeLable:setTextColor("#ff0000");
    this:addSubView(timeLable);

    typeLable = LuaLabel.create();
    typeLable:setFrame({10,0,-1,-1});
    typeLable:setLayout_gravity(LuaView.Layout.PARENT_RIGHT);
    typeLable:setBackgroundColor("#cecece");
    typeLable:setTextColor("#ff0000");
    this:addSubView(typeLable);

    startCityNameLabel = LuaLabel.create();
    startCityNameLabel:setFrame({10,0,-1,-1});
    startCityNameLabel:setTopView(timeLable);
    startCityNameLabel:setBackgroundColor("#cecece");
    startCityNameLabel:setTextColor("#ff0000");
    this:addSubView(startCityNameLabel);

    endCityNameLable = LuaLabel.create();
    endCityNameLable:setFrame({10,0,-1,-1});
    endCityNameLable:setTopView(startCityNameLabel);
    endCityNameLable:setBackgroundColor("#cecece");
    endCityNameLable:setTextColor("#ff0000");
    this:addSubView(endCityNameLable);

    buyButton = LuaButton.create();
    buyButton:setText("显示源码");
    buyButton:setFrame({10,0,100,-1});
    buyButton:setLayout_gravity(LuaView.Layout.PARENT_RIGHT);
    buyButton:setTopView(typeLable);
    buyButton:setTextColor("#ff0000");
    buyButton:setFocusable(false);
    buyButton:click(click);
    this:addSubView(buyButton);

    priceLable = LuaLabel.create();
    priceLable:setFrame({10,-10,-1,-1});
    priceLable:setRightView(buyButton);
    --priceLable:setLayout_gravity(LuaView.Layout.PARENT_CENTER);
    priceLable:setTopView(startCityNameLabel);
    priceLable:setBackgroundColor("#cecece");
    priceLable:setTextColor("#ff0000");
    this:addSubView(priceLable);
end

function loadData(obj)
    timeLable:setText(obj["time"]);
    typeLable:setText(obj["type"]);
    startCityNameLabel:setText(obj["startCityName"]);
    endCityNameLable:setText(obj["endCityName"]);
    priceLable:setText(obj["price"]);
end

function cellHeight(obj)
    return 100;
end
