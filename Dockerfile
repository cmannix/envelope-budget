FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/EnvelopeBudget.Web/EnvelopeBudget.Web.csproj", "EnvelopeBudget.Web/"]
RUN dotnet restore "EnvelopeBudget.Web/EnvelopeBudget.Web.csproj"
COPY src .
WORKDIR "/src/EnvelopeBudget.Web"
RUN dotnet build "EnvelopeBudget.Web.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "EnvelopeBudget.Web.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "EnvelopeBudget.Web.dll"]
