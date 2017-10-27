-- In The Name Of Allah --

-- Started FrameWork.Lua By Reza Khosrobegi --
-- Pleaze Don't Clean This Messages In The Source ! --

-- Send Message Method --
function SendMessage(chat_id, text, parse)
    assert( tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = 0,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
    		_ = "inputMessageText",
    		text = text,
    		disable_web_page_preview = 1,
    		clear_draft = 0,
    		parse_mode = GetParse(parse),
    		entities = {}
    	}
    }, dl_cb, nil))

end
-- Send Message In Reply To Others' Message Method --
function SendMessageInReply(chat_id, text, msg_id, parse)
    tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = msg_id,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
    		_ = "inputMessageText",
    		text = text,
    		disable_web_page_preview = 1,
    		clear_draft = 0,
    		parse_mode = GetParse(parse),
    		entities = {}
    	}
    }, dl_cb, nil)
end
-- Set Profile Photo Method --
function SetProfilePhoto(photo_path)
  assert (tdbot_function ({
    _ = 'setProfilePhoto',
    photo = photo_path
  },  dl_cb, nil))
end
-- Create New Group Method --
function CreateNewGroupChat(user_ids, title)
  	tdbot_function ({
    _ = "createNewGroupChat",
	    user_ids = user_ids,
	    title = title
  	}, dl_cb, nil)
end
-- Convert To Super Channel Method --
function MigrateGroupChatToChannelChat(chat_id)
  	tdbot_function ({
	    ID = "migrateGroupChatToChannelChat",
	    chat_id = chat_id
  	}, dl_cb, nil)
end
-- For Do Sth On Users In Groups Method --
function ChangeChatMemberStatus(chat_id, user_id, status)
  	tdbot_function ({
	    _ = "changeChatMemberStatus",
	    chat_id = chat_id,
	    user_id = user_id,
	    status = {
	      _ = "chatMemberStatus" .. status
	    },
  	}, dl_cb, nil)
end
-- Deklete Message Method --
function DeleteMessage(chat_id, msg_id)
	msg_id = {[0] = msg_id}
    tdbot_function ({
    	_ = "deleteMessages",
    	chat_id = chat_id,
    	message_ids = msg_id
    }, dl_cb, nil)
end
-- Get Parse Mode Method --
function GetParse(parse)
	if parse  == 'md' then
		return {_ = "textParseModeMarkdown"}
	elseif parse == 'html' then
		return {_ = "textParseModeHTML"}
	else
		return nil
	end
end
-- Send Request Method -- IT IS VERY USEFUL --
function SendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback)
  	tdbot_function ({
	    _ = request_id,
	    chat_id = chat_id,
	    reply_to_message_id = reply_to_message_id,
	    disable_notification = disable_notification,
	    from_background = from_background,
	    reply_markup = reply_markup,
	    input_message_content = input_message_content,
	}, callback or dl_cb, nil)
end
-- For Viewing Messages Method --
function ViewMessages(chat_id, message_ids)
  	tdbot_function ({
    	_ = "viewMessages",
    	chat_id = chat_id,
    	message_ids = message_ids
  }, dl_cb, nil)
end
--[]
function AddUser(chat_id, user_id)
  	tdbot_function ({
    	_ = "addChatMember",
    	chat_id = chat_id,
    	user_id = user_id,
    	forward_limit = 0
  	}, dl_cb, nil)
end
--[]
function ReadMark(chat_id, message_ids)
  	tdbot_function ({
    	_ = "ViewMessages",
    	chat_id = chat_id,
    	message_ids = message_ids
  	}, dl_cb, nil)
end
--[]
function GetMessage(chat_id, message_id, cb_function)
  	tdbot_function ({
    	_ = "getMessage",
    	chat_id = chat_id,
    	message_id = message_id
  	}, cb_function, nil)
end
--[]
function GetChats(offset_order, offset_chat_id, limit)
  	if not limit or limit > 20 then
    	limit = 20
  	end
	tdbot_function ({
	    _ = "getChats",
	    offset_order = offset_order or 9223372036854775807,
	    offset_chat_id = offset_chat_id or 0,
	    limit = limit
  	}, dl_cb, nil)
