---@param r number
---@param g number
---@param b number
---@param a? number
---@param mul? number (255)
---@return string
---@return number? alpha
return function(r, g, b, a, mul)
  mul = mul or 255
  return string.format("#%x", r * mul * 0x10000 + g * mul * 0x100 + b * mul), a
end
