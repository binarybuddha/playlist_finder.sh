$src = "c:\sauce"
$dst = "c:\place"
dir $src -Recurse
dir $dst -Recurse
dir $src -Directory | select -ExcludeProperty FullName | Copy-Item -Destination $dst -Recurse
dir $src -Recurse
dir $dst -Recurse
