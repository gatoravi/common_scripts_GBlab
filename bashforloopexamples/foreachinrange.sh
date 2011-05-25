#!/bin/bash
for i in 1 2 3 4 5
do
   echo "Welcome $i times"
done




#!/bin/bash
for i in {1..5}
do
   echo "Welcome $i times"
done



#!/bin/bash
echo "Bash version ${BASH_VERSION}..."
for i in {0..10..2}
  do
     echo "Welcome $i times"
 done
 
 
 
#!/bin/bash
for (( c=1; c<=5; c++ ))
do
	echo "Welcome $c times..."
done


#!/bin/bash
for file in /etc/*
do
	if [ "${file}" == "/etc/resolv.conf" ]
	then
		countNameservers=$(grep -c nameserver /etc/resolv.conf)
		echo "Total  ${countNameservers} nameservers defined in ${file}"
		break
	fi
done
