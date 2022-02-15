
$moduleName = $args[0]

Write-Host "Processing $moduleName"

$filename = "$moduleName.fst"

fstar $filename --dep full --codegen FSharp --odir ./codegen

Write-Host "Code generated to ./codegen"

$fsproj = "./codegen/$moduleName.fsproj"
$fsentry = "./codegen/Program.fs"
$pydir = "./codegen/"
$py = "./codegen/$moduleName.fsproj"

$xml = @"
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net6.0</TargetFramework>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="FStarLib" Version="0.0.2-alpha" />
    <Compile Include="$moduleName.fs" />
    <!-- <Compile Include="Program.fs" /> -->
  </ItemGroup>

</Project>
"@

$entry = @"
open $moduleName

main (fun () -> System.Console.ReadLine()) (fun s -> printfn $"{s}")
"@

$xml | Out-File -FilePath $fsproj
$entry | Out-FIle -FilePath $fsentry

if ($args[1] -eq "fscodegen")
{

}
else
{
  if (($args[1] -eq "pycodegen") -or ($args[1] -eq "pyrun"))
  {
    fable-py $fsproj --outDir $pydir
  }
}

if ($args[1] -eq "fsrun")
{
  dotnet run --project $fsproj
}
else
{
  if ($args[2] -eq "pyrun")
  {
    python $py
  }
}