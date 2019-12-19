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
0 5 * * * /opt/regal/regal-scripts/updateAll.sh > /dev/null
#0 23 * * * /opt/regal/regal-scripts/loadCache.sh
0 1 * * * /opt/regal/regal-scripts/import-logfiles.sh >/dev/null
# Start Edoweb Webgatherer Sequenz
0 20 * * * /opt/regal/regal-scripts/runGatherer.sh >> /opt/regal/cronjobs/log/runGatherer.log
# Auswertung des letzten Webgatherer-Laufs
0 21 * * * /opt/regal/regal-scripts/evalWebgatherer.sh >> /opt/regal/cronjobs/log/runGatherer.log
0 2 * * * /opt/regal/regal-scripts/depersonalize-apache-logs.sh
# Crawl Reports
0 22 * * * /opt/regal/regal-scripts/crawlReport.sh >> /opt/regal/logs/crawlReport.log
