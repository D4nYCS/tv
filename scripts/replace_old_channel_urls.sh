#!/bin/bash

#set -x

input_file="/home/dany/git/dimo-tv/TV"
output_file="/home/dany/git/dany-tv/Russia.m3u8"
channels_dimo=('group-title="Peers (VPN)" ,Первый канал HD +4' 'group-title="Peers (VPN)" ,Россия HD' 'group-title="Peers (VPN)" ,Россия К' 'group-title="Peers (VPN)" ,Россия 24' 'group-title="Peers (VPN)" ,НТВ HD' 'group-title="Скай Телеком", Пятый канал' 'group-title="Peers (VPN)" ,ТНТ' 'group-title="Peers (VPN)" ,ТНТ HD' 'group-title="Peers (VPN)" ,ТНТ4' 'group-title="Peers (VPN)" ,Карусель' 'group-title="Peers (VPN)" ,Че' 'group-title="Peers (VPN)" ,ОТР' 'group-title="Peers (VPN)" ,РЕН ТВ HD' 'group-title="Peers (VPN)" ,Победа HD' 'group-title="Peers (VPN)" ,СТС' 'group-title="Peers (VPN)" ,Домашний' 'group-title="Peers (VPN)" ,Звезда' 'group-title="Peers (VPN)" ,Мир' 'group-title="Peers (VPN)" ,ТВЦ +4' 'group-title="Peers (VPN)" ,ТВ3' 'group-title="Peers (VPN)" ,Пятница' 'group-title="Peers (VPN)" ,2x2 (+4)' 'group-title="Peers (VPN)" ,Ю (+4)')
channels_dimo_sport=('group-title="Rutube (VPN)",Матч ТВ HD' 'group-title="Спорткомплекс 🏆",KHL Prime' 'group-title="Peers (VPN)" ,Матч ТВ' 'group-title="Peers (VPN)" ,Матч! Боец' 'group-title="Peers (VPN)" ,Матч! АРЕНА' 'group-title="Peers (VPN)" ,Матч! Игра' 'group-title="Peers (VPN)" ,Матч! Футбол 2 HD' 'group-title="Peers (VPN)" ,Матч! Футбол 3 HD' 'group-title="Peers (VPN)" ,Матч Премьер HD')
channels_dany=('group-title="Alle",Первый канал' 'group-title="Alle" ,Россия HD' 'group-title="Alle",Россия K' 'group-title="Alle",Россия 24' 'group-title="Alle",НТВ HD2' 'group-title="Alle",Пятый канал' 'group-title="Alle",ТНТ' 'group-title="Alle",ТНТ HD' 'group-title="Alle",ТНТ4' 'group-title="Alle",Карусель' 'group-title="Alle",Че' 'group-title="Alle",ОТР' 'group-title="Alle" ,РЕН ТВ HD' 'group-title="Alle" ,Победа HD' 'group-title="Alle" ,СТС' 'group-title="Alle",Домашний' 'group-title="Alle",Звезда' 'group-title="Alle" ,Мир' 'group-title="Alle",ТВЦ' 'group-title="Alle" ,ТВ3' 'group-title="Alle" ,Пятница' 'group-title="Alle",2x2' 'group-title="Alle", Ю')
channels_dany_sport=('group-title="Alle",Матч ТВ HD' 'group-title="Alle",Матч ТВ' 'group-title="Alle",Матч! Боец' 'group-title="Alle",Матч! АРЕНА' 'group-title="Alle",Матч! Игра' 'group-title="Alle",Матч! Футбол 2 HD' 'group-title="Alle",Матч! Футбол 3 HD' 'group-title="Alle",Матч Премьер HD')

for ((i=0; i<${#channels_dimo[@]}; i++))
do
    search_in=$(printf '%s\n' "${channels_dimo[$i]}" | sed 's/[][\\/.*^$|]/\\&/g')
    new_link=$(sed -n "/${search_in}\$/{n;p;q;}" "${input_file}")

    search_out=$(printf '%s\n' "${channels_dany[$i]}" | sed 's/[][\\/.*^$|]/\\&/g')
    replace_out=$(printf '%s\n' "$new_link" | sed 's/[&|]/\\&/g')

    sed -i "/${search_out}\$/{n;s|.*|${replace_out}|;}" "${output_file}"
done