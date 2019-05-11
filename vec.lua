local rand = math.random
local sin  = math.sin
local cos  = math.cos

local pi = math.pi

local vec = {}

--general begin

function vec.fill(v, n)
	local f = {}
	for i = 1, n do
		f[i] = v
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

function vec.unit(v)
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

function vec.safeunit(v)
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

--n-dimension random unit
function vec.randunit(n)
	--oof
end

--n-dimension random sphere
function vec.randsphere(n)
	--oof
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

--general end

--quaternion begin

--quaternion to axis angle
function vec.quataxis(q)
	local w, x, y, z = q[1], q[2], q[3], q[4]
	local l = (x*x + y*y + z*z)^(1/2)
	local t = 2*acos(w)
	local s = (1 - w*w)^(1/2)
	return {t*x/l, t*y/l, t*z/l}
end

function vec.quatworld(q, v)
	local w, x, y, z = q[1], q[2], q[3], q[4]
	local i, j, k = v[1], v[2], v[3]
	return {
		i - 2*(i*(y*y + z*z) - j*(x*y - z*w) - k*(x*z + y*w));
		j + 2*(i*(x*y + z*w) - j*(x*x + z*z) + k*(y*z - x*w));
		k + 2*(i*(x*z - y*w) + j*(y*z + x*w) - k*(x*x + y*y));
	}
end

function vec.quatlocal(q, v)
	local w, x, y, z = q[1], q[2], q[3], q[4]
	local i, j, k = v[1], v[2], v[3]
	return {
		i - 2*(i*(y*y + z*z) - j*(x*y + z*w) - k*(x*z - y*w));
		j + 2*(i*(x*y - z*w) - j*(x*x + z*z) + k*(y*z + x*w));
		k + 2*(i*(x*z + y*w) + j*(y*z - x*w) - k*(x*x + y*y));
	}
end

--quaternion end

--matrix begin

function vec.matmul(a, b)
	local f = {}
	local n = #a
	for r = 1, n do
		f[r] = 0
		for c = 1, n do
			f[r] = f[r] + a[r][c]*b[c]
		end
	end
	return f
end

function vec.matcol(m, c)
	local f = {}
	local n = #m
	for r = 1, n do
		f[r] = m[r][c]
	end
	return f
end

--matrix end

--misc begin

function vec.len(v)
	local l = 0
	local n = #v
	for i = 1, n do
		local n = v[i]
		l = l + n*n
	end
	return l^(1/2)
end

function vec.dot(a, b)
	local f = 0
	local n = #a
	for i = 1, n do
		f = f + a[i]*b[i]
	end
	return f
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

--misc end

return vec
