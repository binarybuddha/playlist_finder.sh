$src = "c:\sauce"
$dst = "c:\place"
dir $src -Directory | select -ExcludeProperty FullName | Copy-Item -Destination $dst -Recurse
