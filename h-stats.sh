#!/usr/bin/env bash

#######################
# Functions
#######################


get_miner_uptime(){
        local uptime=$(ps -o etimes= -C "noncerprohive")
        echo $uptime
}

stats_raw=`curl --connect-timeout 2 --max-time 5 --silent --noproxy '*' http://127.0.0.1:3000/api`
if [[ $? -ne 0 || -z $stats_raw ]]; then
  echo -e "${YELLOW}Failed to read $miner from http://127.0.0.1:3000/api${NOCOLOR}"
else
  khs=`echo $stats_raw | jq -r '.totalHashrate' | awk '{s+=$1} END {print s/1000}'` #"
  local ac=$(jq -r '.totalBlocks' <<< "$stats_raw")
  local inv=0

  local uptime=`get_miner_uptime`
  local algo="blake2s-256"

  local temp=$(jq "[.temp$amd_indexes_array]" <<< $gpu_stats)
  local fan=$(jq "[.fan$amd_indexes_array]" <<< $gpu_stats)

  stats=$(jq --arg ac "$ac" --arg inv "$inv" \
         --arg algo "$algo" \
         --arg uptime "$uptime" \
         --argjson fan "$fan" --argjson temp "$temp" \
        '{hs: [.devices[].hashrate], hs_units: "hs", $algo, $temp,
        $fan, $uptime, ar: [$ac, 0, $inv]}' <<< "$stats_raw")
fi

  [[ -z $khs ]] && khs=0
  [[ -z $stats ]] && stats="null"

