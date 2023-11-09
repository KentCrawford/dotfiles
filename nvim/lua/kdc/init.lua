local function get_proc_version()
  local f = io.open('/proc/version', 'r')
  local s = f:read('*a')
  f.close()
  return s
end

function is_red_hat()
  local s = get_proc_version()
  return string.find(s, 'Red Hat') and true or false
end

function is_debian()
  local s = get_proc_version()
  return string.find(s, 'Debian') and true or false
end

require('kdc.packer')
require('kdc.remap')
