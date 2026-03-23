<h1 align="center">
  Multiserver Rustdesk Fork
</h1>
<p align="center">
  <em>Rustdesk check 2 server in one-time to connect.</em>
</p>

### **How to install:**
#### Download by script:
```sh
sudo bash -c "$(curl -sL https://raw.githubusercontent.com/danfordd/multiserver-rustdesk-install/main/install.sh)"
```
#### Download by tar archive:
1. Download [archive](https://github.com/danfordd/multiserver-rustdesk-install/releases/download/release/rustdesk-linux-flutter.tar.gz).
2. ```sh
   tar xf rustdesk-linux-flutter.tar.gz
   ```
3. ```sh
   chmod +x ./install_local.sh
   ```
4. ```sh
   sudo ./install_local.sh
   ```

### ***Info***:
P.S1: If you wish to change the second server for the connection, edit the settings in the file located at:
```./libs/hbb_common/src/config.rs```
Change the following:
```FUNTIME_ID_SERVER```
```FUNTIME_RELAY_SERVER```
```FUNTIME_API_SERVER```
```FUNTIME_KEY```

P.S2: Also, within the app itself, DO NOT ADD A SERVER to the ***Network*** tab
