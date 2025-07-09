#!/bin/bash

echo "Process Started"

# Setting up project folder
mkdir $2
cd $2
git init

# Get the names of the contributers
svn log $1 -q | awk -F '|' '/^r/ {sub("^ ", "", $2); sub(" $", "", $2); print $2" = "$2" <"$2">"}' | sort -u > authors-transform.txt

if [ -s authors-transform.txt ]; then 
	echo "Created authors file"
	mv ./authors-transform.txt ./$2/
	cd ./$2/
else
	echo "ERROR: Failed to create authors file"
	exit 1
fi

# Convert names
# !!!!!!! To implement !!!!!!!


# Clone the repo
git svn clone $1 --no-metadata --authors-file=authors-transform.txt --stdlayout ./

# Remove the authors file from the repo
rm authors-transform.txt

if [[ $f -eq 0 ]]; then
    echo "Removed authors file" 
else
    echo "ERROR: Failed to remove authors file" 
fi


# Convert svn:ignore to .gitignore
git svn show-ignore > .gitignore

if [ -s .gitignore ]; then 
	echo "Created .gitigore"
else
	echo "ERROR: Failed to create .gitignore"
fi

# Convert tags
echo "Starting tag conversion"
for t in $(git for-each-ref --format='%(refname:short)' refs/remotes/tags); do git tag ${t/tags\//} $t && git branch -D -r $t; done

if [[ $f -eq 0 ]]; then
	echo "Succesfully converted tags"
else
	echo "ERROR: Tag conversion failed"
fi

# Convert branches
echo "Starting branch conversion..."
for b in $(git for-each-ref --format='%(refname:short)' refs/remotes); do git branch $b refs/remotes/$b && git branch -D -r $b; done

if [[ $f -eq 0 ]]; then
	echo "Succesfully converted branches"
else
	echo "ERROR: Branch creation failed"
fi

exit 0
