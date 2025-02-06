import { App, TerraformStack, GcsBackend } from "cdktf";
import { GoogleProvider } from "@cdktf/provider-google/lib/provider";
import { ComputeNetwork } from "@cdktf/provider-google/lib/compute-network"
import {ComputeSubnetwork } from "@cdktf/provider-google/lib/compute-subnetwork"
import { ComputeFirewall } from "@cdktf/provider-google/lib/compute-firewall"
import { getResourceDeployLabels } from 'src/utils'

const env = 'dev';
// Read and parse YAML configuration
const resourceListToDeploy = getResourceDeployLabels();
const resourcesToDeploy = resourceListToDeploy.environments[env]?.deploy_resources;

// import { TerraformOutput } from "cdktf";

class MyNetworkStack extends TerraformStack {
  constructor(scope: App, id: string) {
    super(scope, id);

    const project = process.env.PROJECT_ID || "sonorous-pact-445620-m2";
    const region = process.env.PROJECT_REGION || "us-central1";

    console.log(`Project: ${project}`);
    console.log(`Region: ${region}`);

    // Set up Google Cloud provider
    new GoogleProvider(this, "Google", {
      project: project,
      region: region
    });

    new GcsBackend(this, {
      bucket: "terraform-gcp-githubactions-state",
      prefix: "cdktf-ts-sonorous-pact-445620-m2/",
    });

    let vpcNetwork: ComputeNetwork | undefined;

    if (resourcesToDeploy.Infrastructure.includes('VPC')) {
    // Create VPC Network
      vpcNetwork = new ComputeNetwork(this, "MyVpc", {
        name: "my-vpc-network",
        autoCreateSubnetworks: false, // Manual subnet creation
      });
    }


    if (resourcesToDeploy.Infrastructure.includes('Subnet') && vpcNetwork) {
    // Create Subnet
      new ComputeSubnetwork(this, "MySubnet", {
        name: "my-vpc-subnet",
        ipCidrRange: "10.0.1.0/24",  // Replace with your desired CIDR
        network: vpcNetwork.selfLink,      // Link to VPC
        region: region,       // Adjust region as needed
      });
    }


    if (resourcesToDeploy.testing.includes('Firewalls') && vpcNetwork) {
      new ComputeFirewall(this, "MyFirewall", {
        name: "my-firewall",
        network: vpcNetwork.selfLink,
        allow: [{ protocol: "tcp", ports: ["22", "80", "443"] }],
      });
    }

//   new TerraformOutput(this, "VpcNetworkName", {
//     value: vpcNetwork.name,
//   });
  
//   new TerraformOutput(this, "VpcSubnetName", {
//     value: "my-vpc-subnet",
//   });
  }
}

const app = new App();
new MyNetworkStack(app, "MyNetworkStack");
app.synth();
