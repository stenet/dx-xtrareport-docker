# Repo font bold

## Steps to reproduce

1. There must be a NuGet.config in the root directory to install the DevExpress packages
1. Execute ```docker-compose up --build``` in cmd/bash
1. Open [http://localhost:8071/Report](http://localhost:8071/Report) in browser

## Sample NuGet.Config

```
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <packageSources>
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" protocolVersion="3" />
    <add key="DevExpress Nuget server" value="https://nuget.devexpress.com/<YOUR-DX-KEY>/api" />
  </packageSources>
</configuration>
```