#!/bin/bash

ntlsConfigFile=/etc/ntls.cfg
facenapiConfigFile=/etc/findface-facenapi.ini
nnapiConfigFile=/etc/findface-nnapi.ini
fkvideoConfigFile=/etc/fkvideo.ini
extractionapiConfigFile=/etc/findface-extraction-api.ini

FF_PACKAGES="ntls findface-nnapi fkvideo-detector python3-facenapi.core python3-facenapi findface-tarantool-server findface-tarantool-build-index findface-ui findface-mass-enroll findface-extraction-api findface-repo findface-rtmp-server findface-upload"
SIDE_PACKAGES="mongod* tarantool*"
ALL_PACKAGES="$FF_PACKAGES $SIDE_PACKAGES findface-data"

now=$(date +"%m_%d_%Y.%H:%M")

echo "############################
!!!This script will remove FindFace server (include MongoDB, Tarantool). 
All faces can be ERASED!!! 
Config files will be backed up."

uninstallServer() {
    sudo service 'findface*' stop
    sudo service 'fkvideo*' stop
    sudo service 'ntls' stop
    sudo service 'nginx*' stop
    sudo service 'tarantool*' stop
    sudo service 'mongod*' stop


    if [ -e $ntlsConfigFile ]
        then
            sudo cp $ntlsConfigFile $ntlsConfigFile.$now.backup
            sudo rm $ntlsConfigFile
            echo "File $ntlsConfigFile found and deleted. Backup created."    
        else
            echo "NO such file or directory $ntlsConfigFile"
    fi

    if [ -e $facenapiConfigFile ]
        then
            sudo cp $facenapiConfigFile $facenapiConfigFile.$now.backup
            sudo rm $facenapiConfigFile
            echo "File $facenapiConfigFile found and deleted. Backup created."    
        else
            echo "NO such file or directory $facenapiConfigFile"
    fi

    if [ -e $nnapiConfigFile ]
        then
            sudo cp $nnapiConfigFile $nnapiConfigFile.$now.backup
            sudo rm $nnapiConfigFile
            echo "File $nnapiConfigFile found and deleted. Backup created."    
        else
            echo "NO such file or directory $nnapiConfigFile"
    fi

    for  obj in /etc/tntapi*
        do
           if [ -d "$obj" ]
            then
               echo "$obj is a folder"
            elif [ -f "$obj" ]
               then
                   sudo cp $obj $obj.$now.backup
                   sudo rm $obj
                   echo "File $obj found and deleted. Backup created."
            fi
    done

    if [ -e $fkvideoConfigFile ]
        then
            sudo cp $fkvideoConfigFile $fkvideoConfigFile.$now.backup
            sudo rm $fkvideoConfigFile
            echo "File $fkvideoConfigFile found and deleted. Backup created."    
        else
            echo "NO such file or directory $fkvideoConfigFile"
    fi

    if [ -e $extractionapiConfigFile ]
        then
            sudo cp $extractionapiConfigFile $extractionapiConfigFile.$now.backup
            sudo rm $extractionapiConfigFile
            echo "File $extractionapiConfigFile found and deleted. Backup created."    
        else
            echo "NO such file or directory $extractionapiConfigFile"
    fi

    sudo apt-get -y purge $FF_PACKAGES

    #sudo rm -rf /opt/ntech
    sudo rm -rf /var/findface-repo

    #sudo rm /etc/nginx/sites-available/ffupload
    sudo rm /etc/nginx/sites-available/nnapi
    sudo rm /etc/nginx/sites-available/ntls
    sudo rm /etc/nginx/ntls.htpasswd

    #sudo rm -rf /etc/tarantool/sites.available/FindFace*

    #sudo rm -rf /var/lib/ffupload

    #sudo rm -rf /usr/bin/mongo*
    #sudo rm -rf /var/lib/mongodb

    #sudo rm /etc/apt/sources.list.d/ntechlab.list
    #sudo rm /etc/apt/sources.list.d/mongodb-org-*
    #sudo apt-key del E2CADE97


    sudo systemctl daemon-reload
    sudo apt-get update

    sudo service 'tarantool*' start
    sudo service 'mongod*' start
}

uninstallAll() {
    sudo service 'findface*' stop
    sudo service 'fkvideo*' stop
    sudo service 'ntls' stop
    sudo service 'nginx*' stop
    sudo service 'tarantool*' stop
    sudo service 'mongod*' stop


    if [ -e $ntlsConfigFile ]
        then
            sudo cp $ntlsConfigFile $ntlsConfigFile.$now.backup
            sudo rm $ntlsConfigFile
            echo "File $ntlsConfigFile found and deleted. Backup created."    
        else
            echo "NO such file or directory $ntlsConfigFile"
    fi

    if [ -e $facenapiConfigFile ]
        then
            sudo cp $facenapiConfigFile $facenapiConfigFile.$now.backup
            sudo rm $facenapiConfigFile
            echo "File $facenapiConfigFile found and deleted. Backup created."    
        else
            echo "NO such file or directory $facenapiConfigFile"
    fi

    if [ -e $nnapiConfigFile ]
        then
            sudo cp $nnapiConfigFile $nnapiConfigFile.$now.backup
            sudo rm $nnapiConfigFile
            echo "File $nnapiConfigFile found and deleted. Backup created."    
        else
            echo "NO such file or directory $nnapiConfigFile"
    fi

    for  obj in /etc/tntapi*
        do
           if [ -d "$obj" ]
            then
               echo "$obj is a folder"
            elif [ -f "$obj" ]
               then
                   sudo cp $obj $obj.$now.backup
                   sudo rm $obj
                   echo "File $obj found and deleted. Backup created."
            fi
    done

    if [ -e $fkvideoConfigFile ]
        then
            sudo cp $fkvideoConfigFile $fkvideoConfigFile.$now.backup
            sudo rm $fkvideoConfigFile
            echo "File $fkvideoConfigFile found and deleted. Backup created."    
        else
            echo "NO such file or directory $fkvideoConfigFile"
    fi

    if [ -e $extractionapiConfigFile ]
        then
            sudo cp $extractionapiConfigFile $extractionapiConfigFile.$now.backup
            sudo rm $extractionapiConfigFile
            echo "File $extractionapiConfigFile found and deleted. Backup created."    
        else
            echo "NO such file or directory $extractionapiConfigFile"
    fi

    sudo apt-get -y purge $ALL_PACKAGES

    sudo rm -rf /opt/ntech
    sudo rm -rf /var/findface-repo

    sudo rm /etc/nginx/sites-available/ffupload
    sudo rm /etc/nginx/sites-available/nnapi
    sudo rm /etc/nginx/sites-available/ntls
    sudo rm /etc/nginx/ntls.htpasswd

    sudo rm -rf /etc/tarantool/sites.available/FindFace*

    sudo rm -rf /var/lib/ffupload

    sudo rm -rf /usr/bin/mongo*
    sudo rm -rf /var/lib/mongodb

    sudo rm /etc/apt/sources.list.d/ntechlab.list
    sudo rm /etc/apt/sources.list.d/mongodb-org-*
    sudo apt-key del E2CADE97


    sudo systemctl daemon-reload
    sudo apt-get update
}

while true; do
    read -p "
server  = uninstall server components. Faces and DB will be saved.
all     = uninstall all server components (include neural network) and wipe all saved faces.
no      = cancel operation.
Please select one

> " asc
    case $asc in
    server ) uninstallServer; break;;
    all ) uninstallAll; break;;
    no ) exit;;
        * ) echo "

############################
Please answer server/all/no.";;
    esac
done

echo "Done"