end
--[]
function GetMe(cb)
  	tdbot_function ({
    	_ = "getMe",
  	}, cb or dl_cb, nil)
end
--[]
function GetMeCb(extra, result)
	our_id = result.id
	print("Our id: "..our_id)
	file = io.open("./data/config.lua", "r") --- You Can Use This Parameter
	config = ''
	repeat
		line = file:read ("*l")
		if line then
			line = string.gsub(line, "0", our_id)
			config = config.."\n"..line
		end
	until not line
		
	file:close()
	file = io.open("./data/config.lua", "w") --- Put Your Congfig Location
	file:write(config)
	file:close()	
end
--[]
function ChangeChatPhoto(chat_id,photo)
   tdbot_function ({
    _ = 'changeChatPhoto',
    chat_id = chat_id,
    photo = getInputFile(photo)
  }, dl_cb, nil)
end
--[]
function ChangeDescription(channel_id,text)
 tdbot_function ({
_ = 'changeChannelDescription',
channel_id = getChatId(channel_id).id,
description = text
}, dl_cb, nil)
end
--[]
function ChangeChatTitle(chat_id, title)
 tdbot_function ({
_ = "changeChatTitle",
chat_id = chat_id,
title = title
}, dl_cb, nil)
end
--[]
function ChangeAbout(about, cb)
 	tdbot_function ({
    	_ = "changeAbout",
    	about = about
  	}, cb or dl_cb, nil)
end
--[]
function PinMessage(channel_id, message_id, disable_notification)
  	tdbot_function ({
    	_ = "pinChannelMessage",
    	channel_id = getChatId(channel_id)._,
    	message_id = message_id,
    	disable_notification = disable_notification
  	}, dl_cb, nil)
end
--[]
function UnPinMessage(channel_id)
    tdbot_function ({
    _ = 'unpinChannelMessage',
    channel_id = getChatId(channelid).id
   }, dl_cb, nil)
end
--[]
function OpenChat(chat_id)
	tdbot_function ({
    	_ = "openChat",
    	chat_id = chat_id
	}, dl_cb, nil)
end
--[]
function KickUser(chat_id, user_id)
  	tdbot_function ({
    	_ = "changeChatMemberStatus",
    	chat_id = chat_id,
    	user_id = user_id,
    	status = {
      		_ = "chatMemberStatusBanned"
    	},
  	}, dl_cb, nil)
end
--[]
function PromoteToAdmin(chat_id, user_id)
  	tdbot_function ({
    	_ = "changeChatMemberStatus",
    	chat_id = chat_id,
    	user_id = user_id,
    	status = {
      		_ = "chatMemberStatusAdministrator"
    	},
  	}, dl_cb, nil)
end
--[]
function Leave(chat_id, user_id)
    tdbot_function ({
		_ = "changeChatMemberStatus",
		chat_id = chat_id,
		user_id = user_id,
		status = {
			_ = "chatMemberStatusLeft"
      	},
    }, dl_cb, nil)
end
--[]
function AddChatMember(chat_id, user_id)
	tdbot_function ({
		_ = "addChatMember",
		chat_id = chat_id,
		user_id = user_id,
		forward_limit = 50
	}, dl_cb, nil)
end
-- Restrict Method --
function Restrict(chat_id, user_id, Restricted, right) -- This Method Idea Is From CerNer Company ...
  local chat_member_status = {}
 if Restricted == 'Restricted' then
    chat_member_status = {
     is_member = right[1] or 1,
      restricted_until_date = right[2] or 0,
      can_send_messages = right[3] or 1,
      can_send_media_messages = right[4] or 1,
      can_send_other_messages = right[5] or 1,
      can_add_web_page_previews = right[6] or 1
         }

  chat_member_status._ = 'chatMemberStatus' .. Restricted

  assert (tdbot_function ({
    _ = 'changeChatMemberStatus',
    chat_id = chat_id,
    user_id = user_id,
    status = chat_member_status
   }, dl_cb, nil))
