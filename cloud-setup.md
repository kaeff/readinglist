# Cloud setup

### Docker Machine && EC2

Strategy: Manage a single remote docker host with docker-machine, build & provision directly with docker-compose

1) Create an EC2 instance using docker-machine.
Use an older AMI since the latest one didn't work, see [this bug](https://github.com/docker/machine/issues/3930). The AMI is region-dependant, find it on the [AWS Driver for docker-machine docs](https://docs.docker.com/machine/drivers/aws/).
```
docker-machine create --driver amazonec2  --amazonec2-region eu-central-1 --amazonec2-ami ami-597c8236 readlists
```

2) Open port 80
```
aws --region eu-central-1 ec2 authorize-security-group-ingress --group-name docker-machine  --protocol tcp --port 80 --cidr 0.0.0.0/0 --region eu-central-1
```

3) Bring up cluster
```
eval `docker-machine env readlists`
docker-compose up -d
```

### Elastic Container Service && docker-compose
```
ecs-cli configure -r eu-west-1 -c readlists-cluster
AWS_REGION=eu-west-1 ecs-cli up --keypair aws-kfleerko-readlists --capability-iam
```

Create repositories for all services in docker-compose.yml
```
$services=`ruby -ryaml -e  "puts YAML.load_file('docker-compose.yml')['services'].keys.map {|s| File.basename(Dir.pwd) + '_' + s }"`
while read -r s; do
  docker tag $s\:latest 086938273106.dkr.ecr.eu-west-1.amazonaws.com/$s\:latest
  docker push 086938273106.dkr.ecr.eu-west-1.amazonaws.com/$s\:latest
done <<< "$services"
```

Then stopped since I couldn't reach the started containers
