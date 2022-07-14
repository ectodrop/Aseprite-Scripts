-- This example shows how to move the selected cels by a specific delta X/Y value.

local spr = app.activeSprite
if not spr then return app.alert "No active sprite" end

local dlg = Dialog()

function previewText(d)
  local boxes = ""
  for i = 1, 25 do
    if i > d.offset and (i-d.offset) % d.step == 1 then
      boxes = boxes .. "■"
    else
      boxes = boxes .. "□" 
    end
  end
  return boxes
end

dlg
 :label{ id="help", label="", text="Set step size for deleting selected frames" }
 :label{ id="frame_count", label="frames selected:", text=tostring(#app.range.frames) }
 :separator{ }
 :slider{ 
  id="step",
  label="Step size:",
  value="2", 
  min="2", 
  max="20", 
  onchange=function() 
    dlg:modify { id="preview", text=previewText(dlg.data)} 
  end, focus=true }
 :slider{ id="offset", label="Start offset:", value="0", min="0", max="10", onchange=function() dlg:modify { id="preview", text=previewText(dlg.data)} end }
 :check{ id="update_duration", label="Update duration:", text="", selected=false }
 :label{ id="preview", label="Delete Preview:", text=previewText(dlg.data) }
 :button{ id="ok", text="&OK", focus=true }
 :button{ text="&Cancel" }
 :show()

local data = dlg.data
if not data.ok then return end


app.transaction(
  function()
    local frames = app.range.frames
    local step = data.step
    local offset = data.offset

    -- delete from right to left
    -- since left to right shifts everything over to the right after each delete
    for i = #frames, 1, -1 do
      if i > offset and (i-offset) % step == 1 then
        spr:deleteFrame(frames[i]);
      elseif data.update_duration then
        frames[i].duration = frames[i].duration * step
      end
    end
  end
)