end
end
-- Search UserName In Public Chats Method -- 
function ResolveUsername(username, cb_function, cb_extra)
    tdbot_function ({
        _ = "searchPublicChat",
        username = username
    }, cb_function, cb_extra)
end
-- Search ID In Public Chats Method -- 
function ResolveID(user_id, cb_function, cb_extra)
    tdbot_function ({
        _ = "getUserFull",
        user_id = user_id
    }, cb_function, cb_extra)
end
-- Get Chats [Banned , Deleted Or ETC] --
function GetChat(chat_id, cb)
	tdbot_function ({
    	_ = "getChat",
    	chat_id = chat_id
	}, cb or dl_cb, nil)
end
-- Get Channel Members Method --
function GetChannelMembers(channel_id, offset, filter, limit, cb_function)
	if not limit or limit > 200 then
		limit = 200
	end

	tdbot_function ({
    	_ = "getChannelMembers",
    	channel_id = getChatId(channel_id)._,
    	filter = {
      		_ = "channelMembersFilter" .. filter
    	},
    	offset = offset,
    	limit = limit
  	}, cb_function, nil)
end
-- Forward Message Method --
function ForwardMessage(chat_id, from_chat_id, message_id, from_background)
    tdbot_function ({
        _ = "forwardMessages",
		message_id = message_id,
        chat_id = chat_id,
        from_chat_id = from_chat_id,
        message_ids = message_id,
        disable_notification = 0,
        from_background = from_background
    }, dl_cb, nil)
end
--[]
function GetInputFile(file)
    if file:match('/') then
        infile = {_ = "InputFileLocal", path = file}
    elseif file:match('^%d+$') then
        infile = {_ = "InputFileId", id = file}
    else
        infile = {_ = "InputFilePersistentId", persistent_id = file}
    end
    return infile
end
--[]
function DownloadFile(file_id)
    tdbot_function ({
    _ = 'downloadFile',
    file_id = file_id,
  },  dl_cb, nil)
end
--[]
function SendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)
	local input_message_content = {
    	_ = "inputMessageSticker",
    	sticker = GetInputFile(sticker),
    	width = 0,
    	height = 0
  	}
  	SendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
--[]
function SendDocument(chat_id, document)
    tdbot_function ({
    	_ = "sendMessage",
    	chat_id = chat_id,
    	reply_to_message_id = 0,
    	disable_notification = 0,
    	from_background = 1,
    	reply_markup = nil,
    	input_message_content = {
            _ = "inputMessageDocument",
            document = GetInputFile(document),
            caption = nil
        },
    }, dl_cb, nil)
end
--[]
function SendSticker(chat_id, sticker)
	local input_message_content = {
    	_ = "inputMessageSticker",
    	sticker = GetInputFile(sticker),
    	width = 0,
    	height = 0
  	}
  	SendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end
--[]
function SendAnimation(chat_id, gif, caption)
  	local input_message_content = {
    	_ = "inputMessageAnimation",
    	animation = GetInputFile(gif),
    	width = 0,
    	height = 0,
    	caption = caption
  }
  SendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end
--[]
function SendAudio(chat_id, audio, caption)
  local input_message_content = {
    _ = "inputMessageAudio",
    audio = GetInputFile(audio),
    duration = duration or 0,
    title = title or 0,
    performer = performer,
    caption = caption
  }
  SendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end
--[]
function SendDocument(chat_id, document, caption)
	local input_message_content = {
		_ = "inputMessageDocument",
		document = GetInputFile(document),
		caption = caption
	}
	SendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end
