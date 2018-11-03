# Juice Box

Designing virtual machine for Python programming using VirtualBox

Based on [jpadilla/juicebox](https://github.com/jpadilla/juicebox)

## Building and Uploading

Requirements:
- [Packer](https://packer.io/)
- [S3cmd](http://s3tools.org/s3cmd)

### Desktop

```
$ make desktop
$ AWS_ACCESS_KEY_ID='' AWS_SECRET_ACCESS_KEY='' make upload/desktop
```

Then, open VirtualBox and "Import Appliance" the Python Box file. 
