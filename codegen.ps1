
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
    <!-- <Compile Include="../ulib/FStar/ulib/fs/prims.fs" /> -->
    <Compile Include="../ulib/FStar/ulib/fs\prims.fs" Link="prims.fs" />
    <Compile Include="../FStar_Pervasives.fs" Link="FStar_Pervasives.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_All.fs" Link="FStar_All.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Char.fs" Link="FStar_Char.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Dyn.fs" Link="FStar_Dyn.fs" /> 
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Float.fs" Link="FStar_Float.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Ghost.fs" Link="FStar_Ghost.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Monotonic_Heap.fs" Link="FStar_Monotonic_Heap.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_CommonST.fs" Link="FStar_CommonST.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Heap.fs" Link="FStar_Heap.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Int16.fs" Link="FStar_Int16.fs" /> 
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Int32.fs" Link="FStar_Int32.fs" /> 
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Int64.fs" Link="FStar_Int64.fs" /> 
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Int8.fs" Link="FStar_Int8.fs" /> 
    <Compile Include="../ulib/FStar/ulib/fs\FStar_IO.fs" Link="FStar_IO.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_List.fs" Link="FStar_List.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_List_Tot_Base.fs" Link="FStar_List_Tot_Base.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Mul.fs" Link="FStar_Mul.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Option.fs" Link="FStar_Option.fs" />
    <Compile Include="../ulib/FStar/ulib/fs\FStar_Pervasives_Native.fs" Link="FStar_Pervasives_Native.fs" />
    <Compile Include="Welcome.fs" />
  </ItemGroup>

</Project>
"@

# if ( -not (Test-Path -Path $fsproj -PathType Leaf ))
# {
    $xml | Out-File -FilePath $fsproj
# }
