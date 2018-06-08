# Build image
FROM microsoft/dotnet:2.0-sdk as builder 
WORKDIR /sln  
COPY ./VodacommessagingXml2sms.sln ./

# Copy all the csproj files and restore
COPY /SharedModels/*.csproj SharedModels/
COPY /VodacommessagingXml2sms/*.csproj VodacommessagingXml2sms/
COPY /Tests/*.csproj Tests/
RUN dotnet restore

COPY ./SharedModels ./SharedModels
COPY ./VodacommessagingXml2sms ./VodacommessagingXml2sms
COPY ./Tests ./Tests

RUN dotnet build -c Release --no-restore

#RUN dotnet test "./Tests/Tests.csproj" -c Release --no-build --no-restore

#RUN dotnet publish "./VodacommessagingXml2sms/VodacommessagingXml2sms.csproj" -c Release -o "../../dist" --no-restore
RUN dotnet publish -c Release -o out

#Build the app image
FROM microsoft/aspnetcore:2.0  
WORKDIR /app  
ENV ASPNETCORE_ENVIRONMENT Local  
ENTRYPOINT ["dotnet", "VodacommessagingXml2sms.dll"] 
COPY --from=builder out app