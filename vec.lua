--localized
local rand = math.random
local sin  = math.sin
local cos  = math.cos

--constants
local pi = math.pi

local vec = {}

function vec.fill(v, n)
	local f = {}
	for i = 1, n do
		f[i] = v
	end
	return f
end

function vec.len(v)
	local l = 0
	local n = #v
	for i = 1, n do
		local n = v[i]
		l = l + n*n
	end
	return l^(1/2)
end

function vec.unitize(v)
	local l = 0
	local n = #v
	for i = 1, n do
		local n = v[i]
		l = l + n*n
	end
	local l = l^(1/2)
	local f = {}
	for i = 1, n do
		f[i] = v[i]/l
	end
	return f
end

function vec.safeunitize(v)
	local l = 0
	local n = #v
	for i = 1, n do
		local n = v[i]
		l = l + n*n
	end
	if l > 0 then
		local l = l^(1/2)
		local f = {}
		for i = 1, n do
			f[i] = v[i]/l
		end
		return f
	else
		local f = {}
		for i = 1, n do
			f[i] = 0
		end
		return f
	end
end

function vec.neg(v)
	local f = {}
	local n = #v
	for i = 1, n do
		f[i] = -v[i]
	end
	return f
end

function vec.rand3()
	local r = rand()^(1/2)
	local t = 2*pi*rand()
	local x = r*cos(t)
	local y = r*sin(t)
	local z = (1 - x*x - y*y)^(1/2)
	return {2*x*z, 2*y*z, 2*(x*x + y*y) - 1}
end

function vec.dot(a, b)
	local f = 0
	local n = #a
	for i = 1, n do
		f = f + a[i]*b[i]
	end
	return f
end

function vec.cross(a, b)
	local ax, ay, az = a[1], a[2], a[3]
	local bx, by, bz = b[1], b[2], b[3]
	return {
		ay*bz - az*by;
		az*bx - ax*bz;
		ax*by - ay*bx;
	}
end

function vec.dist(a, b)
	local f = 0
	local n = #a
	for i = 1, n do
		local d = b[i] - a[i]
		f = f + d*d
	end
	return f^(1/2)
end

function vec.vecsub(a, b)
	local f = {}
	local n = #a
	for i = 1, n do
		f[i] = a[i] - b[i]
	end
	return f
end

function vec.vecadd(a, b)
	local f = {}
	local n = #a
	for i = 1, n do
		f[i] = a[i] + b[i]
	end
	return f
end

function vec.vecdiv(a, b)
	local f = {}
	local n = #a
	for i = 1, n do
		f[i] = a[i]/b[i]
	end
	return f
end

function vec.vecmul(a, b)
	local f = {}
	local n = #a
	for i = 1, n do
		f[i] = a[i]*b[i]
	end
	return f
end

function vec.numsub(a, b)
	local f = {}
	local n = #a
	for i = 1, n do
		f[i] = a[i] - b
	end
	return f
end

function vec.numadd(a, b)
	local f = {}
	local n = #a
	for i = 1, n do
		f[i] = a[i] + b
	end
	return f
end

function vec.numdiv(a, b)
	local f = {}
	local n = #a
	for i = 1, n do
		f[i] = a[i]/b
	end
	return f
end

function vec.nummul(a, b)
	local f = {}
	local n = #a
	for i = 1, n do
		f[i] = a[i]*b
	end
	return f
end

function vec.lerp(a, b, p)
	local f = {}
	local n = #a
	for r = 1, n do
		f[r] = (1 - p)*a[r] + p*b[r]
	end
	return f
end

return vec
