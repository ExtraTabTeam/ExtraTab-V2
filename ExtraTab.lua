-----------------------------------------------------------------
------------------<b> ExtraTab Pro Cli </b>----------------------
-----------------------------------------------------------------
------------------<i> By @EDWARD_JASON </i>----------------------
-----------------------------------------------------------------
------- Defult Usage --------
json = dofile('./libraries/JSON.lua')
serpent = dofile("./libraries/serpent.lua")
local lgi = require ('lgi')
local notify = lgi.require('Notify')
notify.init ("Telegram updates")
require('./libraries/lua-redis')
redis =  dofile("./libraries/redis.lua")
BOTID = redis:get('BOT-ID') or 0
http = require "socket.http"
https = require "ssl.https"
require("FrameWork")
Execute_Sudo = {85386955,411253032}
-------- Source Body --------
function is_sudo(msg)
  local var = false
  for v,user in pairs(Execute_Sudo) do
    if user == msg.sender_user_id then
      var = true
    end
  end
  return var
end
function dl_cb(arg, data)
end
 function showedit(msg,data)
  if msg then
   if msg.chat_id then
      local id = tostring(msg.chat_id)
      if id:match('-100(%d+)') then
	    print("[ Super Group ]")
        chat_type = 'super'
        elseif id:match('^(%d+)') then
		print("[ Private ]")
        chat_type = 'user'
        else
		print("[ Group ]")
        chat_type = 'group'
  end
  end
  --------- Text Message --------
   local ExtraTab = msg.content.text
  function check_markdown(text) 
		str = text
		if str:match('_') then
			output = str:gsub('_',[[\_]])
		elseif str:match('*') then
			output = str:gsub('*','\\*')
		elseif str:match('`') then
			output = str:gsub('`','\\`')
		else
			output = str
		end
	return output
   end
   ------- Message Content --------
    if msg.content._== "messageText" then
       print("[TextMessage]")
		Message_Type = 'text'
    end
	if msg.content.text then
       print("["..msg.content.text.."]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
	   Message_Type = 'messageText'
    end
    if msg.content.caption then
       print("["..msg.content.caption.."]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
	   Message_Type = 'messageCaption'
    end
    if msg.content._ == "messageChatAddMembers" then
       print("[TG Serviece][Add Member]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'AddUserTG'
    end
    if msg.content._ == "messageChatJoinByLink" then
	   print("[TG Serviece][Join Member]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'JoinedByLinkTG'
    end
    if msg.content._ == "messageDocument" then
       print("[Document]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'Document'
    end
    if msg.content._ == "messageSticker" then
       print("[Sticker]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'Sticker'
    end
    if msg.content._ == "messageAudio" then
        print("[Audio]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'Audio'
    end
    if msg.content._ == "messageVoice" then
        print("[Voice]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'Voice'
    end
    if msg.content._ == "messageVideo" then
        print("[Video]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'Video'
    end
    if msg.content._ == "messageAnimation" then
        print("[Animation]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'Gif'
    end
    if msg.content._ == "messageLocation" then
        print("[Location]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'Location'
    end
    if msg.content._ == "messageForwardedFromUser" then
        print("[ForwardedMessage]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'messageForwardedFromUser'
    end
    if msg.content._ == "messageContact" then
        print("[Contact]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'Contact'
    end
    if not msg.reply_markup and msg.via_bot_user_id ~= 0 then
        print("[MarkDown or A Bot Message]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'Markreed'
    end
    if msg.content.game then
        print("[Game]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'Game'
    end
    if msg.content._ == "messagePhoto" then
	    print("[Photo]["..msg.sender_user_id.."]["..msg.chat_id.."][Made By @ExtraTab & @MaQzAfzar]")
        Message_Type = 'Photo'
    end
    ViewMessages(msg.chat_id, {[0] = msg.id})
	ReadMark(msg.chat_id, msg.id)
    redis:incr('TotalMessages:'..BOTID)
    if msg.send_state._ == "messageIsSuccessfullySent" then
        return false 
    end
------ Bot Auto Set Id -------
    if ExtraTab then
      local function cb(a,b,c)
          redis:set('BOTID',b.id)
      end
      GetMe(cb)
    end
------- Show Stats Of The Msg Sender -------
   if ExtraTab then
    if is_sudo(msg) then
      print("[ Sudoer Msg ]")
    else
      print("[ Member Msg ]")
    end
   end
------ Auto Open Chat ------
         if not redis:get("AutoOpenChat:"..BOTID) or redis:ttl("AutoOpenChat:"..BOTID) == -2 then
          local open = redis:smembers("SuperGroup:"..BOTID)
          for k,v in pairs(open) do
          OpenChat(v)
   		  redis:setex("AutoOpenChat:"..BOTID, 3, true)
         end  
         end
------ Add Super Group To list ------
 if msg.chat_id then
          local ID = tostring(msg.chat_id)
          if ID:match('-100(%d+)') then
          if not redis:sismember("SuperGroup:"..BOTID,msg.chat_id) then
          redis:sadd("SuperGroup:"..BOTID,msg.chat_id)
		  print("[ New SGP Add To List ]")
        end
------ Add Group To list ------
elseif ID:match('^-(%d+)') then
if not redis:sismember("Group:"..BOTID,msg.chat_id) then
        redis:sadd("Group:"..BOTID,msg.chat_id)
        print("[ New GP Add To List ]")
end
------ Add User To list ------
elseif ID:match('') then
 if not redis:sismember("User:"..BOTID,msg.chat_id) then
        redis:sadd("User:"..BOTID,msg.chat_id)
        print("[ New USER Add To List ]")
 end
   else
------ Add Channels To SuperGroup list -------------
      if not redis:sismember("SuperGroup:"..BOTID,msg.chat_id) then
        redis:sadd("SuperGroup:"..BOTID,msg.chat_id)
		print("[ New SGP Add To List ]")
end
end
end
------------- Stats Locals ------------------
local JoinStats = (redis:get('JoinLink:'..BOTID) or 'no')
if JoinStats == 'no' then
  JOINING = 'запрещать'
 else
  JOINING = 'включить'
end
local SGP = (redis:scard('SuperGroup:'..BOTID) or 0)
local GP = (redis:scard('Group:'..BOTID) or 0)
local U = (redis:scard('User:'..BOTID) or 0)
local Link = (redis:scard('Links:'..BOTID) or 0)
-----------------------------
if ExtraTab and ExtraTab:match('^П (.*)') and is_sudo(msg) then
local random = ExtraTab:match('П (.*)')
SendMessage(msg.chat_id,random,'md')
end
----------- Stats -----------
if ExtraTab == 'Статистика' and is_sudo(msg) then
             SendMessage(msg.chat_id,'• статистика •\n• '..SGP..' Супер •\n• '..GP..' группа •\n• '..U..' пользователь •\n• '..Link..' цель •\n• '..JOINING..' Статус присоединения •\n• Питаться от [at]ExtraTab •\n• Разработано [at]MaQzAfzar •','md')
end
---------- Forward ----------
if ExtraTab and ExtraTab:match('^Переслать (%d+)') and is_sudo(msg) then
local random_sgp = ExtraTab:match('Переслать (%d+)')
local FwdLimit = redis:ttl("FwdLimit:"..BOTID) or -2
         if FwdLimit == -2 then
         if tonumber(msg.reply_to_message_id) > 0 then
          if tonumber(random_sgp) <= tonumber(SGP) then
          function cb(a,b)
          local SGP = redis:srandmember('SuperGroup:'..BOTID,random_sgp)
          for k,Extra in pairs(SGP) do
             ForwardMessage(Extra, msg.chat_id,{[0] = b.id},1)
          end
          local ExtraTab = '• Ваше сообщение Переслано '..random_sgp..' группа •'
             SendMessage(msg.chat_id, ExtraTab, 'md')
			 redis:setex("FwdLimit:"..BOTID,3600,true)
          end
		     GetMessage(msg.chat_id, tonumber(msg.reply_to_message_id),cb)
			 else
		     SendMessage(msg.chat_id, '• Ваш бот не имеет '..random_sgp..' группа Выберите несколько номеров •', 'md')
	     end
         else
             SendMessage(msg.chat_id, '• Отправьте свое сообщение в ответ •', 'md')
		 end
		 else
		     SendMessage(msg.chat_id, '• Время ограничения включено. Попробуйте позже •', 'md')
		 end
end
---------- Add ----------
if ExtraTab and ExtraTab:match('^(Добавить к) (%d+) (%d+)') and is_sudo(msg) then
local match = {
        ExtraTab:match("^(Добавить к) (%d+) (%d+)")
      }
local AddLimit = redis:ttl("AddLimit:"..BOTID) or -2
         if AddLimit == -2 then
          if tonumber(match[2]) <= tonumber(SGP) then
          function cb(a,b)
          local SGP = redis:srandmember('SuperGroup:'..BOTID,match[2])
          for k,Extra in pairs(SGP) do
             AddUser(Extra,tonumber(match[3]))
          end
          local ExtraTab = '• Пользователь '..match[3]..' добавлен в '..match[2]..' группу •'
             SendMessage(msg.chat_id, ExtraTab, 'md')
			 redis:setex("AddLimit:"..BOTID,3600,true)
          end
		     GetMessage(msg.chat_id, tonumber(msg.reply_to_message_id),cb)
			 else
		     SendMessage(msg.chat_id, '• Ваш бот не имеет '..random_sgp..' группа Выберите несколько номеров •', 'md')
	     end
		 else
		     SendMessage(msg.chat_id, '• Время ограничения включено. Попробуйте позже •', 'md')
		 end
end
----------- Reset -----------
if ExtraTab == 'Сброс' and is_sudo(msg) then
        redis:del("SuperGroup:"..BOTID)
        redis:del("Group:"..BOTID)
        redis:del("User:"..BOTID)
        SendMessage(msg.chat_id,'• Extra Tabchi Stata Сброс ! •','md')
        print("[ Extra Tabchi : Stats Reseted ]")
end
----------- Join Stats -----------
if ExtraTab == 'включение соединения' and is_sudo(msg) then
        if JoinStats == 'no' then
        redis:set('JoinLink:'..BOTID,'yes')
		   SendMessage(msg.chat_id,'• соединение включено •','md')
        print("[ Extra Tabchi : Join : Enabled ]")
		else
		   SendMessage(msg.chat_id,'• соединение было включено •','md')
		print("[ Extra Tabchi : Join : Was Enabled ]")
		end
end
if ExtraTab == 'отключить соединение' and is_sudo(msg)then
        if JoinStats == 'yes' then
        redis:set('JoinLink:'..BOTID,'no')
		   SendMessage(msg.chat_id,'• соединение отключено •','md')
        print("[ Extra Tabchi : Join : Disabled ]")
		else
		   SendMessage(msg.chat_id,'• Регистрация отключена •','md')
        print("[ Extra Tabchi : Join : Was Disabled ]")
		end
end
----------- Reload -----------
if ExtraTab == 'перезагружать' and is_sudo(msg) then
        dofile('./ExtraTab.lua')
		dofile("./FrameWork.lua")
           SendMessage(msg.chat_id,'• перезагружается •','md')
        print("[ Extra Tabchi : Reloaded ! ]")
end
------- Auto Join -------
  local JoinLink = (redis:get('JoinLink:'..BOTID) or 'no')
   if is_sudo(msg) then
	if ExtraTab and ExtraTab:match("https://telegram.me/joinchat/%S+") or ExtraTab and ExtraTab:match("https://t.me/joinchat/%S+") or ExtraTab and ExtraTab:match("https://t.me/joinchat/%S+")  or ExtraTab and ExtraTab:match("https://telegram.dog/joinchat/%S+") then
		local ExtraTab = ExtraTab:gsub("t.me","telegram.me")
		for link in ExtraTab:gmatch("(https://telegram.me/joinchat/%S+)") do
			if not redis:sismember("Links"..BOTID,link) then
			redis:sadd("Links:"..BOTID, link)
				print("[ Extra Tabchi Added The Link To links Automaticly ! ]")
			    end
		    end
     end
   end
 local Limit = redis:ttl('JoinLimit:'..BOTID) or -2
if JoinLink == 'yes' then
if Limit == -2 then
local Link = redis:srandmember("Links:"..BOTID) or 'notfound'
if Link == 'notfound' then
print("{[ Extra Tabchi Need Links ! ]}")
else
ImportChatInviteLink(Link)
redis:srem("Links:"..BOTID,Link)
print("{[ Extra Tabchi Joined To Links Automaticly ! ]}")
redis:setex('JoinLimit:'..BOTID,300,true)
end
end
end
-------------------------
end
end
function tdbot_update_callback(data)
if (data._ == "updateNewMessage") or (data._ == "updateNewChannelMessage") then
showedit(data.message,data)
 local msg = data.message
  print(msg)
 elseif (data._== "updateMessageEdited") then
showedit(data.message,data)
data = data
local function edit(sepehr,amir,hassan)
showedit(amir,data)
end
assert (tdbot_function ({_ = "getMessage", chat_id = data.chat_id,message_id = data.message_id }, edit, nil))
assert (tdbot_function ({_ = "openChat",chat_id = data.chat_id}, dl_cb, nil))
assert (tdbot_function ({ _ = 'openMessageContent',chat_id = data.chat_id,message_id = data.message_id}, dl_cb, nil))
assert (tdbot_function ({_="getChats",offset_order="9223372036854775807",offset_chat_id=0,limit=20}, dl_cb, nil))
end
end
------ Information About Source ------
-- By @MaQzAfzar And @Edward_Jason
-- Developed By ExtraTab Team
-- Believe Us :)
-- Plz Don't Empty This Paragraph
-- لطفا این قسمت را پاک نکنید برای احترام به زحمات برنامه نویس
-- نوشته شده توسط [@MaQzAfzar]
-- تیم توسعه دهنده [ExtraTab & @ExtraTm]
--------------------------------------