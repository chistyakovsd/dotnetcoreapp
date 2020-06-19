FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /webapp

# copy csproj file and restore
COPY ./*.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . .
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /webapp
COPY --from=build /webapp/out .
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "dotnetcoreapp.dll"]