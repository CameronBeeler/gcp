export type DeploymentType = {
  environments: {
    dev: {
      deploy_resources: {
        Infrastructure: string []
        testing: string []
      };
    };
  };
};
