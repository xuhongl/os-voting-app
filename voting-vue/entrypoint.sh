#!/bin/sh

# Replace env vars in JavaScript files
echo "Replacing env vars in JS"
#for file in /code/js/app.*.js;
for file in /usr/share/nginx/html/js/app.*.js;
do
  echo "Processing $file...";

  # Use the existing JS file as template
  if [ ! -f $file.tmpl.js ]; then
    cp $file $file.tmpl.js
  fi

  # The tool 'envsubst' is included in the nginx container image and replaces strings in a file with the value of the given environment variable
  envsubst '$VUE_APP_OPTION_A,$VUE_APP_OPTION_B' < $file.tmpl.js > $file
  
  echo "Done processing $file.";
done

echo "Starting Nginx."
nginx -g 'daemon off;'