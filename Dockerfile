FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

RUN apt-get update

RUN apt-get install -y libc6 -f -o APT::Immediate-Configure=0
RUN apt-get install -y libgdiplus libicu-dev libharfbuzz0b libfontconfig1 libfreetype6
RUN apt-get install -y libpango-1.0-0 libpangocairo-1.0
RUN apt-get install -y fontconfig

COPY fonts/*.ttf /usr/share/fonts/
RUN fc-cache -fv

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["NuGet.config", "./"]
COPY ["TestReportDocker/TestReportDocker.csproj", "TestReportDocker/"]
RUN dotnet restore "TestReportDocker/TestReportDocker.csproj"
COPY . .
WORKDIR "/src/TestReportDocker"
RUN dotnet build "TestReportDocker.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TestReportDocker.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TestReportDocker.dll"]
