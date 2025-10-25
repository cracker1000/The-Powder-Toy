cd /d C:\The-Powder-Toy
meson setup -Dbuildtype=release -Dstatic=prebuilt -Db_vscrt=static_from_buildtype build-release-static
cd build-release-static
cls
meson compile
cmd /k