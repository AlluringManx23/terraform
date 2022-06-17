var shell = require('shelljs');

const webhook = function (req, res) {
  if(true){
  res.status(200).send('Deployment succesful');
}
  console.log("Destroying old VM");
  shell.exec('terraform -chdir=/home/azureuser/Terraform destroy -auto-approve');
  console.log("Previous VM Destroyed, starting new vm...");
  shell.exec('terraform -chdir=/home/azureuser/Terraform apply -auto-approve');
  console.log("New VM started Transfering, sending setup script");
  setTimeout(() => {
    shell.exec('scp -i /home/azureuser/github_webhook/azurekey /home/azureuser/github_webhook/serversetup.sh ubuntu@car-retal-system.northeurope.cloudapp.azure.com:/home/ubuntu/serversetup.sh');
    console.log("setup script sent, running script");
    shell.exec("ssh -i /home/azureuser/github_webhook/azurekey ubuntu@car-retal-system.northeurope.cloudapp.azure.com 'sh /home/ubuntu/serversetup.sh'");
    console.log("server started");
    shell.exec("rm -rf /home/azureuser/.ssh/known_hosts");
    console.log("server cleanup finished");
  }, 20000);
    
  
};

module.exports = {
  webhook
};
