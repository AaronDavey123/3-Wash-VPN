# 3-Wash VPN - Multi-VPC Tunnel Architecture

This project implements a **3-Wash VPN** architecture using AWS (or any cloud platform) to provide a multi-layered tunneling system that enhances privacy and obfuscation. The setup leverages **WireGuard** to tunnel traffic through three distinct VPCs across different regions, providing robust privacy through multiple routing paths. The deployment is automated using **Terraform**, allowing you to create the entire infrastructure with a single command.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
  - [Deployment](#deployment)
  - [Connecting to the VPN](#connecting-to-the-vpn)
- [Customization](#customization)
- [Security Considerations](#security-considerations)
- [Contributing](#contributing)
- [License](#license)

## Overview

The **3-Wash VPN** is a multi-region, multi-VPC VPN setup designed to enhance security and privacy by routing traffic through three different Virtual Private Clouds (VPCs) across distinct AWS regions. By using **WireGuard**, a modern and secure VPN protocol, it ensures encrypted and high-performance tunneling. The final VPN endpoint resides in the last VPC, allowing users to connect securely from any location while obfuscating the routing path.

This architecture hides client routing by ensuring that traffic traverses multiple regions before reaching its final destination, making it extremely difficult for external parties to trace traffic back to its origin.

## Features

- **Three-layer VPC routing**: Tunnels traffic through three distinct VPCs, each in a different region.
- **Obfuscation and Privacy**: Each layer adds an extra level of obfuscation, making it hard to track.
- **WireGuard Integration**: Uses WireGuard for secure, fast, and efficient VPN connections.
- **Terraform Automation**: Automatically deploy the entire infrastructure using Terraform.
- **Scalable and Customizable**: Easily modify regions, VPC configurations, and instance sizes.
- **Cross-Platform**: Works with any cloud provider supporting VPCs and Terraform.

## Architecture

1. **Three VPCs**: Each located in a separate AWS region.
   - **VPC 1**: The entry point for traffic, responsible for forwarding it to VPC 2.
   - **VPC 2**: The middle VPC, routing traffic to VPC 3.
   - **VPC 3**: The exit point, containing the final VPN subnet where the WireGuard VPN endpoint resides.

2. **WireGuard VPN**: Installed at the final subnet in VPC 3, allowing the client to connect after traffic has passed through multiple layers of routing.

3. **Routing & Tunneling**: WireGuard tunnels are established between each VPC for secure traffic flow.

   ![Architecture](docs/architecture-diagram.png) <!-- Optional: Insert a network diagram here -->

## Prerequisites

- **Terraform**: Ensure you have Terraform installed. You can download it [here](https://www.terraform.io/downloads.html).
- **AWS Account**: If using AWS, you need an account with necessary permissions to create VPCs, subnets, and EC2 instances.
- **WireGuard**: WireGuard needs to be installed locally to configure the VPN connection.
- **AWS CLI**: To configure AWS credentials and region details.

### Tools Required:
- Terraform
- WireGuard
- AWS CLI (or your preferred cloud CLI)

## Setup

### Deployment

1. **Clone the repository**:

   ```bash
   git clone https://github.com/AaronDavey123/3-wash-vpn.git
   cd 3-wash-vpn

2. Configure AWS CLI (for AWS-based deployments):
   ```bash
   aws configure

3. Initaize and Apply Terraform
   ```bash
   terraform init
   terraform apply

4. View Outputs
   ```bash
   terraform output

### Connecting to the VPN

1. Configure WireGuard on your client machine with the provided configuration file.
Use the config file (e.g., wg0.conf) generated by Terraform to establish a connection.
Example of starting the WireGuard interface:

    ```bash
    sudo wg-quick up wg0.conf

2. Test Connectivity
   After setting up the VPN, test connectivity and routing to ensure your traffic passes through all three VPCs.


## Customization

You can modify the following parameters in the Terraform configuration file (variables.tf) to customize the setup:

- VPC Regions: Change the AWS regions where VPCs are created.
- Instance Types: Adjust the EC2 instance sizes based on your performance requirements.
- Subnets and CIDR Blocks: Modify the networking details of each VPC.


## Security Considerations
Encryption: All traffic between the VPCs is encrypted using WireGuard, ensuring security between each hop.
Private Subnets: Consider using private subnets in each VPC to further isolate the network.
Access Control: Ensure the VPN is locked down and only accessible by authorized clients via appropriate security groups.



## Contributing
Contributions are welcome! If you would like to contribute to the project:

1. Fork this repository.
2. Create a new branch for your feature or bugfix (git checkout -b feature-branch).
3. Commit your changes (git commit -m 'Add new feature').
4.Push to your branch (git push origin feature-branch).
5. Open a pull request.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

   