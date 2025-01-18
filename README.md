# Ansible Playbook for Managing Proxmox VMs

This project contains an Ansible playbook for managing virtual machines (VMs) on a Proxmox cluster. The playbook can start or stop VMs based on tags passed as parameters, and it is designed to be flexible and configurable for different clusters and VMs.

## Prerequisites

Before running this playbook, you need:

- A Proxmox server with the required API information (user, token, etc.).

- Ansible installed on your management machine.

  > ```shell
  > python3 -m venv venv
  > source venv/bin/activate
  > pip install -r requirements.txt
  > ```
  >
  > :eyes: [configure pre-commit hook](https://xgueret.github.io/en/posts/pre_commit_hook/)
  >

  

- The `community.general.proxmox_kvm` Ansible module installed to interact with the Proxmox API.

- A `vault/proxmox_vars.yml` file containing sensitive information (like the Proxmox API user and token).

- A `vars/cluster_vms.yml` file defining the clusters and VMs to manage.

## Project Structure

```
.
├── vault/
│   └── proxmox_vars.yml  # Contains Proxmox authentication information
├── vars/
│   ├── main.yml  # Main variables for configuration
│   └── cluster_vms.yml  # List of clusters and their VMs
└── configure_vms.yml  # Main playbook

```

## Variables

### `vault/proxmox_vars.yml`

This file contains the Proxmox API authentication details. Example:

```yaml
proxmox_user: "your-proxmox-user"
proxmox_token_id: "your-token-id"
proxmox_token_secret: "your-token-secret"
proxmox_node_name: "your-proxmox-node"
```

### `vars/cluster_vms.yml`

This file defines clusters and their associated VMs as a list. Example:

```yaml
cluster_vms:
  kubeBeast:
    vms:
      - ...
  sandbox:
    vms:
      - ...
  neutron:
    vms:
      - ...
```

### `vars/main.yml`

This file can contain other general configuration variables. For example:

```yaml
# General variables, modify as needed
selected_cluster: "cluster_k8s"
```

## VM State Management (`state_action`)

The playbook now uses the `state_action` variable to control the state of the VMs. The `state_action` can be set to:

- **started**: Start the VMs.
- **stopped**: Stop the VMs.

If no `state_action` is provided, the default action will be to stop the VMs (`stopped`).

### Example execution with `state_action=stopped`

To stop the VMs of a cluster:

```shell
ansible-playbook configure_vms.yml -e "selected_cluster=sandbox state_action=stopped"
```

### Example execution with `state_action=started`

To start the VMs of a cluster:

```shell
ansible-playbook configure_vms.yml -e "selected_cluster=sandbox state_action=started"
```

## Running the Playbook

You need to specify which cluster to use via the `selected_cluster` variable and which action to take (`started` or `stopped`) via the `state_action` variable. You can either define these variables in the `vars/main.yml` file or pass them as command-line arguments.

Example to run the playbook for a specific cluster and action:

```shell
ansible-playbook configure_vms.yml -e "selected_cluster=cluster_k8s state_action=started"
```

This will run the playbook to start the VMs of the `cluster_k8s` cluster.

## Troubleshooting

If you encounter authentication errors related to the Proxmox API, make sure that the credentials in `vault/proxmox_vars.yml` are correct and that your user has the necessary permissions on the Proxmox server.

If the playbook fails to start or stop VMs, verify that the VM IDs are correctly defined in the `vars/cluster_vms.yml` file and that the cluster information is accurate.

## Contributing

Contributions are welcome! If you want to add features or fix bugs, feel free to open a **pull request**.
