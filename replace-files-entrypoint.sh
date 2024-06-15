#!/bin/bash

download_and_replace() {
  local url=$1
  local dest=$2

  if [ -z "$url" ]; then
    echo "The environment variable for $dest is not defined. Using the default file."
  else
    echo "Downloading $dest file from $url..."

    curl -o $dest $url

    if [ $? -eq 0 ]; then
      echo "File $dest downloaded with success."
      cat $dest
    else
      echo "Failed to download file $dest. Check the URL provided."
    fi
  fi
}

download_and_replace "$UPLOADS_INI_URL" "/usr/local/etc/php/conf.d/uploads.ini"
download_and_replace "$WP_CONFIG_PHP_URL" "/var/www/html/wp-config.php"
download_and_replace "$HTACCESS_URL" "/var/www/html/.htaccess"
download_and_replace "$INDEX_PHP_URL" "/var/www/html/index.php"
download_and_replace "$PHP_INI_URL" "/usr/local/etc/php/php.ini"

docker-entrypoint.sh apache2-foreground