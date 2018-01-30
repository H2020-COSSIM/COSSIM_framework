# Scripts for easy mount files on GEM5 images 

In order to mount the executables (and other files) on GEM5 images, two scripts are implemented; the first one (mount.sh) in case of local GEM5 execution; the second one (remote_mount.sh) in case of remote GEM5 execution.

## mount.sh

The mount.sh script is used to mount a directory or file inside the GEM5 image which is placed on localhost. It takes 2 exactly parameters (e.g.: ./mount ARCH fullpath/filename), where ARCH is the Architecture (for image selection), while the fullpath/filename is the fullpath and filename of the file (or folder) which will be stored in the corresponding GEM5 image. In ARCH parameter, 6 types are supported:
- X86
- X86-Ubuntu
- ARM32
- ARM32-Ubuntu
- ARM64
- ARM64-Ubuntu

The following command line describes an example of usage (for test_executable application and ARM32 ARCH):

`./mount ARM32 $HOME/Desktop/test_executable`

## remote_mount.sh

The remote_mount.sh script is used to mount a directory or file inside the GEM5 image which is placed on a remote machine. It takes 6 exactly parameters (e.g.: ./remore_mount.sh ARCH fullpath/filename FILE_or_DIR IP Username Password), where ARCH is the Architecture (for image selection), fullpath/filename is the fullpath and filename of the file (or folder) which will be stored in the corresponding GEM5 image, FILE_or_DIR is the type of filename, IP is the static IP in which the GEM5 will be executed, Username and Password are the credentials of this physical machine. In ARCH parameter, 6 types are supported:

- X86
- X86-Ubuntu
- ARM32
- ARM32-Ubuntu
- ARM64
- ARM64-Ubuntu

In FILE_or_DIR parameter, 2 types are supported:
- FILE
- DIR

Specifically, this script upload the FILE or DIR in the machine with IP through sftp, and subsequently, it mounts it in the appropriate GEM5 image depending on ARCH parameter. The following command line describes an example of usage (for test_executable application and ARM32 ARCH):

`./mount ARM32 $HOME/Desktop/test_executable FILE IP Username Password`

## Licensing

Refer to the [LICENSE](LICENSE) file included.

#### Authors

* Nikolaos Tampouratzis (ntampouratzis@isc.tuc.gr)

Please contact for any questions.

## Acknowledgments

Code developed for the H2020-COSSIM project.

