# install-wrf


### 01_install_intel_compiler.sh
* 인텔 컴파일러를 이용한 인텔용 wrf 를 설치하기 위해 인텔 컴파일러를 설치하는 스크립트

### 02_install_library.sh
* wrf 설치전 필요한 툴들 설치

* zlib
  * zlib 압축 라이브러리
* hdf5
  * Hierarchical Data Format이며 self-describing이 되는 고성능 데이터포맷 또는 DB
* netcdf-c
  * Network Common Data Form의 약자로 array 형식의 데이터 컨트롤 라이브러리
* netcdf-fortran
  * 
* libpng
  * 정식 PNG 참조 라이브러리
    (한 때 이름은 pnglib)
  * libpng는 PNG 그림을 다루는 데 필요한 C 명령어를 포함하고 있는 플랫폼 독립 라이브러리
* jasper
  * 
* mvapich2
  *


### wrf
* wrf를 설치하기 위해 아래 3단계를 참조한다.
``` bash
$WRF_HOME/clean -a

# configure 후 15, 1 선택
$WRF_HOME/configure 

# change this option DM_FC and DM_CC 
# DM_FC           =       mpiifort -f90=$(SFC)
# DM_CC           =       mpiicc -cc=$(SCC)
vi $WRF_HOME/configure.wrf

$WRF_HOME/compile -j 4 2>&1 | tee compile.log 
```


### wps
* wps를 설치하기 위해 아래 3단계를 참조한다.
``` bash
$WRF_HOME/clean -a

# configure 후 15, 1 선택
$WPS_HOME/configure 

# change this option DM_FC and DM_CC 
# DM_FC               = mpiifort
# DM_CC               = mpiicc
vi $WRF_HOME/configure.wps

$WPS_HOME/compile -j 4 2>&1 | tee compile.log 
```
