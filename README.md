  # Bastion Host Setup

## Scenario

X Company is launching a new image generator application, Image AI, that will be deployed in its own SDLC account in AWS. The Y team has requested a bastion host setup in the new account for follow-on activities. This README provides instructions and information on how to set up the Bastion host using Terraform.

## Tools and Technologies Used

- [Terraform](https://www.terraform.io/): An Infrastructure as Code (IaC) tool used to define and provision infrastructure in a safe and predictable manner.
- [Visual Studio Code](https://code.visualstudio.com/): Visual Studio Code is a streamlined code editor with support for development operations like debugging, task running, and version control.
- [Amazon Web Services](https://aws.amazon.com/free/?trk=fce796e8-4ceb-48e0-9767-89f7873fac3d&sc_channel=ps&ef_id=Cj0KCQjwrfymBhCTARIsADXTabkalPCvRXzDI_eSDxPLtOJNXKPgBySsTRQ-nXb763ZBCeP-H5gxCZUaArpSEALw_wcB:G:s&s_kwcid=AL!4422!3!432339156150!e!!g!!aws!1644045032!68366401852&all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all): 
AWS (Amazon Web Services) is a comprehensive, evolving cloud computing platform provided by Amazon that includes a mixture of infrastructure-as-a-service (IaaS), platform-as-a-service (PaaS) and packaged-software-as-a-service (SaaS) offerings.
  
## Installation Instructions (macOS)

1. **Install Homebrew (if not already installed)**

   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)

2. **Install Terraform via Homebrew**

   ```sh
   brew tap hashicorp/tap
   brew install hashicorp/tap/terraform

3. **Configure AWS Profile**

   Ensure you have your AWS Access Key ID and Secret Access Key ready. Configure the AWS CLI with your credentials
   ```sh
   aws configure

## **Steps for solving the scenario**

1. **AWS Account Setup:**
   Ensure you have a new AWS account ready for the SDLC environment. Obtain the AWS Access Key ID and Secret Access Key for this account.

2. **Git Repository Setup:**
   Create a new Git repository where you'll store your Terraform configuration files.

3. **Create Terraform Configuration Files:**

 * provider.tf: Configure the AWS provider with the appropriate region and profile for your new AWS account.

 * variables.tf: Define variables for your configuration, Created the following variables region,default profile, instance type, AMI Id and Bastion host's allowed SSH IP range(Here we are taking this as an input but we can give default CIDR as well)

 * vpc.tf: Create a VPC with a specified CIDR block, allowing the definition of an isolated network environment. Within this VPC, a public subnet is established with a specific CIDR block, enabling the launching of instances with automatic public IP assignment. An AWS Internet Gateway is also created and associated with the VPC, allowing network traffic to flow between the VPC and the public Internet. Additionally, a route table is created within the VPC, which directs all traffic with a destination CIDR block of "0.0.0.0/0" to the Internet Gateway, enabling outgoing Internet connectivity for resources in the public subnet. Finally, the public subnet is associated with this route table, ensuring that instances within it follow the defined routing rules for Internet-bound traffic.

 * Key.tf : This will generates a TLS private key, creates an AWS key pair associated with it, and generates a PEM file from the private key. This PEM file can be used for SSH access to AWS instances launched with the corresponding key pair

 * instance.tf: This Terraform resource block configures the launch of an AWS EC2 instance named "bastion." It specifies the Amazon Machine Image (AMI) based on the chosen region, the instance type, the subnet where the instance will be placed, the associated security group allowing SSH access, the SSH key pair for authentication, and assigns a descriptive tag to the instance, streamlining the provisioning and management of this EC2 instance within the AWS environment

 * securitygroup.tf: This Terraform configuration defines an AWS security group named "bastion-allow-ssh." It is associated with a specific VPC (aws_vpc.main.id) and is designed to facilitate secure SSH access to a bastion host. The security group allows SSH traffic (TCP port 22) from a specified source IP address (var.bastion-allow-ip) and permits all egress traffic. A tag "bastion-allow-ssh" is added for identification and management purposes


4.  **SSH into Bastion Host:**
    After successful provisioning, use the private key generated by Terraform to SSH into the Bastion host

## Execution Instructions

1. Clone this repository:

   ```sh
   git clone https://github.com/vaish0299/Assessment_HU.git

2. Navigate to the project directory:

   ```sh
   cd Assessment_HU

3. Initialize Terraform:

   ```sh
   terraform init

4. terraform plan

   ```sh
   terraform plan

5. terraform apply

   ```sh
   terraform apply

   Once "terraform apply" is run, the aforementioned resources would be created using the default variables.

   In order to create the above network stack using self-defined variables, you may customize the command mentioned below and run it:
   terraform apply -var='profile=aws' You can replace profile=aws in the above example with variable_name=value

   If you have created resources using custom variables, make sure to pass the variables as well with the above command

6. Follow the SSH instructions to access the Bastion host.

7. To destroy the resources when no longer needed:

   ```sh
   terraform destroy
