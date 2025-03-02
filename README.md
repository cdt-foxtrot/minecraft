# Minecraft Time

## Infrastructure Setup
Run `bash make.sh` to create the network and link the containers


## Server Setup
To create the minecraft server:
```
incus shell ansible
su ansible
cd ~/ansible
ansible-playbook -i inventory.ini server.yml
```

To connect to the server console, in a new terminal:
```
incus shell mchost
su ansible
screen -ls
screen -r mc
```

TO DISCONNECT FROM THE SCREEN, RUN `CTRL + A, CTRL + D`.
This leaves the server running in the background


## Client Setup
TODO


## Task List
- [x] Setup infrastructure
- [x] Install server
- [x] Server auto-start
- [x] Server run in background (screen)
- [ ] Install a desktop GUI (ask forest)
- [ ] Install minecraft client
- [ ] Auto-setup an offline account
- [ ] Auto-setup server in the server list
- [ ] Implement achievement tracking
- [ ] Implement injects