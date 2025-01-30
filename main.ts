import { App, TerraformStack, GcsBackend } from "cdktf";
import { GoogleProvider } from "@cdktf/provider-google/lib/provider";
import { ComputeNetwork } from "@cdktf/provider-google/lib/compute-network"
import {ComputeSubnetwork } from "@cdktf/provider-google/lib/compute-subnetwork"
import { ComputeFirewall } from "@cdktf/provider-google/lib/compute-firewall"
import * as fs from 'fs';
import * as path from 'path';
import * as yaml from 'js-yaml'; // Use `npm install js-yaml` to install this

// Read and parse YAML configuration
const args = process.argv.slice(2);
const env = args.includes('--env') ? args[args.indexOf('--env') + 1] : 'dev';

const configPath = path.resolve(__dirname, 'deployment-config.yaml');
const config = yaml.load(fs.readFileSync(configPath, 'utf-8')) as any;

const resourcesToDeploy = config.environments[env]?.deploy_resources;

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

    if (resourcesToDeploy.includes('VPC')) {
    // Create VPC Network
      const vpcNetwork = new ComputeNetwork(this, "MyVpc", {
        name: "my-vpc-network",
        autoCreateSubnetworks: false, // Manual subnet creation
      });
    }

    let vpcSubnet: ComputeSubnetwork | undefined;

    if (resourcesToDeploy.includes('Subnet') && vpcNetwork) {
    // Create Subnet
      vpcSubnet = new ComputeSubnetwork(this, "MySubnet", {
        name: "my-vpc-subnet",
        ipCidrRange: "10.0.1.0/24",  // Replace with your desired CIDR
        network: vpcNetwork.selfLink,      // Link to VPC
        region: region,       // Adjust region as needed
      });
    }

    let firewallRule: ComputeFirewall | undefined;

    if (resourcesToDeploy?.Infrastructure?.includes('Firewall') && vpcNetwork) {
      firewallRule = new ComputeFirewall(this, "MyFirewall", {
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
