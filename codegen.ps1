
fstar Welcome.fst --codegen FSharp --odir ./codegen

Write-Host "Code generated to ./codegen"

$fsproj = "./codegen/Welcome.fsproj"

$xml = @"
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net6.0</TargetFramework>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="FStarLib" Version="0.0.1-alpha" />
    <Compile Include="Welcome.fs" />
  </ItemGroup>

</Project>
"@

$xml | Out-File -FilePath $fsproj
