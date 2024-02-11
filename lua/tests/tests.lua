


mt = {}


iterpath = 'fstate2'

local function logfilter(key, value, iterpath)
-- returns true IF FOUND in whitelist
  for k, v in pairs(fstate2.log.whitelist) do
    if iterpath:find(v) ~= nil then
    return true
    end
  end
return false
end


function mt.__tostring(self) -- has 1 argument only
return vim.inspect(self['proxy'])
end


function mt.__index(self, key)
if tostring(self['proxy']) == tostring(rawget(fstate2, 'proxy')) then 

iterpath = 'fstate2'
end

 iterpath = iterpath .. '.' .. key
  local value = self.proxy[key]
  
  if type(value)=='table' then
 -- f: trigerred wheccessed, for tables
 -- f: trigerred when a key is set, for tables and values
    return setmetatable({proxy=value}, mt)
  else
  -- gets trigerred when a key is accessed, BUT ONLY for  -- DOESNT get triggered when a key is set, for tables and values
return value
  end
end


function mt.__newindex(self, key, value)
iterpath = iterpath .. '.' .. key


local log_mode = rawget(fstate2, 'proxy').log.mode
if log_mode == 'whitelist' then
local log_filter = logfilter(key, value, iterpath) -- dont need self
if log_filter == true then
l(key, '=',  value)
end

elseif log_mode == 'all' then
l(key, '=',  value)
elseif log_mode == 'off' then
end


 iterpath = 'fstate2'
end
function setproxy(t)

  new_t = { proxy = t }
  setmetatable(new_t, mt)
  return new_t
end
fstate2 = {
  window = {
    included = {},
    excluded = {},
    current_winnr = nil
  },
  nvimtree_cwd = nil,
  btmwindow = {
    luapad = {
      winnr = nil,
      bufnr = nil,
      position = nil
    },
    fterminal = {
      winnr = nil,
      bufnr = nil,
      position = nil
    },
    quickfix = {
      winnr = nil,
      bufnr = nil,
      position = nil
    }
  },
  btmwindow_exists = false,
  luapad = {
    filenames = { origfiles = {} },
    editor_eval_on_change = false,
    btmwindow_eval_on_change = true
  },
  telescope = {
    results = { bufnr = false },
    preview = { bufnr = false },
    test = 0,
    uipreset = {
      list = { 'height50' },
      active = 'height50'
    }
  },
  log = { 
  mode = 'all', -- whitelist/off/all -- all will bypass filter
  whitelist = { 'fstate2.luapad' }
}
}
fstate2 = setproxy(fstate2)





---- lATEST ABOVE BEFORE CONVERT TO LOCAL MODULe














-- all table roots to variable
prefix = ""
local table_roots = {}
recursive_print = function(t, prevpath)
    for k, v in pairs(t)do
        if(type(v) == "table")then
                table.insert(table_roots, k)          
            recursive_print(v, k)
        else
          end
    end
  end

for _, v in pairs(fstate2) do
--print('got here')
  recursive_print(v)
end
--dump(table_roots)










mt = {}


iterpath = 'fstate2'

local function logfilter(key, value, iterpath)
 -- lo('it is: ')
  lo(iterpath)
--lo(fstate2.logwl)
  for k, v in pairs(fstate2.logwl) do
lo(v)
print(v)
    if iterpath:find(v) == true then
      lo('matched iterpath') 
    end
  end

end




-- function mt.__call(...)
--     print('table called', ...)
-- end

function mt.__index(self, key)
  lo('index trig')
 -- if iterpath = '' then lo('===== NEW RUN ====')
  iterpath = iterpath .. '.' .. key
 -- lo(iterpath)
--  print('accessing key '..key)
  local value = self.proxy[key]
  
  if type(value)=='table' then
   lo('table')
   lo(value)
   print(vim.inspect(debug.getinfo(2)))
    return setmetatable({proxy=value}, mt)
  else
lo('Value only')
    return value
  end
end


function mt.__newindex(self, key, value)
lo('======== __newindex trig =======')
iterpath = iterpath .. '.' .. key

--lo(self)
--lo(key)
--lo(value)

--logfilter(key, value, iterpath) -- dont need self

 iterpath = 'fstate2'
end
function setproxy(t)

  new_t = { proxy = t }
  setmetatable(new_t, mt)
  return new_t
end
fstate2 = {
  window = {
    included = {},
    excluded = {},
    current_winnr = nil
  },
  nvimtree_cwd = nil,
  btmwindow = {
    luapad = {
      winnr = nil,
      bufnr = nil,
      position = nil
    },
    fterminal = {
      winnr = nil,
      bufnr = nil,
      position = nil
    },
    quickfix = {
      winnr = nil,
      bufnr = nil,
      position = nil
    }
  },
  btmwindow_exists = false,
  luapad = {
    filenames = { origfiles = {} },
    editor_eval_on_change = false,
    btmwindow_eval_on_change = true
  },
  telescope = {
    results = { bufnr = false },
    preview = { bufnr = false },
    test = 0,
    uipreset = {
      list = { 'height50' },
      active = 'height50'
    }
  },
  logwl = { 'fstate2.luapad' }
}
fstate2 = setproxy(fstate2)



