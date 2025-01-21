## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.10.4 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.13.0, < 7.0.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 6.13.0, < 7.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 6.13.0, < 7.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.allow_icmp_ingress_public](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_internal_ingress_public](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_rdp_ingress_public](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_ssh_ingress_public](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_global_address.google_managed_services_range](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.vpc_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.nat_router_us_central1](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.nat_gateway](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.us_central1_subnet](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_project_service.compute_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.serverless_vpc_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.service_networking](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_networking_connection.private_service_access_service_networking](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_vpc_access_connector.functions_connector](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/vpc_access_connector) | resource |
| [google_vpc_access_connector.infra_connector](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/vpc_access_connector) | resource |
| [google_project.current](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to deploy resources | `string` | `"staging"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix to use for all resources | `string` | `"test"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy resources | `string` | `"sonorous-pact-445620-m2"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The project name to deploy resources | `string` | `"VPC-Build-project"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy resources | `string` | `"us-central1"` | no |
| <a name="input_region_abbreviations"></a> [region\_abbreviations](#input\_region\_abbreviations) | n/a | `map` | <pre>{<br/>  "us-central1": "usc1",<br/>  "us-east1": "use1",<br/>  "us-east4": "use4",<br/>  "us-west1": "usw1",<br/>  "us-west2": "usw2",<br/>  "us-west3": "usw3",<br/>  "us-west4": "usw4"<br/>}</pre> | no |

## Outputs

No outputs.
