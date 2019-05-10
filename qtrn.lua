local sin  = math.sin
local cos  = math.cos
local acos = math.acos

local qtrn = {}

function qtrn.inv(q)
	return {q[1], -q[2], -q[3], -q[4]}
end

function qtrn.tomat(q)
	local w, x, y, z = q[1], q[2], q[3], q[4]
	return {
		{1 - 2*(y*y + z*z),     2*(x*y - z*w),     2*(x*z + y*w)};
		{    2*(x*y + z*w), 1 - 2*(x*x + z*z),     2*(y*z - x*w)};
		{    2*(x*z - y*w),     2*(y*z + x*w), 1 - 2*(x*x + y*y)};
	}
end

function qtrn.vectoworld(q, v)
	local w, x, y, z = q[1], q[2], q[3], q[4]
	local i, j, k = v[1], v[2], v[3]
	return {
		i - 2*(i*(y*y + z*z) - j*(x*y - z*w) - k*(x*z + y*w));
		j + 2*(i*(x*y + z*w) - j*(x*x + z*z) + k*(y*z - x*w));
		k + 2*(i*(x*z - y*w) + j*(y*z + x*w) - k*(x*x + y*y));
	}
end

function qtrn.vectolocal(q, v)
	local w, x, y, z = q[1], q[2], q[3], q[4]
	local i, j, k = v[1], v[2], v[3]
	return {
		i - 2*(i*(y*y + z*z) - j*(x*y + z*w) - k*(x*z - y*w));
		j + 2*(i*(x*y - z*w) - j*(x*x + z*z) + k*(y*z + x*w));
		k + 2*(i*(x*z + y*w) + j*(y*z - x*w) - k*(x*x + y*y));
	}
end

function qtrn.mul(a, b)
	local aw, ax, ay, az = a[1], a[2], a[3], a[4]
	local bw, bx, by, bz = b[1], b[2], b[3], b[4]
	return {
		aw*bw - ax*bx - ay*by - az*bz;
		aw*bx + ax*bw + ay*bz - az*by;
		aw*by - ax*bz + ay*bw + az*bx;
		aw*bz + ax*by - ay*bx + az*bw;
	}
end

function qtrn.pow(q, n)
	local w, x, y, z = q[1], q[2], q[3], q[4]
	local t = n*acos(w)
	local s = sin(t)/(x*x + y*y + z*z)^(1/2)
	return {cos(t), s*x, s*y, s*z}
end

function qtrn.slerp(a, b, n)
	local aw, ax, ay, az = a[1], a[2], a[3], a[4]
	local bw, bx, by, bz = b[1], b[2], b[3], b[4]

	if aw*bw + ax*bx + ay*by + az*bz < 0 then
		aw = -aw
		ax = -ax
		ay = -ay
		az = -az
	end
	
	local w = aw*bw + ax*bx + ay*by + az*bz
	local x = aw*bx - ax*bw + ay*bz - az*by
	local y = aw*by - ax*bz - ay*bw + az*bx
	local z = aw*bz + ax*by - ay*bx - az*bw

	local t = n*acos(w)
	local s = sin(t)/(x*x + y*y + z*z)^(1/2)

	local bw = cos(t)
	local bx = s*x
	local by = s*y
	local bz = s*z

	return {
		aw*bw - ax*bx - ay*by - az*bz;
		aw*bx + ax*bw - ay*bz + az*by;
		aw*by + ax*bz + ay*bw - az*bx;
		aw*bz - ax*by + ay*bx + az*bw;
	}
end

function qtrn.fromaxisangle(v)
	local x, y, z = v[1], v[2], v[3]
	local l = (x*x + y*y + z*z)^(1/2)
	local x, y, z = x/l, y/l, z/l
	local s = sin(1/2*l)
	return {cos(1/2*l), s*x, s*y, s*z}
end

function qtrn.toaxisangle(q)
	local w, x, y, z = q[1], q[2], q[3], q[4]
	local l = (x*x + y*y + z*z)^(1/2)
	local t = 2*acos(w)
	local s = (1 - w*w)^(1/2)
	return {t*x/l, t*y/l, t*z/l}
end

function qtrn.fromeuleranglesx(t)
	return {cos(1/2*t), sin(1/2*t), 0, 0}
end

function qtrn.fromeuleranglesy(t)
	return {cos(1/2*t), 0, sin(1/2*t), 0}
end

function qtrn.fromeuleranglesz(t)
	return {cos(1/2*t), 0, 0, sin(1/2*t)}
end

return qtrn