---- lATEST















































fstate2 = {
window = { included = {}, excluded = {}, current_winnr = nil}, 
        nvimtree_cwd = nil,
        btmwindow = {
        luapad = {winnr = nil, bufnr = nil, position = nil}, 
        fterminal = {winnr = nil, bufnr = nil, position = nil}, 
        quickfix = {winnr = nil, bufnr = nil, position = nil},
        },
        btmwindow_exists = false,
        luapad = { 
          filenames = {},
          editor_eval_on_change = false,
          btmwindow_eval_on_change = true,
          },
          telescope = {
          results = { bufnr = false },
          preview = { bufnr = false },
          test = 0,
            uipreset = {
            list = { 'height50'},
            active = 'height50'
          }
        },
    logwl = { }
}



local function get_all_pointers()
print(fstate2.telescope.uipreset.active)

end

get_all_pointers()






it = 'asd1.asd2'

any = {
  asd1 = {
      asd2 = { key1 = 'yesitaccess' } 

  }

}

--print(any[it].key1)



function getfield (f)
      local v = any    -- start with the table of globals
      for w in string.gfind(f, "[%w_]+") do
        --v = v[w] print(
      end
      return v
    end


print(getfield('asd1'))









-- old



mt = {}


it = ''

function mt.__index(self, key, value)
  -- for every subtable, set up a new proxy
  -- if values doesnt exist in table, 
  -- print('accessing key '..key)
  it = it .. '.' .. key
  lo('========__index TRIG ========')
  lo(self)
    lo(key)

--lo(prevpath)

  local value = self.fstate2[key] -- if changing this, you need to change setproxy fstate2 = t
  lo(value) -- always log value here otherwise it will be nil
  if type(value) == 'table' then
    -- print('new proxy table created')
    lo('new proxy table created')
      return setmetatable({ [key] = value }, { __index = function(self,key,value) 
      lo('my returned custom function')
     lo(self) 
      lo(key) -- this is same key as above
      lo(value)
      lo(it)
       -- prevkey = key
-- in here it isnt returning the next field
        return
        end })
  else
    return value
  end
end
function mt.__newindex(self, key, value)
lo('======== __newindex trig =======')
  -- print('setting key '..key..' to value '..tostring(value))
  -- lo('newindex trig')
  --   lo(self)
  -- -- print(self)
  -- -- dump(debug.getinfo(self))
  --  lo(key)
  --  lo(value)
  -- dump(debug.getinfo(key))
  -- logfilter(self, key, value)

  -- if logfilter == true then
  -- else
  -- end

 -- self.proxy[key] = value
end
function setproxy(t)

  new_t = { fstate2 = t }
  setmetatable(new_t, mt)
  return new_t
end
fstate2 = {
  window = {
    included = {},
    excluded = {},
    current_winnr = nil
  },
  nvimtree_cwd = nil,
  btmwindow = {
    luapad = {
      winnr = nil,
      bufnr = nil,
      position = nil
    },
    fterminal = {
      winnr = nil,
      bufnr = nil,
      position = nil
    },
    quickfix = {
      winnr = nil,
      bufnr = nil,
      position = nil
    }
  },
  btmwindow_exists = false,
  luapad = {
    filenames = { origfiles = {} },
    editor_eval_on_change = false,
    btmwindow_eval_on_change = true
  },
  telescope = {
    results = { bufnr = false },
    preview = { bufnr = false },
    test = 0,
    uipreset = {
      list = { 'height50' },
      active = 'height50'
    }
  },
  logwl = {}
}
fstate2 = setproxy(fstate2)

-- fstate2.a = 2 -- Works as expected
-- fstate2.c.a = 4 -- Also works as expected

-- local meta =  {  

--   __index = function(self, key)
-- lo('index trig')
-- print('index trig')
-- end,
-- __newindex = function(self, key, value)
-- lo('__newindex trig')
-- print('newindex trig')
-- end
-- }

-- fstate2 = { 

-- }

-- fstate2 = setmetatable({
--   },

-- }, meta)

-- local fstate2 = {}

-- fstate2.meta.

-- fstate2.meta
-- setmetatable(fstate2, fstate2.meta)
-- fstate2.btmwindow_exists = true







-- oldest

-- MY TRY ON STARTUP

--print('fstate ran')
fstate2 = {
  window = {
    included = {},
    excluded = {},
    current_winnr = nil
  },
  nvimtree_cwd = nil,
  btmwindow = {
    luapad = {
      winnr = nil,
      bufnr = nil,
      position = nil
    },
    fterminal = {
      winnr = nil,
      bufnr = nil,
      position = nil
    },
    quickfix = {
      winnr = nil,
      bufnr = nil,
      position = nil
    }
  },
  btmwindow_exists = false,
  luapad = {
    filenames = { origfiles = {} },
    editor_eval_on_change = false,
    btmwindow_eval_on_change = true
  },
  telescope = {
    results = { bufnr = false },
    preview = { bufnr = false },
    test = 0,
    uipreset = {
      list = { 'height50' },
      active = 'height50'
    }
  },
  logwl = { 'fstate2.luapad' }
}


