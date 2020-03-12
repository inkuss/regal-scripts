# Installation regal-scripts  
    cd /opt/regal  
    git clone https://github.com/edoweb/regal-scripts.git  
    cd regal-scripts  
  
# Edit variables and adjust to your own settings  
    cp variables.conf.tmpl variables.conf  
    editor variables.conf  
      
# Create soft links  
    cd /opt/edoweb/bin  
    ln -s /opt/regal/regal-scripts/cdn cdn  
      
# Define cron jobs  
Sample crontab:  
    # For more information see the manual pages of crontab(5) and cron(8)  
    #   
    # m h  dom mon dow   command  
    0 2 * * * /opt/regal/regal-scripts/turnOnOaiPmhPolling.sh  
    0 5 * * * /opt/regal/regal-scripts/turnOffOaiPmhPolling.sh  
    05 7 * * * /opt/regal/regal-scripts/register_urn.sh control  >> /opt/regal/cronjobs/log/control_urn_vergabe.log  
    1 1 * * * /opt/regal/regal-scripts/register_urn.sh katalog >> /opt/regal/cronjobs/log/katalog_update.log  
    1 0 * * * /opt/regal/regal-scripts/register_urn.sh register >> /opt/regal/cronjobs/log/register_urn.log  
    0 5 * * * /opt/regal/regal-scripts/updateAll.sh > /dev/null  
    #0 23 * * * /opt/regal/regal-scripts/loadCache.sh  
    0 1 * * * /opt/regal/regal-scripts/import-logfiles.sh >/dev/null  
    # Start Edoweb Webgatherer Sequenz  
    0 20 * * * /opt/regal/regal-scripts/runGatherer.sh >> /opt/regal/cronjobs/log/runGatherer.log  
    # Auswertung des letzten Webgatherer-Laufs  
    0 21 * * * /opt/regal/regal-scripts/evalWebgatherer.sh >> /opt/regal/cronjobs/log/runGatherer.log  
    # Verschieben von Dateien aus dem Arbeitsverzeichnis von wpull ins Outputverzeichnis von wpull  
    0 22 * * * /opt/regal/regal-scripts/ks.move_files_from_crawldir.sh >> /opt/regal/cronjobs/log/ks.move_files_from_crawldir.log  
    # Indexierung neu geharvesteter Webschnitte  
    0 2 * * * /opt/regal/regal-scripts/backup-es.sh -c >> /opt/regal/cronjobs/log/backup-es.log 2>&1  
    30 2 * * * /opt/regal/regal-scripts/backup-es.sh -b >> /opt/regal/cronjobs/log/backup-es.log 2>&1  
    0 2 * * * /opt/regal/regal-scripts/backup-db.sh -c >> /opt/regal/cronjobs/log/backup-db.log 2>&1  
    30 2 * * * /opt/regal/regal-scripts/backup-db.sh -b >> /opt/regal/cronjobs/log/backup-db.log 2>&1  
    0 2 * * * /opt/regal/regal-scripts/depersonalize-apache-logs.sh  
    # Crawl Reports  
    0 22 * * * /opt/regal/regal-scripts/crawlReport.sh >> /opt/regal/cronjobs/log/crawlReport.log  
