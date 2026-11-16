#!/bin/bash

#set -x

input_file="/home/dany/git/dimo-tv/TV"
output_file="/home/dany/git/dany-tv/Russia.m3u8"
channels_dimo=('group-title="Rutube (VPN)",Первый канал HD' 'group-title="С сайтов (VPN)", Россия 1 HD' 'group-title="Rutube (VPN)",Россия К' 'group-title="С сайтов (VPN)" ,Россия 24' 'group-title="Rutube (VPN)",НТВ HD' 'group-title="Сириус",Пятый канал' 'group-title="Сириус",ТНТ' 'group-title="Rutube (VPN)",ТНТ HD' 'group-title="Rutube (VPN)",ТНТ4 HD' 'group-title="Сириус",Карусель' 'Оргтехсервис (VPN)",Че' 'group-title="Rutube (VPN)",ОТР' 'group-title="Сириус",Рен ТВ' 'group-title="TEST (VPN)",Победа' 'group-title="Сириус",СТС' 'group-title="Сириус",Домашний' 'group-title="Сириус",Звезда' 'group-title="Сириус",Мир' 'group-title="С сайтов (VPN)",ТВЦ' 'group-title="Сириус",ТВ3' 'group-title="Rutube (VPN)",Пятница HD' 'group-title="Rutube (VPN)",2x2' 'group-title="Rutube (VPN)",Ю')
channels_dimo_sport=('group-title="Rutube (VPN)",Матч ТВ HD' 'group-title="Спорткомплекс 🏆",KHL Prime' 'group-title="Peers (VPN)" ,Матч ТВ' 'group-title="Peers (VPN)" ,Матч! Боец' 'group-title="Peers (VPN)" ,Матч! АРЕНА' 'group-title="Peers (VPN)" ,Матч! Игра' 'group-title="Peers (VPN)" ,Матч! Футбол 2 HD' 'group-title="Peers (VPN)" ,Матч! Футбол 3 HD' 'group-title="Peers (VPN)" ,Матч Премьер HD')
channels_dany=('group-title="Alle",Первый канал' 'group-title="Alle" ,Россия HD' 'group-title="Alle",Россия K' 'group-title="Alle",Россия 24' 'group-title="Alle",НТВ HD2' 'group-title="Alle",Пятый канал' 'group-title="Alle",ТНТ' 'group-title="Alle",ТНТ HD' 'group-title="Alle",ТНТ4' 'group-title="Alle",Карусель' 'group-title="Alle",Че' 'group-title="Alle",ОТР' 'group-title="Alle" ,РЕН ТВ HD' 'group-title="Alle" ,Победа HD' 'group-title="Alle" ,СТС' 'group-title="Alle",Домашний' 'group-title="Alle",Звезда' 'group-title="Alle" ,Мир' 'group-title="Alle",ТВЦ' 'group-title="Alle" ,ТВ3' 'group-title="Alle" ,Пятница' 'group-title="Alle",2x2' 'group-title="Alle", Ю')
channels_dany_sport=('group-title="Alle",Матч ТВ HD' 'group-title="Alle",Матч ТВ' 'group-title="Alle",Матч! Боец' 'group-title="Alle",Матч! АРЕНА' 'group-title="Alle",Матч! Игра' 'group-title="Alle",Матч! Футбол 2 HD' 'group-title="Alle",Матч! Футбол 3 HD' 'group-title="Alle",Матч Премьер HD')

for ((i=0; i<${#channels_dimo[@]}; i++))
do
    search_in=$(printf '%s\n' "${channels_dimo[$i]}" | sed 's/[][\\/.*^$|]/\\&/g')
    new_link=$(awk -v s="$search_in" '
    index($0, s) {
        getline next1
        if (next1 ~ /^https?:\/\//) { print next1; exit }
        getline next2
        if (next2 ~ /^https?:\/\//) { print next2; exit }
        exit
    }
    ' "${input_file}")

    search_out=$(printf '%s\n' "${channels_dany[$i]}" | sed 's/[][\\/.*^$|]/\\&/g')
    replace_out=$(printf '%s\n' "$new_link" | sed 's/[&|]/\\&/g')

    sed -i "/${search_out}\$/{n;s|.*|${replace_out}|;}" "${output_file}"
done