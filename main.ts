import { TerraformOutput } from "cdktf";
import { App, TerraformStack } from "cdktf";
import { GoogleProvider } from "@cdktf/provider-google/lib/provider";
import { ComputeNetwork } from "@cdktf/provider-google/lib/compute-network"
import {ComputeSubnetwork } from "@cdktf/provider-google/lib/compute-subnetwork"

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

    // Create VPC Network
    const vpcNetwork = new ComputeNetwork(this, "MyVpc", {
      name: "my-vpc-network",
      autoCreateSubnetworks: false, // Manual subnet creation
    });

    // Create Subnet
    new ComputeSubnetwork(this, "MySubnet", {
      name: "my-vpc-subnet",
      ipCidrRange: "10.0.1.0/24",  // Replace with your desired CIDR
      network: vpcNetwork.selfLink,      // Link to VPC
      region: region,       // Adjust region as needed
    });

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