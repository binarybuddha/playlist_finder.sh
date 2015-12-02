# playlist_finder.sh
#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do
	filepath=`locate -i "$line"`
	rc=$?
    if [[ $rc = 1 ]]; then
		echo Shucks, no luck chuck. Did not find $line
		echo "$line WAS NOT FOUND in playlist $1" | sed 's/.media.*playlist.//' >> not_found.log
	else
		echo "Found $filepath, writing to output.m3u8"
		echo "$filepath" | sed 's/.media.*Music.//' >> output.m3u8
	fi
done < "$1"
