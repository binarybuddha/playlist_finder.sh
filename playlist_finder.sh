#!/bin/bash
rm output.m3u8
while IFS='' read -r line || [[ -n "$line" ]]; do
	line=`echo "$line" | sed 's/^The //I'`
	artist=`echo $line | grep -o -E "^\S*"`
	track=`echo $line | grep -oP ' - \K\w+'`
	filepath=`locate -i -l 1 -b --regex ".*$line"`
	rc=$?
    if [[ $rc = 1 ]]; then
		artistTrackRegEx=`echo $artist.* - $track.*`
		filepath=`locate -i -l 1 -b --regex "$artistTrackRegEx"`
		rc=$?
		echo "*** $line not found, attempting regex locate using $artistTrackRegEx"
		if [[ $rc = 1 ]]; then
			echo "# $line WAS NOT FOUND in playlist $1" | sed 's/.media.*playlist.//I' | tee -a output.m3u8
		else
			echo "Second Try Found $filepath, writing to output.m3u8" | sed 's/.media.*Music.//I'
			echo "$filepath" | sed 's/.media.*Music.//' >> output.m3u8
		fi
	else
		echo "$filepath" | sed 's/.media.*Music.//I' | tee -a output.m3u8
	fi
done < "$1"
echo "******************* Script run complete, showing non-matches below *******************"
grep " WAS NOT FOUND in playlist" output.m3u8
