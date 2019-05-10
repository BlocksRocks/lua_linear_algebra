--localized
local sin = math.sin
local cos = math.cos

local mat = {}

--matrix self operations
function mat.ident(n)
	local f = {}
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = r == c and 1 or 0
		end
	end
	return f
end

function mat.fill(n, v)
	local f = {}
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = v
		end
	end
	return f
end

function mat.adj(a)
	--oof
end

function mat.det(a)
	--oof
end

function mat.inv(a)
	--oof
end

function mat.trans(m)
	local f = {}
	local n = #m
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = m[c][r]
		end
	end
	return f
end

function mat.column(m, c)
	local f = {}
	local n = #m
	for r = 1, n do
		f[r] = m[r][c]
	end
	return f
end

--matrix:matrix operations
function mat.matsub(a, b)
	local f = {}
	local n = #a
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = a[r][c] - b[r][c]
		end
	end
	return f
end

function mat.matadd(a, b)
	local f = {}
	local n = #a
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = a[r][c] + b[r][c]
		end
	end
	return f
end

function mat.matdiv(a, b)--lol
	local f = {}
	local n = #a
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = a[r][c]/b[r][c]
		end
	end
	return f
end

--here we go
function mat.matmul(a, b)
	local f = {}
	local n = #a
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = 0
			for i = 1, n do
				f[r][c] = f[r][c] + a[r][i]*b[i][c]
			end
		end
	end
	return f
end

function mat.mattransmul(a, b)
	local f = {}
	local n = #a
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = 0
			for i = 1, n do
				f[r][c] = f[r][c] + a[i][r]*b[i][c]
			end
		end
	end
	return f
end

--matrix:vector operations
function mat.vecmul(a, b)
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

--basic operation begin

function mat.numsub(a, b)
	local f = {}
	local n = #a
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = a[r][c] - b
		end
	end
	return f
end

function mat.numadd(a, b)
	local f = {}
	local n = #a
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = a[r][c] + b
		end
	end
	return f
end

function mat.numdiv(a, b)
	local f = {}
	local n = #a
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = a[r][c]/b
		end
	end
	return f
end

function mat.nummul(a, b)
	local f = {}
	local n = #a
	for r = 1, n do
		f[r] = {}
		for c = 1, n do
			f[r][c] = a[r][c]*b
		end
	end
	return f
end

--basic operation end



function mat.fromdir(d)
	local zx = d[1]
	local zy = d[2]
	local zz = d[3]
	local yy = (zx*zx + zz*zz)^(1/2)
	local xx = -zz/yy
	local xy = 0
	local xz = zx/yy
	local yx = -zx*zy/yy
	local yz = -zy*zz/yy
	return {{xx, yx, zx}, {xy, yy, zy}, {xz, yz, zz}}
end

--axis angle begin

function mat.axisangle(v)
	local x, y, z = v[1], v[2], v[3]
	local l = (x*x + y*y + z*z)^(1/2)
	if l > 0 then
		local s = sin(l)
		local c = cos(l)
		local t = 1 - c
		local x = x/l
		local y = y/l
		local z = z/l
		return {
			{t*x*x +   c, t*y*x + z*s, t*z*x - y*s};
			{t*x*y - z*s, t*y*y +   c, t*z*y + x*s};
			{t*x*z + y*s, t*y*z - x*s, t*z*z +   c};
		}
	else
		return {{1, 0, 0}, {0, 1, 0}, {0, 0, 1}}
	end
end

--axis angle end

--euler begin

function mat.eulerx(a)
	local s = sin(a)
	local c = cos(a)
	return {{1, 0, 0}, {0, c, s}, {0, -s, c}}
end

function mat.eulery(a)
	local s = sin(a)
	local c = cos(a)
	return {{c, 0, -s}, {0, 1, 0}, {s, 0, c}}
end

function mat.eulerz(a)
	local s = sin(a)
	local c = cos(a)
	return {{c, s, 0}, {-s, c, 0}, {0, 0, 1}}
end

--euler end

--quaternion begin

function mat.quat(q)
	local w, x, y, z = q[1], q[2], q[3], q[4]
	return {
		{1 - 2*(y*y + z*z),     2*(x*y - z*w),     2*(x*z + y*w)};
		{    2*(x*y + z*w), 1 - 2*(x*x + z*z),     2*(y*z - x*w)};
		{    2*(x*z - y*w),     2*(y*z + x*w), 1 - 2*(x*x + y*y)};
	}
end

--quaternion end

return mat
