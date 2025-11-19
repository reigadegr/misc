#!/bin/sh
sleep 5
get_val(){
    for i in /proc/hmbird_sched/*; do
        [ -d "$i" ] && continue
        [ "$i" = "/proc/hmbird_sched/hmbird_stats" ] && continue
        echo "$i 值为: $(cat $i)"
    done

    echo "---"
    for i in /proc/hmbird_sched/slim*/*; do
        echo "$i 值为: $(cat $i)"
    done
    
}
app="$(dumpsys activity lru|rg " TOP"|cut -d ':' -f3|cut -d '/' -f1)"

get_val |tee "$app".txt

if [ "$app" != "$(dumpsys activity lru|rg " TOP"|cut -d ':' -f3|cut -d '/' -f1)" ]; then
    mv "$app".txt "退出游戏时机太早".txt
    echo "操作失误，退出游戏时机太早，请重新测试"
    exit 1
fi
