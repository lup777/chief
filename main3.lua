--main3.lua
-- $Name: По мотивам ...$
-- $Version 0.0$
-- $Author: Lup$
-- $Info: ...$

require "fmt"
require "dbg"
local room1 = require "room1"
fmt.para = true -- включить отступы

game.act = 'Не работает.';
game.use = 'Это не поможет';
game.inv = 'Зачем мне это?';

function init() -- добавим мнвентарь, нож и бумагу
   dprint "init()"
   --take 'нож'
   --take 'бумага'
   room1.nameFunction();
end

function start() -- вызывается после init непосредственно перед запуском игры,
   --после прочтения сохранения
   if load then
      dprint "Это загрузка состояния игры."
   else
      dprint "Это старт игры."
   end
end

game.onact = function(s, ...)
   dprint "game.onact"
   local r, v = std.call(here(), 'onact', ...)
   if v == false then
      dprint "game.onact. v == false"
      return r, v
   end
   dprint "game.onact. v == true"
   return
end

room {
   nam = 'main'; -- имя объекта
   title = 'Начало приключения';
   disp = "Главная комната";
   dsc = [[Вы в большой комнате ^^
^^
Комната хорошая, светлая. Не очень большая, но и не маленькая.
]]; -- описание сцены. выводится один раз при входе в сцену
   -- или при явном осмотре сцены
   decor = [[ 
На стенах {#обои|обои}. Большое {#окно|окно}]];
   obj = { 'стол','стул' };
   onact = function(s, w)
      p ([[Не трогай ]], w, '.')
      return true--false
   end;
   way = { path {'в спальню', 'room1'} };
   --onexit = 'Вы выходите из Главной комнаты.';
   onenter = function(s, f)
      if s == f then
	 return p '';
      end
      p ('Вы переходите из ', f, ' в ', s);
   end
}: with {
   obj {
      nam = '#обои';
      act = [[Светлые обои с мелкм узором]];
   };
   obj {
      nam = '#окно';
      act = [[За окном лесная полянка, а за ней смешанный лес]];
   }
}

knife = obj {
   nam = 'нож';
   seen = false;
   disk = 'нож';
   dsc = function(s)
      if not s.seen then
	 p 'На столе {что-то} лежит.';
      else
	 p 'На столе лежит {нож}.';
      end
   end;
   tak = 'я взял нож';
   act = function(s)
      if s.seen then
	 p 'Это нож';
      else
	 s.seen = true;
	 p 'Гм... Это же нож? Етить ту Люсю!';
      end
   end;
}

obj {
   nam = 'яблоко';
   dsc = 'на столе лежит {яблоко}.';
   inv = function(s)
      p 'Я съел яблоко.'
      remove(s); -- удалить из инвенторя
   end;
   tak = 'Вы взяли яблоко.';
};

obj {
   nam = 'стол';
   disp = 'угол стола';
   dsc = 'В комнате стоит {стол}.';
   tak = 'Я взялся за угол стола';
   inv = 'Я держусь за угол стола.';
}:with {
   obj {
      nam = 'ящик';
      dsc = [[В столе находится {ящик}.]];
      act = [[Заперт!]];
   },
   knife,
   obj {
      nam = '#цветы';
      dsc = [[На столе стоят {цветы}.]];
   },
   _'яблоко'
};

obj {
   nam = 'стул';
   disp = function()
      p 'стул';
   end;
   dsc = [[Тут стоит {стул}.]];
   act = [[Стул как стул :)]];
   inv = 'Я держу стул';
   tak = 'Я взял стул';
}

