sudo apt-get install memcached;
sudo apt-get install curl;
sudo apt-get install php5-xcache;

curl -0 http://dumps.wikimedia.org/mediawiki/1.21/mediawiki-1.21.0.tar.gz > mw-1.21.0.tgz;
#curl -0 http://dumps.wikimedia.org/mediawiki/1.20/mediawiki-1.20.6.tar.gz > mw-1.20.6.tgz;
#curl -0 http://dumps.wikimedia.org/mediawiki/1.19/mediawiki-1.19.2.tar.gz > mw-1.19.2.tgz;
#curl -0 http://dumps.wikimedia.org/mediawiki/1.15/mediawiki-1.15.5.tar.gz > mw-1.15.5.tgz;

echo "
PLEASE make sure that 'memcached' is running properly!!!
"
