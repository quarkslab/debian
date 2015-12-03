# Packer templates for Debian (revisited by Quarkslab)

See original repo here: https://github.com/boxcutter/debian.


1. [Boxes informations](#boxes-informations)
2. [Generate Boxes](#generate-boxes)
3. [Security](#security)
    1. [SHA256](#sha256)
    2. [PGP](#pgp)


## Boxes informations

See https://atlas.hashicorp.com/quarkslab/boxes.


| Provider   | Box Name           | Version  | Atlas box link | Signature     | SHA256                                                           |
| :------:   | :------:           | :-----:  | :------------: | :-------:     | :----:                                                           |
| Virtualbox | debian-8.2.0-amd64 | 20151203 | [link][2]      | [link][2.sig] | a16ec1f0454d60a1fd708a6b88498062a4dad223db30aa5df79a6e16e537a081 |
| Libvirt    | debian-8.2.0-amd64 | 20151203 | [link][4]      | [link][4.sig] | a5ff693b1ae44a0837e4b171af51947c484fab889ab918e8b7a2f52f3a5a6daa |
| Virtualbox | debian-7.9.0-amd64 | 20151203 | [link][1]      | [link][1.sig] | e2bb207bc411f07b868af4457b53c13782c5cbecc4f617d73a556cf4030011fc |
| Libvirt    | debian-7.9.0-amd64 | 20151203 | [link][3]      | [link][3.sig] | 1c587d4a5c89831ce4da5049dde364e29d258e4940b5fdd7eeb769eba0f2e959 |


[1]: https://atlas.hashicorp.com/quarkslab/boxes/debian-7.9.0-amd64/versions/20151203/providers/virtualbox.box
[1.sig]: signatures/virtualbox/debian-7.9.0-amd64-nocm-20151203.box.sig
[2]: https://atlas.hashicorp.com/quarkslab/boxes/debian-8.2.0-amd64/versions/20151203/providers/virtualbox.box
[2.sig]: signatures/virtualbox/debian-8.2.0-amd64-nocm-20151203.box.sig
[3]: https://atlas.hashicorp.com/quarkslab/boxes/debian-7.9.0-amd64/versions/20151203/providers/libvirt.box
[3.sig]: signatures/libvirt/debian-7.9.0-amd64-nocm-20151203.box.sig
[4]: https://atlas.hashicorp.com/quarkslab/boxes/debian-8.2.0-amd64/versions/20151203/providers/libvirt.box
[4.sig]: signatures/libvirt/debian-8.2.0-amd64-nocm-20151203.box.sig


Test it with:
```bash
    $ vagrant init quarkslab/<box-name> # for example, replace <box-name> with debian-7.9.0-amd64
    $ vagrant up --provider virtualbox
```


## Generate Boxes

If you want to automatically upload the Vagrant box you’ve created to the [Atlas
platform](https://atlas.hashicorp.com), check the `atlas-quarkslab.json`.

Example:
```bash
    $ export ATLAS_TOKEN=<your-atlas-token> # See https://atlas.hashicorp.com/help/user-accounts/authentication
    $ packer-io build -only=virtualbox-iso -var-file=debian-7.9.0-amd64.json atlas-quarkslab.json
```


## Security

### SHA256

To improve security, you can take advantage of the
``config.vm.box_download_checksum`` [Vagrantfile
option](https://docs.vagrantup.com/v2/vagrantfile/machine_settings.html).

First, you need to verify the integrity of the checksums. As they are part of
the `README.md` file, you need to verify the integrity of this file (See [Security/PGP](#pgp)):

An example of Vagrantfile:
```
[…]
    config.vm.box_url = "https://atlas.hashicorp.com/quarkslab/boxes/debian-7.9.0-amd64/versions/20151203/providers/virtualbox.box"
    config.vm.box_download_checksum = "e2bb207bc411f07b868af4457b53c13782c5cbecc4f617d73a556cf4030011fc"
    config.vm.box_download_checksum_type = "sha256"
[…]
```


### PGP

To verify box integrity of downloaded boxes (located in `~/.vagrant.d/boxes`)
or integrity of the README.md (for SHA256 informations):
```bash
    $ gpg --recv-keys 24CF4A6F
    $ gpg --verify <signature_file> <file_to_verify>

    $ gpg --verify README.md.sig
```
