FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build-env

WORKDIR /App

COPY . ./

RUN dotnet restore ./CicdAndDocker.csproj

RUN dotnet publish ./CicdAndDocker.csproj -c Release -o out

FROM mcr.microsoft.com/dotnet/runtime:8.0

WORKDIR /App

COPY --from=build-env /App/out .

ENTRYPOINT [ "dotnet", "CicdAndDocker.dll" ]
