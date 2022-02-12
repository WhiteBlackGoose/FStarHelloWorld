
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
    <Compile Include="Welcome.fs" />
  </ItemGroup>

</Project>
"@

if ( -not (Test-Path -Path $fsproj -PathType Leaf ))
{
    Set-Location codegen
    $xml | Out-File -FilePath "Welcome.fsproj"
}
