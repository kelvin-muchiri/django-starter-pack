#!/bin/bash

# Usage: ./rename_project.sh new_project_name
# Example: ./rename_project.sh my_new_project

if [ -z "$1" ]; then
  echo "Please provide a new project name."
  exit 1
fi

NEW_NAME=$1
OLD_NAME="backend"

# Files to update
FILES=(
  "manage.py"
  "backend/asgi.py"
  "backend/settings.py"
  "backend/urls.py"
  "backend/wsgi.py"
  "backend/celery.py"
)

# Update project name in each file
for FILE in "${FILES[@]}"; do
  if [ -f "$FILE" ]; then
    sed -i "s/$OLD_NAME/$NEW_NAME/g" "$FILE"
    echo "Updated $FILE"
  else
    echo "File $FILE not found!"
  fi
done

# Rename the project directory
if [ -d "$OLD_NAME" ]; then
  mv "$OLD_NAME" "$NEW_NAME"
  echo "Renamed directory $OLD_NAME to $NEW_NAME"
else
  echo "Directory $OLD_NAME not found!"
fi

echo "Project rename complete."