--[]
function SendPhoto(chat_id, photo, caption)
  local input_message_content = {
    _ = "inputMessagePhoto",
    photo = GetInputFile(photo),
    added_sticker_file_ids = {},
    width = 0,
    height = 0,
    caption = caption
  }
  SendRequest('SendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end
--[]
function SendVideo(chat_id, video, caption)
	local input_message_content = {
		_ = "inputMessageVideo",
    	video = GetInputFile(video),
    	added_sticker_file_ids = {},
    	duration = duration or 0,
    	width = width or 0,
    	height = height or 0,
    	caption = caption
  	}
  	SendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end
--[]
function SendStartMessage(bot_user_id, chat_id, parameter)
tdbot_function ({_ = 'sendBotStartMessage',bot_user_id = bot_user_id,chat_id = chat_id,parameter = tostring(parameter)},  dl_cb, nil)
end
--[]
function SendGame(chat_id, reply_to_message_id, botuserid, gameshortname, disable_notification, from_background, reply_markup)
  local input_message_content = {
    _ = 'inputMessageGame',
    bot_user_id = botuserid,
    game_short_name = tostring(gameshortname)
  }
  sendMessage(chat_id, reply_to_message_id, input_message_content, disable_notification, from_background, reply_markup)
end
--[]
function SendMention(chat_id, user_id, msg_id, text, offset, length)
    tdbot_function ({
    _ = "sendMessage",
    chat_id = chat_id,
    reply_to_message_id = msg_id,
    disable_notification = 0,
    from_background = true,
    reply_markup = nil,
    input_message_content = {
      _ = "inputMessageText",
      text = text,
      disable_web_page_preview = 1,
      clear_draft = false,
      entities = {[0] = {
      offset = offset,
      length = length,
      _ = "textEntity",
      type = {user_id = user_id, _ = "textEntityTypeMentionName"}}}
    }
  }, dl_cb, nil)
end
--[]
function SendVoice(chat_id, voice, caption)
	local input_message_content = {
    	_ = "inputMessageVoice",
    	voice = GetInputFile(voice),
    	duration = duration or 0,
    	waveform = waveform or 0,
    	caption = caption
  	}
  	SendRequest('sendMessage', chat_id, 0, 0, 1, nil, input_message_content, cbsti)
end
--[]
function SendInline(chatid, replytomessageid, disablenotification, frombackground, queryid, resultid)
    tdbot_function ({
    _ = 'sendInlineQueryResultMessage',
    chat_id = chatid,
    reply_to_message_id = replytomessageid,
    disable_notification = disablenotification,
    from_background = frombackground,
    query_id = queryid,
    result_id = tostring(resultid)
  }, dl_cb,nil)
end
--[]
function cbsti(a,b)
	--vardump(a)
	--vardump(b)
end
--[]
function ExportLink(chat_id)
    tdbot_function ({
        _ = "exportChatInviteLink",
        chat_id = chat_id
    }, dl_cb, nil)
end
--[]
function ImportChatInviteLink(invitelink)
  assert (tdbot_function ({
    _ = "importChatInviteLink",
    invite_link = tostring(invitelink)
  }, dl_cb, nil))
end
--[]
function CheckChatInviteLink(link, cb, cmd)
  	tdbot_function ({
    	_ = "checkChatInviteLink",
    	invite_link = link
  	}, cb or dl_cb, cmd)
end
--[]
function GetChannelFull(channel_id, cb, cmd)
  	tdbot_function ({
    	_ = "GetChannelFull",
    	channel_id = getChatId(channel_id)._
  	}, cb or dl_cb, cmd)
end
--[]
function GetChatHistory(chat_id, from_message_id, offset, limit, cb_function, cb_extra)
    if not limit or limit > 100 then
        limit = 100
    end
    tdbot_function ({
        _ = "getChatHistory",
        chat_id = chat_id,
        from_message_id = from_message_id,
        offset = offset or 0,
        limit = limit
    }, cb_function, cb_extra)
end
--[]
function DeleteUserAllMessages(chat_id, user_id)
    tdbot_function ({
        _ = "deleteMessagesFromUser",
        chat_id = chat_id,
        user_id = user_id
    }, cb or dl_cb, nil)
end

-- Endeded FrameWork.Lua By Reza Khosrobegi --
-- Pleaze Don't Clean This Messages In The Source ! --