import { DeploymentType } from 'src/types';

export function getResourceDeployLabels(): DeploymentType {
    return {
        environments: {
            dev: {
                deploy_resources: {
                    Infrastructure: ['VPC', 'Subnet'],
                    testing: ['Firewalls', 'AccessConnectors'],
                },
            },
        },
    }
}