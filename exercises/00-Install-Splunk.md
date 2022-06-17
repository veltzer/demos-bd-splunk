```
ssh -i splunk_key.pem azureuser@IP
```

```
wget -O splunk-8.1.0-f57c09e87251-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.1.0&product=splunk&filename=splunk-8.1.0-f57c09e87251-linux-2.6-amd64.deb&wget=true'
```

```
sudo dpkg -i splunk-8.1.0-f57c09e87251-linux-2.6-amd64.deb
sudo /opt/splunk/bin/splunk enable boot-start
```

```
admin
student2020
```

```
sudo service splunk start
```

Now open at your browser the URL => http://localhost:8000/

## Download Links

MacOs

```
https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86&platform=macos&version=8.1.2&product=splunk&filename=splunk-8.1.2-545206cc9f70-macosx-10.11-intel.dmg&wget=true
```

Windows

```
https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=8.1.2&product=splunk&filename=splunk-8.1.2-545206cc9f70-x64-release.msi&wget=true
```