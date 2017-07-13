# Run the script below. As a result, a new file tntapi_cluster.json will be created and contain a list of all shards distributed evenly over 1024 cells. 

```cat s.txt | perl -lane 'push(@s,$_); END{$m=1024; $t=scalar @s;for($i=0;$i<$m;$i++){$k=int($i*$t/$m); push(@r,"\"".$s[$k]."\"")} print "[[".join(", ",@r)."]]"; }' > tntapi_cluster.json```