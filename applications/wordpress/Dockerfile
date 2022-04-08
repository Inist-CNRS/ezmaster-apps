FROM inistcnrs/ezmaster-phpserver:3.3.1
RUN curl -fsSL https://fr.wordpress.org/wordpress-5.9.3-fr_FR.tar.gz | tar xvz -C "/var/www/html" --strip 1
ADD ./wp-config.php /var/www/html/
