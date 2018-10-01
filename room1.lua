--room1.lua
require "fmt"
require "dbg"

local room1 = {};
function room1.nameFunction()
   dprint "room1.nameFunction"
end

obj {
   nam = 'люк';
   dsc = [[Тут есть {люк в полу}]];
   act = function(s)
     enable '#люк'
     p [[Вы видите, что в люк можно залезть]];
   end;
};

room {
   nam = 'room1';
   disp = 'спальня';
   dsc = 'Вы в небольшой спальне';
   way = { path {'в Главную комнату', 'main'} };
   --onexit = 'Вы выходите из спальни.';
   onenter = function(s, f)
      if s == f then
	 return p '';
      end
      p ('Вы переходите из ', f, ' в ', s);
   end;
   obj = { 'люк' };
   way = { path { '#люк', 'в люк', 'влазе' }:disable(), path { 'в Главную комнату', 'main' } };
};

room {
   nam = 'влазе';
   disp = 'в лазе';
   onenter = function(s, f)
      if s == f then return p '';
      end;
      p ('Вы залезаете в лаз через люк.')
   end;
   dsc = [[Я в узком лазе]];
   way = { path {'в спальню', 'room1'} };
};

return room1

