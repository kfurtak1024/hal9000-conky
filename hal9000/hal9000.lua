function conky_system_temp()
    return conky_parse("${hwmon 9 temp 2}") .. "°C"
end

function conky_system_fan()
    return conky_parse("${hwmon 9 fan 3}") .. " RPM"
end

function conky_cpu_temp()
    local temp_str = conky_parse("${hwmon 5 temp 1}")
    local t = tonumber(temp_str)
    if not t then return "N/A" end

    if t <= 65 then
        return t .. "°C"
    elseif t <= 80 then
        return "${color #fb9435}" .. t .. "°C${color}"
    elseif t <= 90 then
        return "${color #bd0f2f}" .. t .. "°C${color}"
    else
        return "${color purple}" .. t .. "°C${color}"
    end
end

function conky_cpu_fan()
    return conky_parse("${hwmon 9 fan 1}") .. " RPM"
end

function conky_cpu_clock()
    return conky_parse("${execpi 2 awk '{if($1>max) max=$1} END {printf(\"%.1f GHz\", max/1000000)}' /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq}")
end

function conky_ram_temp()
    -- to be considered
    -- 0-40°C normal
    -- 40-45°C yellow
    -- 45-85°C red
    return conky_parse("${hwmon 6 temp 1}") .. "°C " .. conky_parse("${hwmon 7 temp 1}") .. "°C"
end

function conky_ram_usage()
    -- 0-60% normal
    -- 60-85% yellow
    -- 85-100% red
    return conky_parse("$mem") .. "/" .. conky_parse("$memmax") .. " (" .. conky_parse("$memperc") .. "%)"
end

function conky_swap_usage()
    return conky_parse("$swap") .. "/" .. conky_parse("$swapmax") .. " (" .. conky_parse("$swapperc") .. "%)"
end

function conky_gpu_temp()
    return conky_parse("${execi 5 nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits}") .. "°C"
end

function conky_gpu_fan()
    return conky_parse("${execi 5 nvidia-smi --query-gpu=fan.speed --format=csv,noheader,nounits}") .. "%"
end

function conky_gpu_util()
    return conky_parse("${execi 5 nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits}") .. "%"
end

function conky_gpu_power_draw()
    return conky_parse("${execi 5 nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits}") .. " W"
end

function conky_gpu_mem_usage()
	--$mem/$memmax ($memperc%)
	local vram_total = tonumber(conky_parse("${execi 5 nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits}"))
	local vram_used = tonumber(conky_parse("${execi 5 nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits}"))

    return bytes_to_human(vram_used * 1024 * 1024) .. "/" .. bytes_to_human(vram_total * 1024 * 1024) .. " (" .. math.floor(vram_used/vram_total*100) .. "%)"
end

function conky_nvme_temp(device)
    -- normal <= 50°C
    -- yellow <= 60°C
    -- red otherwise
    return conky_parse("${hwmon " .. device .. " temp 1}") .. "°C"
end

function conky_root_fs_usage()
    local fs_used = conky_parse("${fs_used /}")
    local fs_size = conky_parse("${fs_size /}")
    local fs_used_perc = tonumber(conky_parse("${fs_used_perc /}"))
    
    return string.format("%s/%s (%d%%)", fs_used, fs_size, fs_used_perc)
end

-------------

function conky_gpu_temp_color()
    local temp_str = conky_parse("${nvidia gputemp}")
    local t = tonumber(temp_str)
    if not t then return "N/A" end

    if t < 60 then
        return t .. "°C"
    elseif t < 75 then
        return "${color #fb9435}" .. t .. "°C${color}"
    else
        return "${color #bd0f2f}" .. t .. "°C${color}"
    end
end

function bytes_to_human(bytes)
    local units = {"B", "KiB", "MiB", "GiB", "TiB"}
    local i = 1
    local value = tonumber(bytes) or 0

    while value >= 1024 and i < #units do
        value = value / 1024
        i = i + 1
    end

    return string.format("%.1f %s", value, units[i])
end