mt = {}
function mt.__index()
  print('index')
lo('__index trig')
end

function mt.__newindex()
  print('__newindex')
lo('__newindex trig')
end



function setup_metatable(t)

  --lo('this trig')
  for k, v in pairs(t) do
    if type(v) == 'table' then
     lo(v)
      setmetatable(v, mt)
        setup_metatable(v)
      end
  end
end

setup_metatable(fstate2)
--print('this ran!!')



--- END MY TRY ON STARTUP


-- local function logfilter(self,key, value)
--   lo('logfilter trig')
-- for _, l in pairs(fstate2) do
-- -- 1st loop enter proxy
-- lo(l)
-- print(find_all_table_roots(l))
-- -- for k, v in pairs(l) do
-- -- lo(k)
-- -- lo(v)
-- -- end
-- end
-- --return table_roots
-- end





-- mt = {}
-- function mt.__index(self, key)
--   -- for every subtable, set up a new proxy
--   -- if values doesnt exist in table, 
--  -- print('accessing key '..key)
 
--   local value = self.proxy[key]
--   if type(value)=='table' then
--     --print('new proxy table created')
--     lo('new proxy table created')
--     lo(self)
--     return setmetatable({proxy=value}, mt)
--   else
--     return value
--   end
-- end
-- function mt.__newindex(self, key, value)

--  -- print('setting key '..key..' to value '..tostring(value))
--   lo('newindex trig')
-- --  lo(self)
--  -- print(self)
--  -- dump(debug.getinfo(self))
--  -- lo(type(key))
--  -- lo((value))
-- --dump(debug.getinfo(key))
-- --logfilter(self, key, value)

-- -- if logfilter == true then
-- -- else
-- -- end


--   self.proxy[key] = value
-- end
-- function setproxy(t, proxy)

--   new_t = {proxy = t}
--   setmetatable(new_t, mt)
--   return new_t
-- end
-- fstate2 = {
-- window = { included = {}, excluded = {}, current_winnr = nil}, 
--         nvimtree_cwd = nil,
--         btmwindow = {
--         luapad = {winnr = nil, bufnr = nil, position = nil}, 
--         fterminal = {winnr = nil, bufnr = nil, position = nil}, 
--         quickfix = {winnr = nil, bufnr = nil, position = nil},
--         },
--         btmwindow_exists = false,
--         luapad = { 
--           filenames = {},
--           editor_eval_on_change = false,
--           btmwindow_eval_on_change = true,
--           },
--           telescope = {
--           results = { bufnr = false },
--           preview = { bufnr = false },
--           test = 0,
--             uipreset = {
--             list = { 'height50'},
--             active = 'height50'
--           }
--         },
--     logwl = { }
-- }
-- fstate2 = setproxy(fstate2)
-- --fstate2.a = 2 -- Works as expected
-- --fstate2.c.a = 4 -- Also works as expected













-- TEST 2
local function fn_to_string_sync(fn)
  log.log('START FN TO STRING')
--lo(os.clock())
local debuginfo = debug.getinfo(fn)
local filepath = debuginfo.source:gsub('^@', '')
local start = debuginfo.linedefined
local ending = debuginfo.lastlinedefined
local fnstring = { 'function() --' }
i=0
for l in io.lines(filepath) do
  if i == 1 then 
    log.log('GOT HERE') 
    string.format('%s --%s', l, '>') 
    log.log(l)
  end



 if i==ending - 1 then 
      string.format('%s --%s', l, '<')
      table.insert(fnstring, l)
    end

  i=i+1
    if i > start and l ~= '' then
      if l:find('^[%s]*%-%-') == nil then
    table.insert(fnstring, l)
elseif l:find('^.*%-%->>>>$') ~= nil or l:find('^.*%-%-<<<<$') ~= nil then 
  table.insert(fnstring, l)
  end
    end



         if i ==ending then 
      break end
 end
--lo(os.clock())
--log.log(table.concat(fnstring, '\n'))
 return table.concat(fnstring, '\n')
end



local t = { "{", "  a = 1,", "  b = 5,", "  f = {", '    key = "some more keys here",', '    key2 = { "another key" }', "  },", "  new = function()", "  local timer = vim.loop.new_timer()", "  timer:start(1, 500, vim.schedule_wrap(function()", "    lo('callback')", "    t.e = 'asd'", "               print('qwertyasdsdsdsd')", "            t.e = math.randomseed(os.time()) ", "  end))", "        lo('orig function :new ran')", "end,", "  newadon = function()", "lo('another new functoin yes it is')", "end", "}" }

local str = '  new = function()'



local folds = {}
for k,v in ipairs(t) do
  print(v)
if v:find('^[%s]*.*= function%(%)[%s]*') then
  table.insert(folds, k)
end
end

foldcount = vim.tbl_count(folds)
print(type(foldcount))

-- if (number % 2 == 0) then
--     .....it is even
-- else
--     .....it is odd
-- end
print(folds)





vim.api.nvim_buf_call(require'livetablelogger/state'.ui.bufnr, function()
vim.api.nvim_command([[exe "norm! gg=G"]])
end)


