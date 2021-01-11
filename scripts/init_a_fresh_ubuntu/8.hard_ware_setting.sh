for hardware in `realpath *TB*`
do
        hardware_name=`basename $hardware`
        for user in `ls /home`
        do
                dir="$hardware"/"$user"
                linkdir=/home/"$user"/"$hardware_name"

                echo "$dir --> $linkdir"
                mkdir -p $dir
                ln -s $dir $linkdir
                
                chown -R "$user":deepones   $dir
                chown -R "$user":deepones -h $linkdir
        done
done
